Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f72HjKN13125
	for linux-mips-outgoing; Thu, 2 Aug 2001 10:45:20 -0700
Received: from banff.ayrnetworks.com (64-166-72-137.ayrnetworks.com [64.166.72.137])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f72Hj1V13115
	for <linux-mips@oss.sgi.com>; Thu, 2 Aug 2001 10:45:15 -0700
Received: from ayrnetworks.com (IDENT:chua@localhost.localdomain [127.0.0.1])
	by banff.ayrnetworks.com (8.11.0/8.11.0) with ESMTP id f72Hh2H14822
	for <linux-mips@oss.sgi.com>; Thu, 2 Aug 2001 10:43:02 -0700
Message-ID: <3B699126.E1B5F5E0@ayrnetworks.com>
Date: Thu, 02 Aug 2001 10:43:02 -0700
From: Bryan Chua <chua@ayrnetworks.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: xtime declaration
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Has anyone else come across a compile error:

mips-linux-gcc -I /local/chua/public/linux-mips-latest/include/asm/gcc
-D__KERNEL__ -I/local/chua/public/linux-mips-latest/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -G 0
-mno-abicalls -fno-pic -mcpu=r5000 -mips2 -Wa,--trap -pipe    -c -o
timer.o timer.c
timer.c:35: conflicting types for `xtime'
/local/chua/public/linux-mips-latest/include/linux/sched.h:540: previous
declaration of `xtime'

in include/linux/sched.h:
extern struct timeval xtime;

int timer.c:
volatile struct timeval xtime __attribute__ ((aligned (16)));

I am using gcc 3.0 and binutils 2.11.2, both of the released versions.
I do not know if my kernel actually runs yet with this toolchain...

-- bryan
