Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Sep 2004 12:39:17 +0100 (BST)
Received: from smtp.seznam.cz ([IPv6:::ffff:212.80.76.43]:18914 "HELO
	smtp.seznam.cz") by linux-mips.org with SMTP id <S8224990AbUI0LjM>;
	Mon, 27 Sep 2004 12:39:12 +0100
Received: (qmail 13165 invoked from network); 27 Sep 2004 11:39:01 -0000
Received: from unknown (HELO umax645sx) (Ladislav.Michl@160.218.40.3)
  by smtp.seznam.cz with SMTP; 27 Sep 2004 11:39:01 -0000
Received: from ladis by umax645sx with local (Exim 3.36 #1 (Debian))
	id 1CAUw8-0004cZ-00; Thu, 23 Sep 2004 16:51:08 +0200
Date: Thu, 23 Sep 2004 16:51:08 +0200
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Kernel 2.6 for R4600 Indy
Message-ID: <20040923145108.GA17740@umax645sx>
References: <4152D58B.608@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4152D58B.608@longlandclan.hopto.org>
User-Agent: Mutt/1.5.6+20040818i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 23, 2004 at 11:54:19PM +1000, Stuart Longland wrote:
> Hi All,
> 	I've been trying to get Linux 2.6 going on my Indy for some time now.
> However, I've had little success.  The machine works just fine under
> Linux 2.4.26.
> 
> 	The kernel config is attached.  Basically I've tried both booting a
> MIPS32 kernel as well as a MIPS64 kernel.  In all cases, I've used the
> same kernel parameters.  (root=/dev/hda3, and sometimes I put
> init=/bin/sh or single there too.)
> 
> 	Using a MIPS32 config, the kernel boots, mounts the / filesystem, but
> then dies claiming it can't find /sbin/init.
> 
> 	Using a MIPS64 config (built using gas-abi=o32 as suggested by Kumba),
> it doesn't even get that far:
> 
> - From arcboot/SGI PROM:
> (Arcboot version 0.3.8.2)
> - -------------------------------8<--------------------------------------
> Loading program segment 2 at 0x88002000, offset=0x0, size= 0x0 328085
> Zeroing memory at 0x0032a085, size = 0x1bba3
> 
> Exception: <vector=Normal>
> Status register: 0x30004803<CU1,CU0,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
> Cause register: 0x8010<CE=0,IP8,EXC=RADE>
> Exception PC: 0x830f018, Exception RA: 0x88804514
> Read address error exception, bad address: 0x830f018
> Local I/O interrupt register 1: 0x80 <VR/GIO2>
>   Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
>   arg: a8740000 88002000 88001fe0 18
>   tmp: a8740000 3 8880e0b4 830f018 8880e0b0 887fe8ec 887fe5e4 4
>   sve: a8740000 3 400000 800000 16 3f80 0 10000000
>   t8 a8740000 t9 ffffffff at ffffffff v0 ffffffff v1 ffffffff k1 830f018
>   gp a8740000 f0 ffffffff sp ffffffff ra ffffffff
> 
> PANIC: Unexpected exception

If that's more than two hours old CVS kernel then it's my fault, already fixed.
[snip]

> 	Apologies if this has been answered before... but I'm a bit of a newbie
> when it comes to Linux/MIPS.[2]  Is there anything I missed when setting
> this all up?

We have both Indy and O2 running there, but you'll have to wait a bit
until patches appear in CVS.

Regards,
	ladis
