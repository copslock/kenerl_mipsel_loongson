Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Dec 2004 04:56:11 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:52338
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224988AbULCEz7>; Fri, 3 Dec 2004 04:55:59 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Ca5U5-0006xP-00; Fri, 03 Dec 2004 05:55:57 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Ca5U4-0003GD-00; Fri, 03 Dec 2004 05:55:56 +0100
Date: Fri, 3 Dec 2004 05:55:56 +0100
To: David Daney <ddaney@avtrex.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [Patch] make 2.4 compile with GCC-3.4.3...
Message-ID: <20041203045556.GB8714@rembrandt.csv.ica.uni-stuttgart.de>
References: <41AFDA18.2010906@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41AFDA18.2010906@avtrex.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

David Daney wrote:
[snip]
> *** kernel/Makefile	2 Dec 2004 19:50:05 -0000	1.2
> --- kernel/Makefile	3 Dec 2004 03:00:44 -0000
> *************** obj-y		+= branch.o cpu-probe.o irq.o pro
> *** 18,23 ****
> --- 18,27 ----
>   		   traps.o ptrace.o reset.o semaphore.o setup.o syscall.o \
>   		   sysmips.o ipc.o scall_o32.o time.o unaligned.o
>   
> + check_gcc = $(shell if $(CC) $(1) -S -o /dev/null -xc /dev/null > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi)
> + 
> + syscall.o signal.o : override CFLAGS += $(call check_gcc, -fno-unit-at-a-time,)

What difference does this cause?

[snip]
> --- 77,84 ----
>    * Atomically swap in the new signal mask, and wait for a signal.
>    */
>   save_static_function(sys_sigsuspend);
> ! __attribute_used__ static int
> ! _sys_sigsuspend(struct pt_regs regs)

These should also use "noinline", like 2.6.


Thiemo
