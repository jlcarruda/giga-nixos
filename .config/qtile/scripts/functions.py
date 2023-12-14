import subprocess

def screenshot(qtile):
  subprocess.run("flameshot gui --path ~/Pictures/area_screenshot.png --delay 400",shell=True)

def get_net_dev():
  get_dev = "echo $(ip route get 8.8.8.8 | awk -- '{printf $5}')"
  ps = subprocess.Popen(get_dev,shell=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
  output = ps.communicate()[0].decode('ascii').strip()
  return(output)