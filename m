Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g68I53Rw000515
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 8 Jul 2002 11:05:03 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g68I53MC000514
	for linux-mips-outgoing; Mon, 8 Jul 2002 11:05:03 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g68I4tRw000494;
	Mon, 8 Jul 2002 11:04:55 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id LAA29611;
	Mon, 8 Jul 2002 11:09:07 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA24314;
	Mon, 8 Jul 2002 11:09:07 -0700 (PDT)
Received: from mips.com ([172.18.27.100])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g68I97b06690;
	Mon, 8 Jul 2002 20:09:07 +0200 (MEST)
Message-ID: <3D29D65C.84630789@mips.com>
Date: Mon, 08 Jul 2002 20:13:48 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Jun Sun <jsun@mvista.com>, linux-mips@oss.sgi.com
Subject: Re: LTP testing (shmat01)
References: <3D246924.542682B2@mips.com> <20020704193414.A29570@dea.linux-mips.net> <3D249181.D9147AAE@mips.com> <20020704215614.B29422@dea.linux-mips.net> <3D29CC6B.5090004@mvista.com> <20020708194539.C2758@dea.linux-mips.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I have no preferences of the value of SHMLBA, as long as the define in
/usr/include/sys/shm.c and include/asm-mips/shmparam.h are in sync.

/Carsten


Ralf Baechle wrote:

> On Mon, Jul 08, 2002 at 10:31:23AM -0700, Jun Sun wrote:
>
> > I think this is also an effective way to avoid cache aliasing.
>
> Correct.  At the same time the choice of this value also tends to cause
> bad use of L2 caches ...
>
> > As long as your cache size is less than 256K, you don't get cache aliasing
> > through shared memory.
>
> Actually the "alias set" has to be less than 256kB.  On existing MIPS
> implementations it's at most 16kB; a sillyness of the R4000 / R4400 VCE
> exceptions makes a value of 32kB mandatory for poerformance reasons.
>
> > Perhaps other arches don't have cache aliasing?  I know for sure i386
> > does not have that effect.
>
> The problem doesn't exist on physically indexed caches.  Also on read-only
> caches such as the instruction cache it usually can be ignored.  So for
> example the R2000, R3000, SB1 cores, RM7000, R4kc and R5kc in the right
> configurations and the R10000 family don't suffer from aliases.  Details
> are messy :)
>
>   Ralf
