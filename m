Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2014 12:33:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41920 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6853518AbaCTLdIXzbQ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Mar 2014 12:33:08 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2KBX61V013673;
        Thu, 20 Mar 2014 12:33:06 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2KBX5pO013672;
        Thu, 20 Mar 2014 12:33:05 +0100
Date:   Thu, 20 Mar 2014 12:33:05 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-mips@linux-mips.org,
        cernekee@gmail.com
Subject: Re: [PATCH] MIPS: make local_irq_disable macro safe for non-mipsr2
Message-ID: <20140320113305.GK17197@linux-mips.org>
References: <1385584490-20589-1-git-send-email-jim2101024@gmail.com>
 <52965CF2.20005@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52965CF2.20005@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39522
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Wed, Nov 27, 2013 at 12:58:26PM -0800, David Daney wrote:

> On 11/27/2013 12:34 PM, Jim Quinlan wrote:
> >For non-mipsr2 processors, the local_irq_disable contains an mfc0-mtc0
> >pair with instructions inbetween.  With preemption enabled, this sequence
> >may get preempted and effect a stale value of CP0_STATUS when executing
> >the mtc0 instruction.  This commit avoids this scenario by incrementing
> >the preempt count before the mfc0 and decrementing it after the mtc9.
> >
> >Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> >---
> >  arch/mips/include/asm/asmmacro.h |   11 +++++++++++
> >  1 files changed, 11 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
> >index 6c8342a..3f809a4 100644
> >--- a/arch/mips/include/asm/asmmacro.h
> >+++ b/arch/mips/include/asm/asmmacro.h
> >@@ -9,6 +9,7 @@
> >  #define _ASM_ASMMACRO_H
> >
> >  #include <asm/hazards.h>
> >+//#include <asm/asm-offsets.h>
> 
> I'm guessing it didn't pass checkpatch.pl
> 
> >
> >  #ifdef CONFIG_32BIT
> >  #include <asm/asmmacro-32.h>
> >@@ -54,11 +55,21 @@
> >  	.endm
> >
> >  	.macro	local_irq_disable reg=t0
> >+#ifdef CONFIG_PREEMPT
> >+	lw      \reg, TI_PRE_COUNT($28)
> >+	addi    \reg, \reg, 1
> >+	sw      \reg, TI_PRE_COUNT($28)
> >+#endif
> 
> Does this need to be atomic?
> 
> More importantly, how does that prevent the problem you describe?
> 
> An interrupt can still occur between the mfc0 and mtc0 causing
> Status bits to be changed.  What bits do we care about?  is it IM*,
> I doubt you would see CU* changing.
> 
> Which bits are getting clobbered that shouldn't be?
> 
> 
> >  	mfc0	\reg, CP0_STATUS
> >  	ori	\reg, \reg, 1
> >  	xori	\reg, \reg, 1
> >  	mtc0	\reg, CP0_STATUS
> >  	irq_disable_hazard
> >+#ifdef CONFIG_PREEMPT
> >+	lw      \reg, TI_PRE_COUNT($28)
> >+	addi    \reg, \reg, -1
> >+	sw      \reg, TI_PRE_COUNT($28)
> >+#endif
> >  	.endm
> >  #endif /* CONFIG_MIPS_MT_SMTC */

This patch is sorting out the part that were missed by e97c5b6098 [MIPS:
Make irqflags.h functions preempt-safe for non-mipsr2 cpus].

This races are easy to hit on systems that use irq-cpu.c, that is the
IM bits directly to process device interrupts.  This for example was
the reason for the '99 vintage patch 94f05bab9b [The CPO_STATUS interrupt
mask patch].  Preemption just made the hole lots bigger.

  Ralf
