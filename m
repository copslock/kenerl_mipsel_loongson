Received:  by oss.sgi.com id <S42266AbQFKKi2>;
	Sun, 11 Jun 2000 03:38:28 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:37933 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42199AbQFKKiQ>;
	Sun, 11 Jun 2000 03:38:16 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA12220
	for <linux-mips@oss.sgi.com>; Sun, 11 Jun 2000 03:33:19 -0700 (PDT)
	mail_from (indy.j@worldonline.cz)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA33790
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 11 Jun 2000 03:37:50 -0700 (PDT)
	mail_from (indy.j@worldonline.cz)
Received: from smtp.worldonline.cz (smtp-1.worldonline.cz [195.146.100.76]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA01675
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jun 2000 03:37:49 -0700 (PDT)
	mail_from (indy.j@worldonline.cz)
Received: from pingu (IDENT:root@ppp71.plzen.worldonline.cz [212.11.110.75])
	by smtp.worldonline.cz (8.9.3 (WOL 1.2)/8.9.3) with SMTP id MAA20605
	for <linux@cthulhu.engr.sgi.com>; Sun, 11 Jun 2000 12:37:16 +0200 (MET DST)
From:   Jiri "Kasi" Kastner <indy.j@worldonline.cz>
Reply-To: indy.j@worldonline.cz
To:     linux@cthulhu.engr.sgi.com
Subject: i'm not able compile new kernel
Date:   Sun, 11 Jun 2000 11:40:12 +0200
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <00061112164900.01364@pingu>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I downloaded kernel source from ftp://ftp.linux.sgi.com/.../v2.3/ 
make menuconfig,
make dep,
this is OK, but when I try make zImage I always get this error output:

/usr/src/linux/include/linux/sched.h: In function `on_sig_stack':
In file included from /usr/src/linux/include/linux/mm.h:4,
                 from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/linux/sched.h:566: `current' undeclared (first use this function)
/usr/src/linux/include/linux/sched.h:566: (Each undeclared identifier is reported only once
/usr/src/linux/include/linux/sched.h:566: for each function it appears in.)
/usr/src/linux/include/linux/sched.h:567: warning: control reaches end of non-void function
/usr/src/linux/include/linux/sched.h: In function `sas_ss_flags':
/usr/src/linux/include/linux/sched.h:571: `current' undeclared (first use this function)
/usr/src/linux/include/linux/sched.h:573: warning: control reaches end of non-void function
/usr/src/linux/include/linux/sched.h: In function `suser':
/usr/src/linux/include/linux/sched.h:596: `current' undeclared (first use this function)
/usr/src/linux/include/linux/sched.h: In function `fsuser':
/usr/src/linux/include/linux/sched.h:605: `current' undeclared (first use this function)
/usr/src/linux/include/linux/sched.h: In function `capable':
/usr/src/linux/include/linux/sched.h:621: `current' undeclared (first use this function)
/usr/src/linux/include/linux/mm.h: In function `expand_stack':
In file included from /usr/src/linux/include/linux/slab.h:14,
                 from /usr/src/linux/include/linux/malloc.h:4,
                 from /usr/src/linux/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/usr/src/linux/include/linux/mm.h:406: `current' undeclared (first use this function)
init/main.c: In function `start_kernel':
init/main.c:536: `current' undeclared (first use this function)
init/main.c: In function `do_basic_setup':
init/main.c:597: `current' undeclared (first use this function)
make: *** [init/main.o] Error 1

I would like to compile new kernel on indy (hardhat 5.1). Can anybody write to
me what is wrong? My indy is MIPS4600 (IP22), XL-8 bit graphics, vino, IndyCam,
soundcard.

Thanks
Jiri.
