Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 23:49:13 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:39647 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225525AbUDTWtM>;
	Tue, 20 Apr 2004 23:49:12 +0100
Received: from drow by nevyn.them.org with local (Exim 4.32 #1 (Debian))
	id 1BG437-0001Bu-1B; Tue, 20 Apr 2004 18:49:05 -0400
Date: Tue, 20 Apr 2004 18:49:05 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Harm Verhagen <hverhagen@dse.nl>
Cc: linux-mips@linux-mips.org
Subject: Re: locking problems with mips atomicity ?
Message-ID: <20040420224904.GA21924@nevyn.them.org>
References: <1082501074.13783.54.camel@node-d-8d2e.a2000.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082501074.13783.54.camel@node-d-8d2e.a2000.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 21, 2004 at 12:44:34AM +0200, Harm Verhagen wrote:
> The code from linux 2.4.26 arch-mips/atomic.h looks _very_ similar to
> the code described in the thread that has a BUG.
> 
> static __inline__ void atomic_add(int i, atomic_t * v)
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
> So I wonder if there is a bug here. 
> Can some MIPS guru check ? :)

It won't be a problem in the kernel.  The problem only happens when the
assembler expands a macro to multiple instructions including a load,
and that only happens for position-independent code; the kernel is not
PIC.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
