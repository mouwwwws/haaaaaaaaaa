.class public Lcom/sukuna/KeyAuth;
.super Ljava/lang/Object;
.field public static isVerified:Z
.field public static isChecking:Z
.field private static final lock:Ljava/lang/Object;
.method static constructor <clinit>()V
.registers 1
new-instance v0, Ljava/lang/Object;
invoke-direct {v0}, Ljava/lang/Object;-><init>()V
sput-object v0, Lcom/sukuna/KeyAuth;->lock:Ljava/lang/Object;
const/4 v0, 0x0
sput-boolean v0, Lcom/sukuna/KeyAuth;->isVerified:Z
sput-boolean v0, Lcom/sukuna/KeyAuth;->isChecking:Z
return-void
.end method
.method public constructor <init>()V
.registers 1
invoke-direct {p0}, Ljava/lang/Object;-><init>()V
return-void
.end method
.method public static check(Landroid/app/Activity;)V
.registers 6
sget-boolean v0, Lcom/sukuna/KeyAuth;->isVerified:Z
if-nez v0, :verified_return
return-void
:verified_return
sget-object v5, Lcom/sukuna/KeyAuth;->lock:Ljava/lang/Object;
monitor-enter v5
:try_block
sget-boolean v0, Lcom/sukuna/KeyAuth;->isVerified:Z
if-nez v0, :is_already_checking
monitor-exit v5
return-void
:is_already_checking
sget-boolean v0, Lcom/sukuna/KeyAuth;->isChecking:Z
if-nez v0, :is_checking_release_lock
monitor-exit v5
return-void
:is_checking_release_lock
const/4 v0, 0x1
sput-boolean v0, Lcom/sukuna/KeyAuth;->isChecking:Z
monitor-exit v5
const-string v0, sukuna_prefs
const/4 v1, 0x0
invoke-virtual {p0, v0, v1}, Landroid/app/Activity;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;
move-result-object v0
const-string v1, auth_key
const-string v2, 
invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
move-result-object v0
invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z
move-result v1
if-eqz v1, :verify_key
invoke-static {p0}, Lcom/sukuna/KeyAuth;->showKeyDialog(Landroid/app/Activity;)V
return-void
:verify_key
invoke-static {p0, v0}, Lcom/sukuna/KeyAuth;->verifyFromServer(Landroid/app/Activity;Ljava/lang/String;)V
return-void
.end method
.method public static showKeyDialog(Landroid/app/Activity;)V
.registers 6
const/4 v0, 0x0
sput-boolean v0, Lcom/sukuna/KeyAuth;->isChecking:Z
new-instance v0, Landroid/app/AlertDialog$Builder;
invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V
const-string v1, SUKUNA PROJECT
invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
const-string v1, Lutfen gecerli bir anahtar giriniz:
invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;
new-instance v1, Landroid/widget/EditText;
invoke-direct {v1, p0}, Landroid/widget/EditText;-><init>(Landroid/content/Context;)V
const-string v2, SUKUNA-XXXX
invoke-virtual {v1, v2}, Landroid/widget/EditText;->setHint(Ljava/lang/CharSequence;)V
invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;
const-string v2, Giris Yap
new-instance v3, Lcom/sukuna/KeyDialogListener;
invoke-direct {v3, p0, v1}, Lcom/sukuna/KeyDialogListener;-><init>(Landroid/app/Activity;Landroid/widget/EditText;)V
invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
const-string v2, Cikis
new-instance v3, Lcom/sukuna/KeyAuth$1;
invoke-direct {v3, p0}, Lcom/sukuna/KeyAuth$1;-><init>(Landroid/app/Activity;)V
invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;
const/4 v1, 0x0
invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;
invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;
return-void
.end method
.method public static verifyFromServer(Landroid/app/Activity;Ljava/lang/String;)V
.registers 3
new-instance v0, Lcom/sukuna/AuthThread;
invoke-direct {v0, p0, p1}, Lcom/sukuna/AuthThread;-><init>(Landroid/app/Activity;Ljava/lang/String;)V
invoke-virtual {v0}, Lcom/sukuna/AuthThread;->start()V
return-void
.end method