Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2010 12:36:30 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39199 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492502Ab0ALLg0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Jan 2010 12:36:26 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0CBaN9U002612;
        Tue, 12 Jan 2010 12:36:24 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0CBaJFI002609;
        Tue, 12 Jan 2010 12:36:19 +0100
Date:   Tue, 12 Jan 2010 12:36:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Greg KH <gregkh@suse.de>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/7] MIPS: Octeon: Fix EIO handling.
Message-ID: <20100112113619.GA26806@linux-mips.org>
References: <4B463005.8060505@caviumnetworks.com>
 <1262891106-32146-1-git-send-email-ddaney@caviumnetworks.com>
 <4B4645EE.5050302@ru.mvista.com>
 <4B464977.2090801@caviumnetworks.com>
 <20100107215950.GA24672@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100107215950.GA24672@suse.de>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7753

On Thu, Jan 07, 2010 at 01:59:50PM -0800, Greg KH wrote:

> >>> If an interrupt handler disables interrupts, the EOI function will
> >>> just reenable them.  This will put us in an endless loop when the
> >>> upcoming Ethernet driver patches are applied.
> >>>
> >>> Only reenable the interrupt on EOI if it is not IRQ_DISABLED.  This
> >>> requires that the EIO function be separate from the ENABLE function.
> >>> We also rename the ACK functions to correspond with their function.
> >>>
> >>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> >>>   
> >>
> >>   I guess the subject should read "EIO", not "EIO"...
> >>
> >
> > Indeed.  The compiler didn't catch that one.
> >
> > Perhaps Ralf can fix it if he merges it, otherwise I can resubmit with 
> > corrected spelling.
> 
> I can change it when merging, don't worry about it.

This is a driver specific to a specific MIPS platform so I think this
series should be merged via the MIPS tree and assuming Greg is ok with that
I have merged this into my tree.

  Ralf
