Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Apr 2003 03:09:54 +0100 (BST)
Received: from p508B5B2E.dip.t-dialin.net ([IPv6:::ffff:80.139.91.46]:64740
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbTDCCJx>; Thu, 3 Apr 2003 03:09:53 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3329mi22419;
	Thu, 3 Apr 2003 04:09:48 +0200
Date: Thu, 3 Apr 2003 04:09:47 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Mike K." <linux_linux_2003@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: __asm__  C code in mips-Linux
Message-ID: <20030403040947.A21764@linux-mips.org>
References: <BAY2-F148jSQU0d0uub000985dc@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BAY2-F148jSQU0d0uub000985dc@hotmail.com>; from linux_linux_2003@hotmail.com on Wed, Apr 02, 2003 at 05:02:08PM -0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 02, 2003 at 05:02:08PM -0800, Mike K. wrote:

> extern __inline__ void atomic_add(int i, atomic_t * v)
> {
> 	unsigned long temp;
> 
> 	__asm__ __volatile__(
> 		"1:   ll      %0, %1      # atomic_add\n"
> 		"     addu    %0, %2                  \n"
> 		"     sc      %0, %1                  \n"
> 		"     beqz    %0, 1b                  \n"
> 		: "=&r" (temp), "=m" (v->counter)
> 		: "Ir" (i), "m" (v->counter));
> }
> 
> 
> Beginner questions on the above code:
> 1. what is %0 %1 %2?
> 2. what is the details meaning of the last two line of the above code?

%0 stands for the 0th operand of the asm statement, that is the temp
variable, %1 for the first that is v->counter, %2 for the second that is
the variable i.  In the strings like "=&r" the = means that the argument
will be assigned to, r means the argument / result is to be passed in a
register (%0 will then be replaced by gcc with that register) and m
means some memory location, gcc will then replace %1 with that memory
location.  "Ir" means gcc can pass the variable i in either a register
(that's the r) or as a 16-bit constant (the I).  Again %3 will be
replaced with whatever gcc deciedes to pass here.  All the output
operands are listed after the first colon - and be marked with a = sign;
the input operands are listed after the second colon.  After a third
colon all registers that get destroyed by a piece of inline assembly
can be listed like :"$5","$6" but we don't need that here.

> 3. Very thanksful if you can comment each line with detail description  for 
> me, thanks a lot!

Your basic spinlock described in the R4000 manual from 10 years ago :-)

  Ralf
