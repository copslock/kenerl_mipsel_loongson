Received:  by oss.sgi.com id <S42184AbQFOTlc>;
	Thu, 15 Jun 2000 12:41:32 -0700
Received: from smtp-1.worldonline.cz ([195.146.100.76]:27041 "EHLO
        smtp.worldonline.cz") by oss.sgi.com with ESMTP id <S42181AbQFOTlX>;
	Thu, 15 Jun 2000 12:41:23 -0700
Received: from pingu (IDENT:indy@ppp211.plzen.worldonline.cz [212.11.110.215])
	by smtp.worldonline.cz (8.9.3 (WOL 1.2)/8.9.3) with SMTP id VAA00901
	for <linux-mips@oss.sgi.com>; Thu, 15 Jun 2000 21:40:40 +0200 (MET DST)
From:   "Jiri Kastner jr." <indy.j@worldonline.cz>
To:     linux-mips@oss.sgi.com
Subject: Re: i'm not able compile new kernel
Date:   Thu, 15 Jun 2000 21:22:19 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
References: <Pine.LNX.4.21.0006121632510.30891-100000@calypso.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.21.0006121632510.30891-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Message-Id: <00061521402900.00811@pingu>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

> Try the egcs 1.0.2 release (egcs-2.90.27) or later. 
Now I have cross-compiler and I got following:

In file included from /usr/include/errno.h:36,
                 from scripts/split-include.c:26:
/usr/include/bits/errno.h:32: warning: `ECANCELED' redefined
/usr/include/asm/errno.h:139: warning: this is the location of the previous definition
cc1: Invalid option `-fno-strict-aliasing'
In file included from /usr/lib/gcc-lib/mips-linux/egcs-2.90.29/include/stdarg.h:27,
                 from /usr/src/linux/include/linux/kernel.h:10,
                 from /usr/src/linux/include/linux/wait.h:12,
                 from /usr/src/linux/include/linux/fs.h:12,
                 from /usr/src/linux/include/linux/capability.h:13,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/lib/gcc-lib/mips-linux/egcs-2.90.29/include/va-mips.h:89: sgidefs.h: není souborem ani adresáøem
In file included from /usr/src/linux/include/linux/net.h:22,
                 from /usr/src/linux/include/linux/fs.h:15,
                 from /usr/src/linux/include/linux/capability.h:13,
                 from /usr/src/linux/include/linux/binfmts.h:5,
                 from /usr/src/linux/include/linux/sched.h:9,
                 from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/linux/socket.h:133: warning: `SOCK_STREAM' redefined
/usr/src/linux/include/asm/socket.h:67: warning: this is the location of the previous definition
/usr/src/linux/include/linux/socket.h:134: warning: `SOCK_DGRAM' redefined
/usr/src/linux/include/asm/socket.h:65: warning: this is the location of the previous definition
make: *** [init/main.o] Error 1

This is from compiling of kernel release 2.4.0test1 from czech mirror of kernel
site.

What's wrong I have cross-compiler egcs-2.90.29 (egcs 1.0.2 release) from
ftp://oss.sgi.com/....

I've compiled latest kernel from ftp.linux.sgi.com/.../v2.3 and when I'm tryin'
to boot this kernel, I get this:

72912+9440+3024+331696+23768d+3644+5808 entry: 0x8bf9a950
Exception:<vector=UTLB Miss>
Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
Cause register: 0x8008<CE=0,IP8,EXC=RMISS>
Exception PC: 0x0, Exception RA: 0x0
exception bad address: 0x0
Local I/O interupt register 1: 0x80<VR/GI02>
Saved user in hex (&gpda 0xa8740e48, &_regs 0xa8741048):.................

What I'm doin' wrong..?

Jirka.
