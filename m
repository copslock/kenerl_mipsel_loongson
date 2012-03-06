Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2012 20:08:35 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38414 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903662Ab2CFTIa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2012 20:08:30 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id q26J8SZB024838;
        Tue, 6 Mar 2012 20:08:28 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id q26J8QXd024837;
        Tue, 6 Mar 2012 20:08:26 +0100
Date:   Tue, 6 Mar 2012 20:08:26 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/5] MIPS: module.h usage cleanup.
Message-ID: <20120306190826.GJ4519@linux-mips.org>
References: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1330457088-14587-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Feb 28, 2012 at 02:24:43PM -0500, Paul Gortmaker wrote:

> Hi Ralf,
> 
> Not a lot to see here, really.  MIPS had usages of module.h tucked
> away in a couple asm files, and that was masking some of the other
> implicit users, plus preventing MIPS from getting the full benefit
> of not having to feed module.h to cpp 35,000 times.
> 
> I've left the two drivers/serial commits separate, in case there
> is a desire to have them go in via Greg's trees, but they are a
> required dependency for the arch/mips fixes, so I think it makes
> sense they stay together with the other changes here.
> 
> I will have some arch independent module.h cleanups (in fs and lib)
> that will require me to create a module.h tree for 3.4, so I can
> carry this there if required.  But this lot is all self-contained
> to MIPS and so I'd be fine with (and actually prefer) this going in
> via the MIPS tree.  No strong preference - either way, let me know.

Haven't received any comment and the patches are trivial so I'm going
to queue them hopeing that Alan Cox (not on cc ...) doesn't mind ...

  Ralf
