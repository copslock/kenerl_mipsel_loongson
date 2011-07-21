Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jul 2011 15:55:38 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36844 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491099Ab1GUNza (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jul 2011 15:55:30 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p6LDtQKU000554;
        Thu, 21 Jul 2011 14:55:26 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p6LDtPh1000551;
        Thu, 21 Jul 2011 14:55:25 +0100
Date:   Thu, 21 Jul 2011 14:55:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2 v2] MIPS: Close races in TLB modify handlers.
Message-ID: <20110721135525.GB27341@linux-mips.org>
References: <1309908886-1624-1-git-send-email-david.daney@cavium.com>
 <1309908886-1624-2-git-send-email-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1309908886-1624-2-git-send-email-david.daney@cavium.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15069

On Tue, Jul 05, 2011 at 04:34:46PM -0700, David Daney wrote:

> Page table entries are made invalid by writing a zero into the the PTE
> slot in a page table.  This creates a race condition with the TLB
> modify handlers when they are updating the PTE.
> 
> CPU0                              CPU1
> 
> Test for _PAGE_PRESENT
> .                                 set to not _PAGE_PRESENT (zero)
> Set to _PAGE_VALID
> 
> So now the page not present value (zero) is suddenly valid and user
> space programs have access to physical page zero.
> 
> We close the race by putting the test for _PAGE_PRESENT and setting of
> _PAGE_VALID into an atomic LL/SC section.  This requires more
> registers than just K0 and K1 in the handlers, so we need to save some
> registers to a save area and then restore them when we are done.
> 
> The save area is an array of cacheline aligned structures that should
> not suffer cache line bouncing as they are CPU private.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Looks good and nobody else has complained but backporting to <= 2.6.37 is
gonna be ugly.  I either have to resolve huge conflicts or alternatively
backport tons of other tlbex.c patches.  The latter is less risky and
time consuming and will provide additional benefit so I'll do it.  Just
be prepared for a storm on the linux-git list.

  Ralf
