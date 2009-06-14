Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jun 2009 15:41:07 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43690 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492609AbZFONlA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Jun 2009 15:41:00 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5E9CkdU027907;
	Sun, 14 Jun 2009 10:15:26 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5E9Cjho027905;
	Sun, 14 Jun 2009 10:12:45 +0100
Date:	Sun, 14 Jun 2009 10:12:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	wuzhangjin@gmail.com, linux-mips@linux-mips.org
Subject: Re: Error: symbol `__pastwait' is already defined
Message-ID: <20090614091245.GA27667@linux-mips.org>
References: <1244879922.24479.30.camel@falcon> <4A33D2EA.801@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A33D2EA.801@paralogos.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 13, 2009 at 06:25:14PM +0200, Kevin D. Kissell wrote:

> Calling a function does not cause replication of its symbols.  That  
> would happen if it were a macro, or an inline function, but not a simple  
> global function, which r4k_wait_irqoff is supposed to be, since (at  
> least the last time I worked with it), it is only called indirectly by  
> having its address stored in the cpu_wait function pointer.  Either your  
> compiler is doing something insane and replicating the function each  
> time its address is taken (!), or someone has added another __pastwait  
> symbol somewhere.
>
> And you are correct that moving the symbol to another function risks  
> breaking the functionality. Even if the compiler didn't reorder things -  
> which you are correct to note that it might do - you would create a  
> window during which the kernel would mistakenly believe that the CPU was  
> in the interrupt-disabled wait state when in fact it had just fallen out  
> of the loop and serviced an interrupt.  I don't think that would  
> necessarily be fatal, but it would at least be inefficient.

It depends on how gcc optimized the if statement.  Gcc might compile the
function as if it was written like this:

void r4k_wait_irqoff(void)
{
	local_irq_disable();
	if (need_resched())
		goto nowait;

	__asm__(
	"	.set	push		\n"
	"	.set	mips3		\n"
	"	wait			\n"
	"	.set	pop		\n");
	local_irq_enable();
	__asm__(
	"	.globl	__pastwait	\n"
	"__pastwait:			\n");
	return;

nowait
	local_irq_enable();
	__asm__(
	"	.globl	__pastwait	\n"
	"__pastwait:			\n");
}

Which isn't quite the brightest thing to do but perfectly legal.  As for
gcc follow the old motto trust is futile, suspicion breeds confidence.

  Ralf
