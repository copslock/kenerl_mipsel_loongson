Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2009 17:30:13 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:54402 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024226AbZE0QaF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 May 2009 17:30:05 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4RGTfLc011115;
	Wed, 27 May 2009 17:29:43 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4RGTc4x011105;
	Wed, 27 May 2009 17:29:38 +0100
Date:	Wed, 27 May 2009 17:29:37 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Don't write ones to reserved entryhi bits.
Message-ID: <20090527162937.GA9831@linux-mips.org>
References: <1241812330-21041-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1241812330-21041-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 08, 2009 at 12:52:10PM -0700, David Daney wrote:

> According to the MIPS64 Privileged Resource Architecture manual, only
> values of zero may be written to bits 8..10 of CP0 entryhi.  We need
> to add masking by ASID_MASK.

Yes, I've silently been relying on the hardware chopping off the excess
bits for no better reason that it saving an instruction.  One of the
functions you've touched is switch_mm() which is being used in context
switches and any changes to it will show up in context switching
benchmarks.

The patch you did (and along with that some older SMTC changes by Kevin)
can be done slightly more elegant because we already have:

#define cpu_asid(cpu, mm)       (cpu_context((cpu), (mm)) & ASID_MASK)

in <asm/mmu_context.h>.

We used to optimize the ASID managment code by code patching even, see
mmu_context.h in 78c388aed2b7184182c08428db1de6c872d815f5.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/mmu_context.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index d7f3eb0..25a50fa 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -164,12 +164,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 * having ASID_MASK smaller than the hardware maximum,
 	 * make sure no "soft" bits become "hard"...
 	 */
-	write_c0_entryhi((read_c0_entryhi() & ~HW_ASID_MASK)
-			| (cpu_context(cpu, next) & ASID_MASK));
+	write_c0_entryhi((read_c0_entryhi() & ~HW_ASID_MASK) |
+			 cpu_asid(cpu, next));
 	ehb(); /* Make sure it propagates to TCStatus */
 	evpe(mtflags);
 #else
-	write_c0_entryhi(cpu_context(cpu, next));
+	write_c0_entryhi(cpu_asid(cpu, next));
 #endif /* CONFIG_MIPS_MT_SMTC */
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
 
@@ -225,11 +225,11 @@ activate_mm(struct mm_struct *prev, struct mm_struct *next)
 	}
 	/* See comments for similar code above */
 	write_c0_entryhi((read_c0_entryhi() & ~HW_ASID_MASK) |
-	                 (cpu_context(cpu, next) & ASID_MASK));
+	                 cpu_asid(cpu, next));
 	ehb(); /* Make sure it propagates to TCStatus */
 	evpe(mtflags);
 #else
-	write_c0_entryhi(cpu_context(cpu, next));
+	write_c0_entryhi(cpu_asid(cpu, next));
 #endif /* CONFIG_MIPS_MT_SMTC */
 	TLBMISS_HANDLER_SETUP_PGD(next->pgd);
 
