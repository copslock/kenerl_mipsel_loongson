Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f730kLe19601
	for linux-mips-outgoing; Thu, 2 Aug 2001 17:46:21 -0700
Received: from dea.waldorf-gmbh.de (u-227-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.227])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f730kIV19595
	for <linux-mips@oss.sgi.com>; Thu, 2 Aug 2001 17:46:19 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f730j1q28023;
	Fri, 3 Aug 2001 02:45:01 +0200
Date: Fri, 3 Aug 2001 02:45:01 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Bryan Chua <chua@ayrnetworks.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: xtime declaration
Message-ID: <20010803024501.A27708@bacchus.dhis.org>
References: <3B699126.E1B5F5E0@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B699126.E1B5F5E0@ayrnetworks.com>; from chua@ayrnetworks.com on Thu, Aug 02, 2001 at 10:43:02AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Aug 02, 2001 at 10:43:02AM -0700, Bryan Chua wrote:

> Has anyone else come across a compile error:
> 
> mips-linux-gcc -I /local/chua/public/linux-mips-latest/include/asm/gcc
> -D__KERNEL__ -I/local/chua/public/linux-mips-latest/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -G 0
> -mno-abicalls -fno-pic -mcpu=r5000 -mips2 -Wa,--trap -pipe    -c -o
> timer.o timer.c
> timer.c:35: conflicting types for `xtime'
> /local/chua/public/linux-mips-latest/include/linux/sched.h:540: previous
> declaration of `xtime'
> 
> in include/linux/sched.h:
> extern struct timeval xtime;
> 
> int timer.c:
> volatile struct timeval xtime __attribute__ ((aligned (16)));
> 
> I am using gcc 3.0 and binutils 2.11.2, both of the released versions.
> I do not know if my kernel actually runs yet with this toolchain...

That's a bug which got fixed in the latest kernels by removing the
volatile from the sched.h declaration.

  Ralf
