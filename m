Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jan 2010 19:38:00 +0100 (CET)
Received: from imr2.ericy.com ([198.24.6.3]:48734 "EHLO imr2.ericy.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492807Ab0A2Shz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 Jan 2010 19:37:55 +0100
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
        by imr2.ericy.com (8.13.1/8.13.1) with ESMTP id o0TIcf3K022909;
        Fri, 29 Jan 2010 12:38:41 -0600
Received: from localhost (147.117.20.212) by eusaamw0712.eamcs.ericsson.se
 (147.117.20.182) with Microsoft SMTP Server id 8.1.375.2; Fri, 29 Jan 2010
 13:37:44 -0500
Date:   Fri, 29 Jan 2010 10:39:26 -0800
From:   Guenter Roeck <guenter.roeck@ericsson.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney@caviumnetworks.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Kernel crash in 2.6.32.6 / bcm1480 with 16k page size
Message-ID: <20100129183926.GB9895@ericsson.com>
References: <20100128155514.GA31611@ericsson.com> <20100129132406.GD5685@linux-mips.org> <20100129151220.GA3882@ericsson.com> <4B6316D2.1060006@caviumnetworks.com> <20100129180619.GA20113@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20100129180619.GA20113@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guenter.roeck@ericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19050

On Fri, Jan 29, 2010 at 01:06:20PM -0500, Ralf Baechle wrote:
> On Fri, Jan 29, 2010 at 09:11:46AM -0800, David Daney wrote:
> 
> > >So first question would be: Has anyone successfully loaded a 64
> > >bit mips kernel with 2.6.32 and a page size of 16k or 64k ? This
> > >would at least help me reducing the problem to sb1.
> > 
> > Yes, I routinely run with both 64K and 16K page sizes on 2.6.32 and
> > 2.6.33-rc*.  I have not seen any crashes that can not be easily
> > explained.
> 
> I can reproduce it with today's 14b7baff3eb4b1b46a592630e6f85ded9264798a.
> 4K page size works ok, 16K without IPv6 works ok and 16K with IPv6 crashes.
> Note, I was testing with a non-16K capable userland so ok means userland is
> reached.
> 
> Either way, that's good enought to look into things.
> 
16k page size works for me with the patch below. Not that I have any idea why;
this was just a blind test.

It seems to me that the notes in arch/mips/include/asm/pgtable-64.h regarding
available virtual memory per page size may contradict with the definition
of VMALLOC_END. VMALLOC_END-VMALLOC_START increases as the page size increases,
but the comments indicate that a system with 16k pages should have _less_
virtual memory available than a system with 4k pages because it only uses
a 2 level page table.

Guenter

---------------

git diff arch/mips/include/asm/pgtable-64.h
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 9cd5089..bd61030 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -110,7 +110,7 @@
 #define VMALLOC_START          MAP_BASE
 #define VMALLOC_END    \
        (VMALLOC_START + \
-        PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE - (1UL << 32))
+        (PTRS_PER_PGD * PTRS_PER_PMD * PTRS_PER_PTE * PAGE_SIZE / 16) - (1UL << 32))
 #if defined(CONFIG_MODULES) && defined(KBUILD_64BIT_SYM32) && \
        VMALLOC_START != CKSSEG
 /* Load modules into 32bit-compatible segment. */
