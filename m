Received:  by oss.sgi.com id <S42249AbQGXV5m>;
	Mon, 24 Jul 2000 14:57:42 -0700
Received: from hermes.epita.fr ([194.98.116.10]:25612 "EHLO hermes.epita.fr")
	by oss.sgi.com with ESMTP id <S42245AbQGXV5T>;
	Mon, 24 Jul 2000 14:57:19 -0700
Received: from purple42.epx.epita.fr (purple42.epx.epita.fr [10.225.7.1])
	by hermes.epita.fr id XAA17902 for <linux-mips@oss.sgi.com> 
	EPITA Paris France Mon, 24 Jul 2000 23:57:26 GMT
Received: by purple42.epx.epita.fr (Postfix, from userid 501)
	id 6DFE1277; Tue, 25 Jul 2000 00:01:09 +0200 (CEST)
Date:   Tue, 25 Jul 2000 00:01:08 +0200
From:   Diablero <poinde_t@epita.fr>
To:     linux-mips@oss.sgi.com
Subject: I can't cross compile kernel
Message-ID: <20000725000108.A12611@purple42.epx.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I have recompiled binutils and gcc lik it's explained in
http://foobazco.org/~wesolows/mips-cross.html. 

I have tried to cross-compile kernel but I always had the same errors.
(last kernel from cvs - oss.sgi.com)
make menuconfig ARCH=mips
make dep MAKE="make -j3" CROSS_COMPILE=mips-linux-
make boot MAKE="make -j3" CROSS_COMPILE=mips-linux-

mips-linux-gcc -D__KERNEL__ -I/goinfre/mips/kernel/linux-cvs/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -G 0 -mno-abicalls -fno-pic
-mcpu=r4600 -mips2 -Wa,--trap -pipe -fno-strict-aliasing  -c -o init/main.o
init/main.c
in file included from
/goinfre/mips/kernel/linux-cvs/include/linux/coda_fs_i.h:14,
                 from
		 /goinfre/mips/kernel/linux-cvs/include/linux/fs.h:281,
[...]
                 from
		 /goinfre/mips/kernel/linux-cvs/include/linux/proc_fs.h:5,
                 from init/main.c:15:
/goinfre/mips/kernel/linux-cvs/include/linux/coda.h:259: parse error before
`u_quad_t'
/goinfre/mips/kernel/linux-cvs/include/linux/coda.h:259: warning: no
semicolon at end of struct or union
[...]
/goinfre/mips/kernel/linux-cvs/include/linux/udf_fs_sb.h:21: warning:
ignoring pragma: 1
/goinfre/mips/kernel/linux-cvs/include/linux/udf_fs_sb.h:76: warning:
ignoring pragma: ;
{standard input}: Assembler messages:
{standard input}:50: Warning: No .cprestore pseudo-op used in PIC code
{standard input}:98: Warning: No .cprestore pseudo-op used in PIC code
{standard input}:108: Warning: No .cprestore pseudo-op used in PIC code
{standard input}:167: Warning: Macro instruction expanded into multiple
instructions
{standard input}:167: Warning: No .cprestore pseudo-op used in PIC code
[...]


-- 
Thomas Poindessous
EpX asso GNU/Linux de l'Epita
epx@epita.fr && http://www.epita.fr/~epx
