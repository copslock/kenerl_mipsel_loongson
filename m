Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Aug 2004 09:00:58 +0100 (BST)
Received: from p508B5A8A.dip.t-dialin.net ([IPv6:::ffff:80.139.90.138]:39764
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224922AbUHYIAx>; Wed, 25 Aug 2004 09:00:53 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i7P80pN2027404;
	Wed, 25 Aug 2004 10:00:51 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i7P80jkS027403;
	Wed, 25 Aug 2004 10:00:45 +0200
Date: Wed, 25 Aug 2004 10:00:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Macleod <macleod@mail2000.com.tw>
Cc: linux-mips@linux-mips.org
Subject: Re: System call select on R4600
Message-ID: <20040825080045.GA25537@linux-mips.org>
References: <1093400284.64232.macleod@mail2000.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093400284.64232.macleod@mail2000.com.tw>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 25, 2004 at 10:18:04AM +0800, Macleod wrote:

>  After trace system, found this problem is from scall_o32.S
>  line 161 in 2.4.26 kernel.
> 
>  bltz t0, bad_stack   # -> sp is bad
> 
>  If stack address larger than 0x7fffffff, branch will take, 
>  and that's why I got "-4142" errno on select system call
>  even parameters in stack are correct. I tried to remove this
>  line and seems "select" works fine.

Oh yes, I forgot on this one :-)  It's intentional; making all syscalls
work from kernel mode would add some overhead.  Possible solutions:

 - move to 64-bit kernels; the 64-bit syscall interface happens to support
   upto 8 arguments for syscalls from kernel mode.
 - move your module or parts of it to userspace.  Something that's using
   select suspiciously looks like something that shouldn't be in the kernel.
 - use the proper kernel APIs.  Kernel programming isn't user space
   programming.

  Ralf
