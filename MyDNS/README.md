# MyDNS用 DNS自動更新スクリプト

## Windows PowerShellで更新する方法

Windows環境でMyDNS.JPにIPアドレスを定期通知するには、以下の手順でPowerShellスクリプトをタスクスケジューラに登録することで自動化できます。

### 手動でタスクスケジューラに登録する方法

1. **スクリプトファイルを用意する**
   例: `update-mydns.ps1` という名前でPowerShellスクリプトを任意の場所に保存します。

2. **PowerShellの実行ポリシーを確認・変更（初回のみ）**
   スクリプトが実行できるように、以下のコマンドをPowerShell（管理者として実行）で実行します：

   ```powershell
   Set-ExecutionPolicy RemoteSigned
   ```

3. **タスクスケジューラを起動する**
   `Win + S` キーで検索バーを開き、「タスクスケジューラ」と入力して起動します。

4. **基本タスクの作成**

   * 「タスクスケジューラライブラリ」右ペインの「基本タスクの作成」をクリック
   * 任意の名前を入力（例: `MyDNS更新タスク`）
   * 「次へ」でトリガー（毎日、毎時間など）を設定

5. **操作を設定**

   * 「操作を開始する」で「プログラムの開始」を選択
   * 「プログラム/スクリプト」欄に以下を入力：

     ```
     powershell
     ```
   * 「引数の追加」欄に以下を入力（ファイルパスは保存先に応じて変更してください）：

     ```
     -ExecutionPolicy Bypass -File "C:\Path\To\update-mydns.ps1"
     ```

6. **完了**

   * 「次へ」で内容を確認し、「完了」をクリック
   * タスクスケジューラの一覧に登録され、指定したスケジュールで自動実行されます

---

### 自動登録スクリプトを使う方法（推奨）

以下のスクリプトを実行することで、毎時1回MyDNS更新スクリプトを自動で実行するタスクがタスクスケジューラに登録されます。

```powershell
# 自動登録スクリプト
$taskName = "MyDNS Auto Updater"
$scriptPath = "C:\\Path\\To\\update-mydns.ps1"  # スクリプトのパスを適宜変更してください

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `\"$scriptPath`\""
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date.AddMinutes(1) -RepetitionInterval (New-TimeSpan -Hours 1) -RepetitionDuration ([TimeSpan]::MaxValue)

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Description "Updates global IP to MyDNS.JP every hour" -User "$env:USERNAME" -RunLevel Lowest
```

> [!NOTE]
> 実行前に `$scriptPath` をご自身の `.ps1` ファイルの絶対パスに変更してください。

> [!WARNING]
> 管理者権限が必要な場合があります。PowerShellを"管理者として実行"してください。

> [!TIP]
> スケジュールを変更したい場合は、`-RepetitionInterval` の値を `-Minutes 30` や `-Days 1` に調整してください。