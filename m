Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6G2S7Rw017574
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 15 Jul 2002 19:28:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6G2S7Ym017573
	for linux-mips-outgoing; Mon, 15 Jul 2002 19:28:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from web14406.mail.yahoo.com (web14406.mail.yahoo.com [216.136.174.76])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6G2RxRw017563
	for <linux-mips@oss.sgi.com>; Mon, 15 Jul 2002 19:27:59 -0700
Message-ID: <20020716023252.65583.qmail@web14406.mail.yahoo.com>
Received: from [157.165.41.125] by web14406.mail.yahoo.com via HTTP; Mon, 15 Jul 2002 19:32:52 PDT
Date: Mon, 15 Jul 2002 19:32:52 -0700 (PDT)
From: Long Li <long21st@yahoo.com>
Subject: mips32 cross compiler on X86 linux
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, 

I am a newbie to the cross compiler. I read some
documents online and started to build a gcc cross
compiler for MIPS4Kc(32-bit isa) on X86 linux. Here is
what I did:

1. I built binutils-2.11.2 with the following
configurations:

configure --prefix=/home/lli/my-bin
--target=mips32-linux --with-cpu=mips32-4kc

2. The binutils was built successfully. Then I built
the gcc-3.0.4
with the configurations:

  --prefix=/home/lli/my-bin --target=mips32-linux
--with-cpu=mips32-4kc
  --with-gnu-as --with-gnu-ld 
  --enable-languages="c c++"

I got the error messages:
 
  /home/lli/my-bin/mips32-linux/bin/ld:
/home/lli/my-bin/mips32-linux/lib/crti.o: Relocations
in generic ELF (EM: 3)
/home/lli/my-bin/mips32-linux/lib/crti.o: could not
read symbols: File in
wrong format
collect2: ld returned 1 exit status
make[2]: *** [libgcc_s.so] Error 1
make[2]: Leaving directory `/home/lli/objdir/gcc'
make[1]: *** [libgcc.a] Error 2
make[1]: Leaving directory `/home/lli/objdir/gcc'
make: *** [all-gcc] Error 2


Is my configuration correct to build a MIPS32-4kc
cross compiler on Linux? If not, how should I do?
Could you give me some help?

Thank you very much. I really appreciate it.


Best,


Long Li

__________________________________________________
Do You Yahoo!?
Yahoo! Autos - Get free new car price quotes
http://autos.yahoo.com
