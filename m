Received:  by oss.sgi.com id <S553733AbQKWS1R>;
	Thu, 23 Nov 2000 10:27:17 -0800
Received: from woody.ichilton.co.uk ([216.29.174.40]:1284 "HELO
        woody.ichilton.co.uk") by oss.sgi.com with SMTP id <S553687AbQKWS05>;
	Thu, 23 Nov 2000 10:26:57 -0800
Received: by woody.ichilton.co.uk (Postfix, from userid 0)
	id CE4E07CF8; Thu, 23 Nov 2000 18:26:56 +0000 (GMT)
Date:   Thu, 23 Nov 2000 18:26:56 +0000
From:   Ian Chilton <mailinglist@ichilton.co.uk>
To:     linux-mips@oss.sgi.com
Subject: Current Kernel Won't Compile
Message-ID: <20001123182656.A7054@woody.ichilton.co.uk>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hello,

I believe Ralf checked 2.4test10 into CVS last night...

I have just tried to compile now, and it won't work  :(

/crossdev-build/src/linux-001123/include/asm/ptrace.h:65:33: warning:
"PTRACE_SETOPTIONS" redefined
/crossdev-build/src/linux-001123/include/asm/ptrace.h:18:1: warning:
this is the location of the previous definition
mips-linux-gcc -D__KERNEL__ -I/crossdev-build/src/linux-001123/include
-Wall -Wstrict-prototypes -O2 -fomit-frame-po
inter -fno-strict-aliasing -G 0 -mno-abicalls -fno-pic -mcpu=r4600
-mips2 -Wa,--trap -pipe    -c -o ptrace.o ptrace.c
In file included from
/crossdev-build/src/linux-001123/include/linux/ptrace.h:24,
                 from
/crossdev-build/src/linux-001123/include/linux/binfmts.h:4,
                 from
/crossdev-build/src/linux-001123/include/linux/sched.h:9,
                 from ptrace.c:12:
/crossdev-build/src/linux-001123/include/asm/ptrace.h:65:33: warning:
"PTRACE_SETOPTIONS" redefined
/crossdev-build/src/linux-001123/include/asm/ptrace.h:18:1: warning:
this is the location of the previous definition
ptrace.c: In function `sys_ptrace':
ptrace.c:287: `ret' undeclared (first use in this function)
ptrace.c:287: (Each undeclared identifier is reported only once
ptrace.c:287: for each function it appears in.)
make[1]: *** [ptrace.o] Error 1
make[1]: Leaving directory
`/crossdev-build/src/linux-001123/arch/mips/kernel'
make: *** [_dir_arch/mips/kernel] Error 2
[ian@slinky:/crossdev-build]$ 



Building with make-cross.sh and:

BINUTILS_VERSION=001123
GCC_VERSION=001019
LIBC_VERSION=001123
LINUX_VERSION=001123

BINUTILS_PATCHES=""
GCC_PATCHES="gcc-001023.diff%%0"
LIBC_PATCHES=""
LINUX_PATCHES=""
 

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
