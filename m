Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3CEiOq09525
	for linux-mips-outgoing; Thu, 12 Apr 2001 07:44:24 -0700
Received: from servidor.spania-hq.com ([212.170.16.42])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3CEiNM09522
	for <linux-mips@oss.sgi.com>; Thu, 12 Apr 2001 07:44:23 -0700
Received: from jungo.com ([194.90.113.98] RDNS failed) by servidor.spania-hq.com with Microsoft SMTPSVC(5.0.2195.1600);
	 Thu, 12 Apr 2001 16:45:42 +0200
Message-ID: <3AD5BF32.8070807@jungo.com>
Date: Thu, 12 Apr 2001 17:44:02 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Linux/MIPS <linux-mips@oss.sgi.com>, FR Linux/MIPS <linux-mips@fnet.fr>
Subject: Re: Dynamic linker and .interp section
References: <Pine.GSO.3.96.1010412160800.24526A-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2001 14:45:43.0455 (UTC) FILETIME=[404E32F0:01C0C35F]
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Quick prove follow-up, sorry for dounple-posting

>  You can.  Ld never checks for its existence.

This one is for non-existing file:

/home/michaels/rg.ulibc/pkg/ulibc/extra/gcc-uClibc/gcc-uClibc-i386 
-L/home/michaels/rg.ulibc/pkg/ulibc -Wl,-warn-common -o busybox cat.o 
chmod_chown_chgrp.o clear.o cmdedit.o cp_mv.o date.o df.o dirname.o du.o 
echo.o find.o grep.o gunzip.o gzip.o halt.o head.o hostname.o id.o 
ifconfig.o init.o insmod.o interface.o kill.o klogd.o ln.o logger.o ls.o 
lsmod.o mkdir.o mknod.o more.o mount.o mtab.o nfsmount.o nslookup.o 
ping.o poweroff.o ps.o pwd.o reboot.o reset.o rm.o rmdir.o rmmod.o 
route.o sed.o sh.o sleep.o stty.o sync.o syslogd.o tail.o tar.o tee.o 
telnet.o test.o tftp.o touch.o true_false.o tty.o umount.o uname.o 
usleep.o which.o whoami.o xargs.o yes.o  busybox.o messages.o usage.o 
utility.o
i386-linux-gcc: /lib/ld-ulibc.so.1: No such file or directory
i386-linux-gcc: /lib/ld-ulibc.so.1: No such file or directory
make: *** [busybox] Error 1
[michaels@kobie busybox]$

This one for empty file:

/home/michaels/rg.ulibc/pkg/ulibc/extra/gcc-uClibc/gcc-uClibc-i386 
-L/home/michaels/rg.ulibc/pkg/ulibc -Wl,-warn-common -o busybox cat.o 
chmod_chown_chgrp.o clear.o cmdedit.o cp_mv.o date.o df.o dirname.o du.o 
echo.o find.o grep.o gunzip.o gzip.o halt.o head.o hostname.o id.o 
ifconfig.o init.o insmod.o interface.o kill.o klogd.o ln.o logger.o ls.o 
lsmod.o mkdir.o mknod.o more.o mount.o mtab.o nfsmount.o nslookup.o 
ping.o poweroff.o ps.o pwd.o reboot.o reset.o rm.o rmdir.o rmmod.o 
route.o sed.o sh.o sleep.o stty.o sync.o syslogd.o tail.o tar.o tee.o 
telnet.o test.o tftp.o touch.o true_false.o tty.o umount.o uname.o 
usleep.o which.o whoami.o xargs.o yes.o  busybox.o messages.o usage.o 
utility.o
/lib/ld-ulibc.so.1: file not recognized: File truncated
collect2: ld returned 1 exit status
make: *** [busybox] Error 1
[michaels@kobie busybox]$


-- 
Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
