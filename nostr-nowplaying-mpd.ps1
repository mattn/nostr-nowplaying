[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$mpd_host = $env:MPD_HOST
if (-not $mpd_host) {
  $mpd_host = "127.0.0.1"
}

while ($true) {
  $title = mpc -h $mpd_host current --wait
  if (-not $title) {
    continue
  }
  $title_enc = [System.Uri]::EscapeDataString($title) 
  $epoch = [Math]::Floor((New-TimeSpan -Start (Get-Date "01/01/1970") -End (Get-Date)).TotalSeconds+300)
  algia event --kind 30315 --content "$title" --tag d=music --tag "expiration=$epoch" --tag "r=spotify:search:$title_enc"
}
