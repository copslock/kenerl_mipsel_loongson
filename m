Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 15:33:03 +0000 (GMT)
Received: from heffalump.fnal.gov ([IPv6:::ffff:131.225.9.20]:4828 "EHLO
	fnal.gov") by linux-mips.org with ESMTP id <S8225234AbTBDPdD>;
	Tue, 4 Feb 2003 15:33:03 +0000
Received: from ppd89948 ([131.225.55.68])
 by smtp.fnal.gov (PMDF V6.0-24 #37519) with ESMTP id
 <0H9S00077J70ZJ@smtp.fnal.gov> for linux-mips@linux-mips.org; Tue,
 04 Feb 2003 09:33:00 -0600 (CST)
Date: Tue, 04 Feb 2003 09:33:00 -0600
From: Jason Ormes <jormes@wideopenwest.com>
Subject: ip27-init.c problem
To: linux-mips@linux-mips.org
Message-id: <001801c2cc62$b319a9a0$4437e183@fermi.win.fnal.gov>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Mailer: Microsoft Outlook, Build 10.0.4024
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Return-Path: <jormes@wideopenwest.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jormes@wideopenwest.com
Precedence: bulk
X-list: linux-mips

Hello,

	I downloaded the linux_2_4 branch from the cvs repository and am
trying to build a kernel for an origin 200.  I'm using
binutils-mips64-linux-2.13.1-1 and egcs-mips64-linux-1.1.2-4 on a redhat
8.0 system.  I am getting these errors in ip27-init.c when trying to
build the kernel.

mips64-linux-gcc -D__KERNEL__ -I/home/jason/mips/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -I /home/jason/mips/linux/include/asm/gcc -mabi=64
-G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r8000 -mips4 -Wa,-32
-Wa,-mgp64   -nostdinc -iwithprefix include -DKBUILD_BASENAME=ip27_init
-c -o ip27-init.o ip27-init.c
ip27-init.c:48: parse error before `boot_cpumask'
ip27-init.c:48: warning: type defaults to `int' in declaration of
`boot_cpumask'
ip27-init.c:48: warning: data definition has no type or storage class
ip27-init.c:107: parse error before `cpumask_t'
ip27-init.c:109: warning: function declaration isn't a prototype
ip27-init.c: In function `do_cpumask':
ip27-init.c:116: `nasid' undeclared (first use in this function)
ip27-init.c:116: (Each undeclared identifier is reported only once
ip27-init.c:116: for each function it appears in.)
ip27-init.c:124: `cnode' undeclared (first use in this function)
ip27-init.c:125: `highest' undeclared (first use in this function)
ip27-init.c:130: warning: implicit declaration of function
`CPUMASK_SETB'
ip27-init.c:130: invalid type argument of `unary *'
ip27-init.c: At top level:
ip27-init.c:147: parse error before `*'
ip27-init.c:148: warning: function declaration isn't a prototype
ip27-init.c: In function `cpu_node_probe':
ip27-init.c:163: invalid type argument of `unary *'
ip27-init.c:170: invalid type argument of `unary *'
ip27-init.c: In function `cpu_enabled':
ip27-init.c:187: warning: implicit declaration of function
`CPUMASK_TSTB'
ip27-init.c: In function `mlreset':
ip27-init.c:203: warning: implicit declaration of function
`CPUMASK_CLRALL'
make[2]: *** [ip27-init.o] Error 1
make[2]: Leaving directory `/home/jason/mips/linux/arch/mips/sgi-ip27'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/jason/mips/linux/arch/mips/sgi-ip27'
make: *** [_dir_arch/mips/sgi-ip27] Error 2

I did 
make ARCH=mips64 clean
make ARCH=mips64 menuconfig and turned on ip27 support
make ARCH=mips64 deps
make ARCH=mips64 all

can someone point me in the right direction out of this problem?

Jason Ormes
