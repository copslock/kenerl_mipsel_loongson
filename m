Received:  by oss.sgi.com id <S553829AbRAQRwd>;
	Wed, 17 Jan 2001 09:52:33 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:58633 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553824AbRAQRw3>;
	Wed, 17 Jan 2001 09:52:29 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 1000)
	id D37267D0E; Wed, 17 Jan 2001 17:52:27 +0000 (GMT)
Date:   Wed, 17 Jan 2001 17:52:27 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     guido.guenther@gmx.net, linux-mips@oss.sgi.com
Subject: Re: patches for dvhtool
Message-ID: <20010117175227.A29978@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

> BTW: Is there any way of deleteing/renaming files in the
> volume-header-directory ? Is there a way to set "bootfile" ?

You could do what I do with my tftp boot directory.

Bootp or whatever points to vmlinux-hostname.

vmlinux-hostname is a symlink to a kernel.

Changing kernels is just a matter of changing the symlink.

Also, because I have multiple arch's, I put the kernels in subdirs too:

[ian@slinky:~]$ ls -l /export/tftpboot/
total 16
lrwxrwxrwx   1 root     root           23 Jan  6 16:34 192.168.0.21 ->
../javastation/iclinux/
lrwxrwxrwx   1 root     root           18 Jan  4 18:48 C0A8000E.SUN4M
-> sparc/tftpboot.img
lrwxrwxrwx   1 root     root           18 Jan  4 18:03 C0A8000F.SUN4C
-> sparc/tftpboot.img
lrwxrwxrwx   1 root     root           24 Jan  4 23:31 C0A80012.SUN4M
-> sparc/vmlinux-2.4-test12
lrwxrwxrwx   1 root     root           14 Jan  2 18:54 C0A80015 ->
C0A80015.SUN4M
lrwxrwxrwx   1 root     root           36 Jan  4 17:29 C0A80015.PROL ->
javastation/vmlinux-2.4-test12-sparc
lrwxrwxrwx   1 root     root           11 Jan  2 18:42 C0A80015.SUN4M
-> proll.krups
drwxr-xr-x   2 root     root         4096 Jan  4 23:20 javastation
drwxr-xr-x   2 root     root         4096 Jan 17 13:10 mips
lrwxrwxrwx   1 root     root           28 Jan  4 17:32 proll.krups ->
javastation/proll.krups.ID13
drwxr-xr-x   2 root     root         4096 Jan  6 13:21 sparc
drwxr-xr-x   2 root     root         4096 Jan 16 19:24 tmp
lrwxrwxrwx   1 root     root           29 Jan 16 19:25 vmlinux-chip ->
mips/vmlinux-010116-IP22-4400
lrwxrwxrwx   1 root     root           30 Jan 17 13:11 vmlinux-dale ->
mips/vmlinux-010117-IP22-DEBUG

 

Bye for Now,

Ian

                                \|||/
                                (o o)
 /---------------------------ooO-(_)-Ooo---------------------------\
 |  Ian Chilton        (IRC Nick - GadgetMan)     ICQ #: 16007717  |
 |-----------------------------------------------------------------|
 |  E-Mail: ian@ichilton.co.uk     Web: http://www.ichilton.co.uk  |
 |-----------------------------------------------------------------|
 |        Proofread carefully to see if you any words out.         |
 \-----------------------------------------------------------------/
