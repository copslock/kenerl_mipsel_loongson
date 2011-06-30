Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2011 01:34:15 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:47603 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491163Ab1F3XeJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jul 2011 01:34:09 +0200
Date:   Fri, 1 Jul 2011 00:34:09 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     David Daney <david.daney@cavium.com>
cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Close races in TLB modify handlers.
In-Reply-To: <1309473062-11041-1-git-send-email-david.daney@cavium.com>
Message-ID: <alpine.LFD.2.00.1106302358550.29709@eddie.linux-mips.org>
References: <1309473062-11041-1-git-send-email-david.daney@cavium.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 30573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 124

Hi David,

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

 Hmm, good catch, but doesn't your change pessimise the UP case?  It looks 
to me like you save & restore the scratch registers even though the race 
does not apply to UP (you can't interrupt a TLB handler, not at this 
stage).

  Maciej
