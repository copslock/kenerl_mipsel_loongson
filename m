Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 22:38:17 +0100 (BST)
Received: from purplechoc.demon.co.uk ([IPv6:::ffff:80.176.224.106]:53376 "EHLO
	skeleton-jack.localnet") by linux-mips.org with ESMTP
	id <S8225779AbUERViQ>; Tue, 18 May 2004 22:38:16 +0100
Received: from pdh by skeleton-jack.localnet with local (Exim 3.36 #1 (Debian))
	id 1BQCHq-00037D-00; Tue, 18 May 2004 22:38:10 +0100
Date: Tue, 18 May 2004 22:38:10 +0100
To: Kieran Fulke <kieran@pawsoff.org>
Cc: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040518213810.GA11885@skeleton-jack>
References: <20040513183059.GA25743@getyour.pawsoff.org> <20040518073439.GA6818@skeleton-jack> <20040518205914.GA29574@getyour.pawsoff.org> <20040518211246.GA11722@skeleton-jack> <20040518211810.GA29636@getyour.pawsoff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040518211810.GA29636@getyour.pawsoff.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Peter Horton <pdh@colonel-panic.org>
Return-Path: <pdh@colonel-panic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pdh@colonel-panic.org
Precedence: bulk
X-list: linux-mips

On Tue, May 18, 2004 at 10:18:10PM +0100, Kieran Fulke wrote:
> On Tue, May 18, 2004 at 10:12:46PM +0100, Peter Horton wrote:
> 
> > 
> > That's strange, it worked here.
> > 
> > Did you a clean build ?
> > 
> 
> yeah. cleared out /usr/src and re-emerged mips-sources-2.6.6, then made 
> the change to include/asm/cobalt/cobalt.h you suggested. kernel 
> .config attached ..
> 

Does this patch fix it ?

P.

--- linux.cvs/arch/mips/cobalt/irq.c	2003-11-13 14:30:45.000000000 +0000
+++ linux.pdh/arch/mips/cobalt/irq.c	2004-05-18 22:35:32.000000000 +0100
@@ -82,11 +83,15 @@
 	}
 
 	if (pending & CAUSEF_IP7) {			/* int 23 */
-		do_IRQ(COBALT_QUBE_SLOT_IRQ, regs);
+		do_IRQ(23, regs);
 		return;
 	}
 }
