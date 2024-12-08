[Setup]
AppName=multiBASH
AppVersion=1.0
DefaultDirName={pf}\multiBASH
DefaultGroupName=multiBASH
OutputBaseFilename=multiBASHInstaller
Compression=zip
SolidCompression=no
AppPublisher=multiBASH Team
AppPublisherURL=https://github.com/Xamo-maker
AppSupportURL=https://github.com/Xamo-maker
AppUpdatesURL=https://github.com/Xamo-maker


[Icons]
Name: "{group}\multiBASH"; Filename: "{app}\multiBashv1.0.exe"
Name: "{group}\Uninstall multiBASH"; Filename: "{uninstallexe}"
Name: "{commondesktop}\multiBASH"; Filename: "{app}\multiBashv1.0.exe"; Tasks: desktopicon

[Tasks]
Name: "desktopicon"; Description: "Créer un raccourci sur le bureau"; Flags: unchecked

[UninstallDelete]
Type: files; Name: "{app}\*.*"
Type: dirifempty; Name: "{app}"

[Code]
var
  AcceptCheckBox: TCheckBox;
  LicensePage: TWizardPage;

// Vérifie si la case est cochée avant de passer à la page suivante
function ShouldProceed(): Boolean;
begin
  if not AcceptCheckBox.Checked then
  begin
    MsgBox('Vous devez accepter les conditions d''utilisation pour continuer.', mbError, MB_OK);
    Result := False;
  end
  else
    Result := True;
end;

// Procédure appelée lors de chaque tentative de changement de page
function NextButtonClick(CurPageID: Integer): Boolean;
begin
  // Si l'utilisateur est sur la page des conditions, vérifiez la case
  if CurPageID = LicensePage.ID then
    Result := ShouldProceed()
  else
    Result := True;
end;

// Initialisation de l'assistant d'installation
procedure InitializeWizard;
begin
  // Crée une page personnalisée pour afficher les conditions d'utilisation
  LicensePage := CreateCustomPage(wpWelcome, 'Conditions d''utilisation', 
    'Veuillez lire et accepter les conditions d''utilisation ci-dessous :');
  
  // Ajouter une case à cocher sur la page
  AcceptCheckBox := TCheckBox.Create(LicensePage);
  AcceptCheckBox.Parent := LicensePage.Surface;
  AcceptCheckBox.Left := 0;
  AcceptCheckBox.Top := 20;
  AcceptCheckBox.Width := LicensePage.SurfaceWidth;
  AcceptCheckBox.Caption := 'J''accepte les conditions d''utilisation.';

  // Ajouter les conditions d'utilisation sous forme de texte
  with TLabel.Create(LicensePage) do
  begin
    Parent := LicensePage.Surface;
    AutoSize := False;
    Left := 0;
    Top := 60;
    Width := LicensePage.SurfaceWidth;
    Height := LicensePage.SurfaceHeight - 80; // Ajuste la hauteur selon l'espace disponible
    WordWrap := True;
    Caption :=
      'Conditions d''utilisation :' + #13#10 +  
      '1. Licence MIT' + #13#10 + 
      'Ce logiciel est fourni sous la licence MIT. Vous êtes libre de l''utiliser, de le modifier et de le distribuer selon les termes de cette licence.' + #13#10#13#10 +
      '2. Aucune garantie' + #13#10 +
      'Le logiciel est fourni "tel quel", sans aucune garantie, expresse ou implicite, y compris mais sans s''y limiter, les garanties de qualité marchande et d''adéquation à un usage particulier. En aucun cas, l''auteur ou les titulaires des droits d''auteur ne pourront être tenus responsables de toute réclamation, dommage ou autre responsabilité, que ce soit dans une action en contrat, délit ou autre, découlant de l''utilisation du logiciel.' + #13#10#13#10 +
      '3. Responsabilité' + #13#10 +
      'L''utilisateur assume l''entière responsabilité de l''utilisation du logiciel. L''auteur du logiciel ne sera en aucun cas responsable des conséquences négatives liées à l''utilisation de ce logiciel, y compris les pertes de données, les erreurs d''exécution ou tout autre problème.' + #13#10#13#10 +
      '4. Modifications et redistribution' + #13#10 +
      'Vous êtes autorisé à modifier, utiliser, et redistribuer ce logiciel sous les termes de la licence MIT. Vous devez inclure la licence dans toutes les copies du logiciel ou dans des portions substantielles de celui-ci.' + #13#10#13#10 +
      '5. Acceptation' + #13#10 +
      'En installant ce logiciel, vous acceptez d''être lié par les termes de cette licence. Si vous n''acceptez pas ces conditions, vous ne devez pas installer ce logiciel.';
  end;
end;