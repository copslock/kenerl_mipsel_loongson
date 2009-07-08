Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2009 19:40:57 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49756 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492482AbZGHRks (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Jul 2009 19:40:48 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n68HefIT004424;
	Wed, 8 Jul 2009 18:40:41 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n68HeeWo004422;
	Wed, 8 Jul 2009 18:40:40 +0100
Date:	Wed, 8 Jul 2009 18:40:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Avoid clobbering struct pt_regs in kthreads (v2).
Message-ID: <20090708174040.GA4069@linux-mips.org>
References: <1247072870-14460-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1247072870-14460-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 08, 2009 at 10:07:50AM -0700, David Daney wrote:

> The resume() implementation octeon_switch.S examines the saved
> cp0_status register.  We were clobbering the entire pt_regs structure
> in kernel threads leading to random crashes.
> 
> When switching away from a kernel thread, the saved cp0_status is
> examined and if bit 30 is set it is cleared and the CP2 state saved
> into the pt_regs structure.  Since the kernel thread stack overlaid
> the pt_regs structure this resulted in a corrupt stack.  When the
> kthread with the corrupt stack was resumed, it could crash if it used
> any of the data in the stack that was clobbered.
> 
> We fix it by moving the kernel thread stack down so it doesn't overlay
> pt_regs.
> 
> Differences from v1: Don't adjust the sp by an additional 32 bytes, it
>                      was not needed.  Also fix up __KSTK_TOS and
>                      task_pt_regs.

Thanks for fixing and testing the issues I raised on IRC.  Next I'm wonding
what impact the uninitialized state of the stack frame we allocate may
have.  I think we're ok - but I need to stare at this for a few more
minutes.

  Ralf
