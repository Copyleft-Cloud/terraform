# CREATE A NEW DROPLET

resource "digitalocean_droplet" "hubot" {
    image = "ubuntu-16-04-x64"
    name = "hubot.svc.nyc.copyleft.io"
    region = "nyc3"
    size = "1gb"
    ssh_keys = ["${var.do_ssh_key_id}"]
}
