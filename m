Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBH29mC03826
	for linux-mips-outgoing; Sun, 16 Dec 2001 18:09:48 -0800
Received: from woody.ichilton.co.uk (woody.ichilton.co.uk [216.28.122.60])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBH29ao03823;
	Sun, 16 Dec 2001 18:09:37 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id 2725B7CF5; Mon, 17 Dec 2001 01:09:26 +0000 (GMT)
Date: Mon, 17 Dec 2001 01:09:26 +0000
From: Ian Chilton <ian@ichilton.co.uk>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: Kernel Wont Boot on I2 - Not the kernel!
Message-ID: <20011217010926.H6423@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

Just been looking into the problem more.

My Indy and Sparc boxes netboot fine, so server seems ok

My I2 boots an old 2.4.0-test9 kernel fine

But try to boot a new kernel on the I2, get this:

>> bootp():/vmlinux                 
Setting $netaddr to 192.168.0.13 (from server )
Obtaining /vmlinux from server                 
  /                           
[and stops there]

I thought this was the kernel, but I just tried Flo's (lolo) working
I2 kernel and it does exactly the same!!


Server is showing this:

Dec 17 01:54:48 slinky dhcpd: BOOTREQUEST from 08:00:69:08:9d:ec via
eth0
Dec 17 01:54:48 slinky dhcpd: BOOTREPLY for 192.168.0.13 to dale
(08:00:69:08:9d:ec) via eth0
Dec 17 01:54:48 slinky in.tftpd[5858]: connect from dale.ichilton.local
Dec 17 01:54:48 slinky tftpd[5859]: tftpd: trying to get file:
vmlinux-dale 
Dec 17 01:54:48 slinky tftpd[5859]: tftpd: serving file from
/export/tftpboot 
[root@slinky:/export/tftpboot]# ls -la vmlinux-dale 
lrwxrwxrwx    1 root     root           19 Dec 17 01:51 vmlinux-dale ->
mips/vmlinux-2.4.16


End of tcpdump is:

02:01:09.797242 dale.ichilton.local.15677 > slinky.ichilton.local.2052:
udp 6
02:01:09.797289 slinky.ichilton.local.2052 > dale.ichilton.local.15677:
udp 516
02:01:09.798218 dale.ichilton.local.15677 > slinky.ichilton.local.2052:
udp 6
02:01:09.798265 slinky.ichilton.local.2052 > dale.ichilton.local.15677:
udp 516
02:01:09.799190 dale.ichilton.local.15677 > slinky.ichilton.local.2052:
udp 6
02:01:09.799235 slinky.ichilton.local.2052 > dale.ichilton.local.15677:
udp 516
02:01:09.800168 dale.ichilton.local.15677 > slinky.ichilton.local.2052:
udp 6
02:01:09.800213 slinky.ichilton.local.2052 > dale.ichilton.local.15677:
udp 516
02:01:09.860624 dale.ichilton.local.15677 > slinky.ichilton.local.2052:
udp 6
02:01:11.574420 arp who-has dale.ichilton.local tell
slinky.ichilton.local
02:01:12.574416 arp who-has dale.ichilton.local tell
slinky.ichilton.local
02:01:13.574414 arp who-has dale.ichilton.local tell
slinky.ichilton.local
02:01:14.574427 arp who-has dale.ichilton.local tell
slinky.ichilton.local
02:01:15.574423 arp who-has dale.ichilton.local tell
slinky.ichilton.local
02:01:16.574414 arp who-has dale.ichilton.local tell
slinky.ichilton.local



Anyone any ideas?


Thanks

Ian
