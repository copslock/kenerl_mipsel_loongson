Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A0Tdq24126
	for linux-mips-outgoing; Thu, 9 Aug 2001 17:29:39 -0700
Received: from web11902.mail.yahoo.com (web11902.mail.yahoo.com [216.136.172.186])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A0TbV24123
	for <linux-mips@oss.sgi.com>; Thu, 9 Aug 2001 17:29:37 -0700
Message-ID: <20010810002937.56073.qmail@web11902.mail.yahoo.com>
Received: from [209.243.184.191] by web11902.mail.yahoo.com; Thu, 09 Aug 2001 17:29:37 PDT
Date: Thu, 9 Aug 2001 17:29:37 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Problems mounting RedHat 7.0 or 7.1 from oss.sgi site
To: linux-mips@oss.sgi.com
In-Reply-To: <20010809175131.D30160@paradigm.rfc822.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have tried unsuccessfully to use the root
filesystems
mipselroot-rh7-20010606.tar.bz2
and H.J.Lu's RedHat 7.1 install from the sgi ftp site.

Both give me warnings immeadiately about the files
they are trying to access :

INIT: version 2.78 booting
/etc/rc.sysinit: .: /etc/sysconfig/network: not a
regular file
/etc/rc.sysinit: .: /etc/init.d/functions: not a
regular file
                        Welcome to Red Hat Linux
                Press 'I' to enter interactive
startup.

If I then boot either with 

init=/bin/bash rw 

and use 'ls' without any parameters 'ls' warns :

bash-2.04# ls
ls: .: Invalid argument

Using ls * will give a file listing if the directory
contains any files. But the file info is totally hosed
eg from /etc:

?--------x    0 0        root           17 Jul 23 
2000 host.conf
?--------x    0 0        root          161 Jan 12 
2000 hosts.allow
?--------x    0 0        root          347 Jan 12 
2000 hosts.deny
?--------x    0 0        root          754 Feb 24
11:57 info-dir
?

I am using a 2.4.2 kernel that boots successfully when
using the RedHat 5.1 distribution also found on the
SGI site.

My tools are :
egcs-mipsel-linux-1.1.2-4.i386.rpm
binutils-mipsel-linux-2.8.1-2.i386.rpm

Any ideas as to what I am doing wrong would be
appreciated

Compiler ? Glibc ? ???

Wayne



__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
