#import "iPhoneLoginController.h"
#import "SBJson.h"
  
@interface iPhoneLoginController()

@end
  
@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end
  
  
@implementation iPhoneLoginController

@synthesize name,password,editedFieldKey, saveInfo, Switch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(IBAction)onOffSwitch:(id)sender{
    
    if(Switch.isOn){
        NSLog(@"okoko 1");
    }
    else{
        NSLog(@"okoko 2");
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: NSLocalizedString(@"background_images", nil)]];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"settings_back_btn", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    
    //Pega diretorio do banco
    NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,
                                                             YES) objectAtIndex:0];
    NSString *dbPath = [dirPath stringByAppendingPathComponent:@"sino.sqlite"];
    
    if (sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK)
    {
        const char *sql = "SELECT * FROM tbl_usuario";
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
        {
            NSLog(@"Erro ao consultar banco");
        }
        else
        {
            while (sqlite3_step(sqlStatement)==SQLITE_ROW)
            {
                name.text = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,5)];
                password.text = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,4)];
                [saveInfo setTitle:@"Sair" forState:UIControlStateNormal];
                
            }
        }
    }
    sqlite3_close(db);
    
    
    
}



-(void)backBtnAction{
    [self dismissModalViewControllerAnimated:YES];
}

- (void) alertStatus:(NSString *)msg :(NSString *) title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}


- (IBAction)save:(id)sender {
    @try {
        
        if([saveInfo.currentTitle isEqual: @"Sair"])
        {

            name.text = @"";
            password.text = @"";
            
            [saveInfo setTitle:@"Entrar" forState:UIControlStateNormal];
            
            //Pega diretorio do banco
            NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *dbPath = [dirPath stringByAppendingPathComponent:@"sino.sqlite"];
            
            //Apaga dados do bd usuario
            if((sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
            {
                NSLog(@"teste: %@",@" okok");
                char *zErrMsg = 0;
                sqlite3_exec( db, "DELETE FROM tbl_usuario", NULL, NULL, &zErrMsg );
            }
            sqlite3_close(db);
            
        }
        else
        {
            if([[name text] isEqualToString:@""] || [[password text] isEqualToString:@""] ) {
                [self alertStatus:@"Por favor digite usuário e senha" :@"Login Failed!"];
            } else {
                NSString *post =[[NSString alloc] initWithFormat:@"nome=%@&password=%@&tag=login",[name text],[password text]];
                NSLog(@"PostData: %@",post);
                
                NSURL *url=[NSURL URLWithString:@"http://www.sinosistema.net/sgc/android_webservice/index_ios.php"];
                
                NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                
                NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:url];
                [request setHTTPMethod:@"POST"];
                [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
                [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
                [request setHTTPBody:postData];
                
                [NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
                
                NSError *error = [[NSError alloc] init];
                NSHTTPURLResponse *response = nil;
                NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                
                NSLog(@"Response code: %d", [response statusCode]);
                if ([response statusCode] >=200 && [response statusCode] <300)
                {
                    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    SBJsonParser *jsonParser = [SBJsonParser new];
                    NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:responseData error:nil];
                    
                    //Recebe os parametros do json
                    NSInteger success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
                    NSString *nome = [[jsonData objectForKey:@"user"] objectForKey:@"name"];
                    NSString *uid = [jsonData objectForKey:@"uid"];
                    NSString *uid_pessoa = [jsonData objectForKey:@"uid_pessoa"];
                    NSString *imagem_cliente = [jsonData objectForKey:@"imagem_cliente"];
                    
                    if(success == 1)
                    {
                        @try {
                            
                            
                            //Pega diretorio do banco
                            NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                                     NSUserDomainMask,
                                                                                     YES) objectAtIndex:0];
                            NSString *dbPath = [dirPath stringByAppendingPathComponent:@"sino.sqlite"];
                            
                            if(!(sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK))
                            {
                                NSLog(@"Erro ao inserir dados no banco.");
                            }
                            if (sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK)
                            {
                                NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO tbl_usuario (nome, uid, uid_pessoa, senha, usuario, imagem_cliente) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", nome, uid, uid_pessoa, [password text], [name text], imagem_cliente ];
                                char *error;
                                
                                if ( sqlite3_exec(db, [insertStatement UTF8String], NULL, NULL, &error) == SQLITE_OK)
                                {
                                    //FAZ Download da imagem
                                    NSURL *url = [NSURL URLWithString: imagem_cliente];
                                    [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
                                        if (succeeded) {
                                            NSLog(@"IMAGEM BAIXADA");
                                        }
                                    }];
                                    
                                    [self alertStatus: @" " : @"Login efetuado com sucesso!"];
                                    [saveInfo setTitle:@"Sair" forState:UIControlStateNormal];
                                    [self.view endEditing:YES];
                                }
                                sqlite3_close(db);
                            }
                            else
                            {
                                NSLog(@"Problema ao abrir tbl");
                            }
                        }
                        @catch (NSException *exception) {
                            NSLog(@"An exception occured: %@", [exception reason]);
                        }
                        
                        
                    } else {
                        
                        NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                        [self alertStatus:error_msg :@"Usuário ou senha incorretos!"];
                    }
                    
                } else {
                    if (error) NSLog(@"Error: %@", error);
                    [self alertStatus:@"Connection Failed" :@"Login Failed!"];
                }
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Login Failed." :@"Login Failed!"];
    }
}

//http://fung20052006.blogspot.com.br/2013/02/ios-download-image-from-url.html
//FUNCAO PARA SALVAR IMAGEM NO DISPOSITIVO
- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

- (IBAction)backgroundClick:(id)sender {
    [password resignFirstResponder];
    [name resignFirstResponder];
    NSLog(@"OKOKOKOK");
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidUnload {
    [self setPassword:nil];
    [super viewDidUnload];
}

@end