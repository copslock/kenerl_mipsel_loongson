Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAFLhFO27886
	for linux-mips-outgoing; Thu, 15 Nov 2001 13:43:15 -0800
Received: from smtp016.mail.yahoo.com (smtp016.mail.yahoo.com [216.136.174.113])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAFLhB027883
	for <linux-mips@oss.sgi.com>; Thu, 15 Nov 2001 13:43:11 -0800
Received: from c1793011-a.marin1.sfba.home.com (HELO garrickevansw2k) (24.7.89.210)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 15 Nov 2001 21:43:11 -0000
X-Apparently-From: <sginux@yahoo.com>
Message-ID: <003b01c16e1e$781aefb0$6401a8c0@autodesk.com>
From: "Garrick Evans" <sginux@yahoo.com>
To: "Linux MIPS" <linux-mips@oss.sgi.com>
References: <1004708261.31067.6.camel@localhost.localdomain> <3BE2A852.AFF0D905@mips.com> <1005662974.10352.2.camel@localhost.localdomain> <20011113075543.A30676@lucon.org>
Subject: SGI harddisk only - Debian install
Date: Thu, 15 Nov 2001 13:42:45 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-Mimeole: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Just looking for a little help here getting woody running on an indy.
My problem is once I boot the install kernel (linux), after the scsi snoop
and network setup, it all dies on the following line:

sending SDTR 011030130f0csync_xfer=2c<0>Kernel panic: VFS: Unable to mount
root fs on 08:01

I have IRIX (5.3) on dksc(0,1) and two free drives dksc(0,3) and dksc(0,4)
available for debian.
I have the following files located at / and /boot directories on IRIX
partition:
linux, root.bin, root.tar.gz, kernel_config, drivers.tgz

I have booted from the "maintainence console" (PROM) with almost every
combination I can think of - always with the same failure.

So... where is it looking to mount from? Do I need to make a new filesystem
in the root parition of the scsi 3 disk and push the kernel and root.bin
over there? If so, do I also then need to dvhtool the header on that disk as
well?

Any help would be HUGELY appreciated.  Thanks.


g


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
