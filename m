Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Apr 2004 23:54:54 +0100 (BST)
Received: from amsfep17-int.chello.nl ([IPv6:::ffff:213.46.243.15]:30294 "EHLO
	amsfep17-int.chello.nl") by linux-mips.org with ESMTP
	id <S8225770AbUDTWyx>; Tue, 20 Apr 2004 23:54:53 +0100
Received: from node-d-8d2e.a2000.nl ([62.195.141.46])
          by amsfep17-int.chello.nl
          (InterMail vM.6.00.05.02 201-2115-109-103-20031105) with ESMTP
          id <20040420225448.EBDX15425.amsfep17-int.chello.nl@node-d-8d2e.a2000.nl>;
          Wed, 21 Apr 2004 00:54:48 +0200
Subject: Re: locking problems with mips atomicity ?
From: Harm Verhagen <hverhagen@dse.nl>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@linux-mips.org
In-Reply-To: <20040420224904.GA21924@nevyn.them.org>
References: <1082501074.13783.54.camel@node-d-8d2e.a2000.nl>
	 <20040420224904.GA21924@nevyn.them.org>
Content-Type: text/plain
Organization: 
Message-Id: <1082501636.13783.69.camel@node-d-8d2e.a2000.nl>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Apr 2004 00:53:56 +0200
Content-Transfer-Encoding: 7bit
Return-Path: <hverhagen@dse.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hverhagen@dse.nl
Precedence: bulk
X-list: linux-mips

On Wed, 2004-04-21 at 00:49, Daniel Jacobowitz wrote:
> On Wed, Apr 21, 2004 at 12:44:34AM +0200, Harm Verhagen wrote:
> > The code from linux 2.4.26 arch-mips/atomic.h looks _very_ similar to
> > the code described in the thread that has a BUG.
> > 
> > static __inline__ void atomic_add(int i, atomic_t * v)
> > {
> > 	unsigned long temp;
> > 
> > 	__asm__ __volatile__(
> > 		"1:   ll      %0, %1      # atomic_add\n"
> > 		"     addu    %0, %2                  \n"
> > 		"     sc      %0, %1                  \n"
> > 		"     beqz    %0, 1b                  \n"
> > 		: "=&r" (temp), "=m" (v->counter)
> > 		: "Ir" (i), "m" (v->counter));
> > }
> > 
> > So I wonder if there is a bug here. 
> > Can some MIPS guru check ? :)
> 
> It won't be a problem in the kernel.  The problem only happens when the
> assembler expands a macro to multiple instructions including a load,
> and that only happens for position-independent code; the kernel is not
> PIC.
Sorry for not understanding completely. What makes the gcc code PIC
then? The code looks similar, an inline function with inline assembly.
Could you elaborate ?

Kind regards,
Harm
