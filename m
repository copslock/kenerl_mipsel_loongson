Received:  by oss.sgi.com id <S42232AbQJFNH4>;
	Fri, 6 Oct 2000 06:07:56 -0700
Received: from woody.ichilton.co.uk ([216.29.174.40]:53776 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S42222AbQJFNHg>;
	Fri, 6 Oct 2000 06:07:36 -0700
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id 731BC7C5F; Fri,  6 Oct 2000 14:07:34 +0100 (BST)
Date:   Fri, 6 Oct 2000 14:07:34 +0100
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: SMB in 2.4 Kernel
Message-ID: <20001006140734.A11647@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.9i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I sucesfully built a 2.4 cvs kernel from yesturday....then, I enabled smb support and tried to re-compile, and got this:

make[3]: Entering directory `/tmp/linux/fs/smbfs'
gcc -D__KERNEL__ -I/tmp/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic -mcpu=r4600 -mips2 -Wa,--trap -pipe   -DSMBFS_PARANOIA  -c -o proc.o proc.c
proc.c: In function `smb_setup_header':
proc.c:826: `val' undeclared (first use this function)
proc.c:826: (Each undeclared identifier is reported only once
proc.c:826: for each function it appears in.)
proc.c: In function `smb_setup_bcc':
proc.c:849: `val' undeclared (first use this function)
proc.c: In function `smb_proc_open':
proc.c:881: `val' undeclared (first use this function)
proc.c: In function `smb_proc_close':
proc.c:980: `val' undeclared (first use this function)
proc.c: In function `smb_proc_read':
proc.c:1085: `val' undeclared (first use this function)
proc.c: In function `smb_proc_write':
proc.c:1135: `val' undeclared (first use this function)
proc.c: In function `smb_proc_create':
proc.c:1163: `val' undeclared (first use this function)
proc.c: In function `smb_proc_mv':
proc.c:1197: `val' undeclared (first use this function)
proc.c: In function `smb_proc_unlink':
proc.c:1307: `val' undeclared (first use this function)
proc.c: In function `smb_proc_trunc':
proc.c:1358: `val' undeclared (first use this function)
proc.c: In function `smb_proc_readdir_short':
proc.c:1504: `val' undeclared (first use this function)
proc.c:1484: warning: unused variable `entries_asked'
proc.c: In function `smb_proc_readdir_long':
proc.c:1749: `val' undeclared (first use this function)
proc.c:1694: warning: unused variable `max_matches'
proc.c: In function `smb_proc_getattr_ff':
proc.c:1924: `val' undeclared (first use this function)
proc.c: In function `smb_proc_getattr_trans2':
proc.c:2044: `val' undeclared (first use this function)
proc.c: In function `smb_proc_setattr_core':
proc.c:2170: `val' undeclared (first use this function)
proc.c: In function `smb_proc_setattr_ext':
proc.c:2229: `val' undeclared (first use this function)
proc.c: In function `smb_proc_setattr_trans2':
proc.c:2276: `val' undeclared (first use this function)
make[3]: *** [proc.o] Error 1
make[3]: Leaving directory `/tmp/linux/fs/smbfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/tmp/linux/fs/smbfs'
make[1]: *** [_subdir_smbfs] Error 2
make[1]: Leaving directory `/tmp/linux/fs'
make: *** [_dir_fs] Error 2


Any ideas? 


Compiling nativly on an Indy 4k with glibc 2.0.6, egcs 1.0.3a, binutils 2.8.1 and 2.2.14


Thanks!


Bye for Now,

Ian


                     \|||/ 
                     (o o)
 /----------------ooO-(_)-Ooo----------------\
 |  Ian Chilton                              |
 |  E-Mail : ian@ichilton.co.uk              |
 \-------------------------------------------/
