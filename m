Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB82r2631186
	for linux-mips-outgoing; Fri, 7 Dec 2001 18:53:02 -0800
Received: from woody.ichilton.co.uk (woody.ichilton.co.uk [216.28.122.60])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB82qso31183;
	Fri, 7 Dec 2001 18:52:54 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id 3B7D37CEE; Sat,  8 Dec 2001 01:52:34 +0000 (GMT)
Date: Sat, 8 Dec 2001 01:52:34 +0000
From: Ian Chilton <ian@ichilton.co.uk>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Kernel Problem?
Message-ID: <20011208015234.B21905@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

Just decided to test the kernel that worked on the Indy on my I2.

Booted the debian installation tftpboot.img and installed debian to
/dev/sda1.

Now trying to boot the 2.4.16 kernel, but get:

Command Monitor.  Type "exit" to return to the menu.
>> bootp():/vmlinux root=/dev/sda1 console=ttyS0
Setting $netaddr to 192.168.0.13 (from server )
Obtaining /vmlinux from server
  |

[and it stops here...think it was too quick to finish transfering..]



Any ideas?


Thanks

Ian
