Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g15Hlk909304
	for linux-mips-outgoing; Tue, 5 Feb 2002 09:47:46 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g15HlfA09301
	for <linux-mips@oss.sgi.com>; Tue, 5 Feb 2002 09:47:41 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA08451;
	Tue, 5 Feb 2002 09:47:33 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id JAA15438;
	Tue, 5 Feb 2002 09:47:32 -0800 (PST)
Received: from copsun18.mips.com (copsun18 [192.168.205.28])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g15Hl4A25550;
	Tue, 5 Feb 2002 18:47:04 +0100 (MET)
From: Hartvig Ekner <hartvige@mips.com>
Received: (from hartvige@localhost)
	by copsun18.mips.com (8.9.1/8.9.0) id SAA21696;
	Tue, 5 Feb 2002 18:47:28 +0100 (MET)
Message-Id: <200202051747.SAA21696@copsun18.mips.com>
Subject: Re: What is the maximum physical RAM for a 32bit MIPS core?
To: sjhill@cotw.com
Date: Tue, 5 Feb 2002 18:47:28 +0100 (MET)
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3C600D4C.43CBA784@cotw.com> from "Steven J. Hill" at Feb 05, 2002 10:50:20 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You have to distinguish between physical and virtual memory. The MIPS32
architecture supports implementations with up to 36 bits of physical
address space, however the virtual address space in kernel and user mode
is as you describe below.

One note: Many MIPS32 implementations choose not to implement all 36 PA
bits, but limit themselves to 32 bits. This saves a few bits in the TLB
and a few address lines.

And no to the FP thing: FP registers can only be used to hold FP values.
All addressing is done through integer registers. And any given process
can only see 2GB anyway.

/Hartvig

Steven J. Hill writes:
> 
> I am just trying to fill in some more MIPS knowledge here. With a 32-bit
> MIPS processor, we are forever limited to a userspace of 2GB in size thanks
> to the kuser region. kseg0/1 map the same 512MB of physical memory. kseg2
> is 1GB in size and hence it could address another 1GB of RAM. So, is the
> maximum amount of RAM for a 32bit MIPS core:
> 
>    1) 1.5GB = 0.5GB kseg0/1 + 1.0GB kseg2
> 
>    2) 4.0GB = largest 32-bit address
> 
>    3) Something larger than 4.0GB by adding fancy external HW logic
> 
> Also, for choice #3, while it would be a hit in performance, could you use
> the fp registers for 64-bit pointers to address larger than 4.0GB?
> 
> Thanks in advance.
> 
> -Steve
>       
> -- 
>  Steven J. Hill - Embedded SW Engineer
> 


-- 
 _    _   _____  ____     Hartvig Ekner        Mailto:hartvige@mips.com
 |\  /| | |____)(____                          Direct: +45 4486 5503
 | \/ | | |     _____)    MIPS Denmark         Switch: +45 4486 5555
T E C H N O L O G I E S   http://www.mips.com  Fax...: +45 4486 5556
