Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Nov 2003 05:42:10 +0000 (GMT)
Received: from web12008.mail.yahoo.com ([IPv6:::ffff:216.136.172.216]:60268
	"HELO web12008.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225378AbTKDFld>; Tue, 4 Nov 2003 05:41:33 +0000
Message-ID: <20031104054130.12392.qmail@web12008.mail.yahoo.com>
Received: from [65.67.102.146] by web12008.mail.yahoo.com via HTTP; Mon, 03 Nov 2003 21:41:30 PST
Date: Mon, 3 Nov 2003 21:41:30 -0800 (PST)
From: Doug Kehn <rdkehn@yahoo.com>
Subject: Kernel compiler error : flexible array member not at end of struct
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdkehn@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3577
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdkehn@yahoo.com
Precedence: bulk
X-list: linux-mips

I am receiving the following kernel compile error:

make[3]: Entering directory
`/usr/src/x/kernel/linux-2.4.21/fs/partitions'
mips-uclibc-gcc -D__KERNEL__
-I/usr/src/x/kernel/linux-2.4.21/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -fomit-frame-pointer
-I /usr/src/x/linux-2.4.21/include/asm/gcc -G 0
-mno-abicalls -fno-pic -pipe  -mcpu=r5000 -mips2
-Wa,--trap   -nostdinc -iwithprefix include
-DKBUILD_BASENAME=check  -DEXPORT_SYMTAB -c check.c
In file included from
/usr/src/x/kernel/linux-2.4.21/include/linux/raid/md.h:50,
                 from check.c:21:
/usr/src/x/kernel/linux-2.4.21/include/linux/raid/md_p.h:157:
flexible array member not at end of struct
make[3]: *** [check.o] Error 1

I am using gcc version 2.96-mips3264-000710 (from
sdelinux-5.01-4eb.i386.rpm).  The kernel is,
obviously, 2.4.21 (from linux-mips.org).  uclibc is
version 0.9.21.

I have seen one or two other posting related to this
same error.  However, I was unable to find any
suggested resoltions.  Does anyone know of a solution
to this compile error?

Thanks...
doug




__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
