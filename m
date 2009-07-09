Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2009 02:09:25 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:35448 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493051AbZGIAJR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Jul 2009 02:09:17 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6909G1i028144;
	Thu, 9 Jul 2009 01:09:16 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6909FaA028142;
	Thu, 9 Jul 2009 01:09:15 +0100
Date:	Thu, 9 Jul 2009 01:09:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Avoid clobbering struct pt_regs in kthreads (v2).
Message-ID: <20090709000915.GA28139@linux-mips.org>
References: <1247072870-14460-1-git-send-email-ddaney@caviumnetworks.com> <20090708174040.GA4069@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090708174040.GA4069@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 08, 2009 at 06:40:40PM +0100, Ralf Baechle wrote:

> > The resume() implementation octeon_switch.S examines the saved
> > cp0_status register.  We were clobbering the entire pt_regs structure
> > in kernel threads leading to random crashes.
> > 
> > When switching away from a kernel thread, the saved cp0_status is
> > examined and if bit 30 is set it is cleared and the CP2 state saved
> > into the pt_regs structure.  Since the kernel thread stack overlaid
> > the pt_regs structure this resulted in a corrupt stack.  When the
> > kthread with the corrupt stack was resumed, it could crash if it used
> > any of the data in the stack that was clobbered.
> > 
> > We fix it by moving the kernel thread stack down so it doesn't overlay
> > pt_regs.
> > 
> > Differences from v1: Don't adjust the sp by an additional 32 bytes, it
> >                      was not needed.  Also fix up __KSTK_TOS and
> >                      task_pt_regs.
> 
> Thanks for fixing and testing the issues I raised on IRC.  Next I'm wonding
> what impact the uninitialized state of the stack frame we allocate may
> have.  I think we're ok - but I need to stare at this for a few more
> minutes.

Applied :)

  Ralf
