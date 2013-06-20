Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 15:32:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55642 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817528Ab3FTNcWzf2D4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Jun 2013 15:32:22 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5KDWJhU027290;
        Thu, 20 Jun 2013 15:32:19 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5KDWIrE027289;
        Thu, 20 Jun 2013 15:32:18 +0200
Date:   Thu, 20 Jun 2013 15:32:18 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: Add missing hazard barrier in TLB load handler.
Message-ID: <20130620133218.GA25622@linux-mips.org>
References: <1371707874-6632-1-git-send-email-Steven.Hill@imgtec.com>
 <51C2E3F5.7040507@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51C2E3F5.7040507@cogentembedded.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37053
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

On Thu, Jun 20, 2013 at 03:13:57PM +0400, Sergei Shtylyov wrote:

> >+#if !defined(CONFIG_CPU_CAVIUM_OCTEON)
> 
>     Suggesting to use if (!IS_ENABLED(CONFIG_CPU_CAVIUM_OCTEON)) to
> avoid #ifdef...

An ifdef in disguise.  IS_ENABLED() gives better coverage in build tests
but that's about it, it allows more readable formatting.  But that's
about it's advantages.

Never use CONFIG_CPU_* to conditionally execute code only on certain
CPU types.  It's not consistently used like this everywhere but it's meant
to select optimization for a particular processor type.

For example on the Malta, a system that's notorious for supporting
particularly man processor types CONFIG_CPU_R4X00 might be set but the
actual core core be a lowly R4Kc or the latest 666Kfc MIPS64 R6 core from
hell.

CONFIG_SYS_HAS_CPU_* only expresses that a system _might_ be equipped
with a particular processor, that is support for this core should be
compiled in.  An arbitrary number of CONFIG_SYS_HAS_CPU_* may be enabled.

If you really need to test for a processor at runtime, use current_cpu_type().
Typically that's done in a switch and there are plenty of example scattered
around arch/mips/mm/.

It's possible to replace the current current_cpu_type() with a platform-
specific version that looks (example for Cavium Octeon) like:

static inline int __pure current_cpu_type(void)
{
	const int cpu_type = current_cpu_data.cputype;

	switch (cpu_type) {
	case CPU_CAVIUM_OCTEON:
	case CPU_CAVIUM_OCTEON_PLUS:
	case CPU_CAVIUM_OCTEON2:
		break;

	default:
		unreachable();
	}

	return cpu_type;
}

Modern GCC will then notice that current_cpu_type() may only ever return
the values CPU_CAVIUM_OCTEON, CPU_CAVIUM_OCTEON_PLUS and CPU_CAVIUM_OCTEON2
and will discard all the non-Octeon code from a switch construct like this:

	switch (current_cpu_type()) {
	case CPU_R2000:
	case CPU_R3000:
		...
		break;

	case CPU_CAVIUM_OCTEON:
	case CPU_CAVIUM_OCTEON_PLUS:
	case CPU_CAVIUM_OCTEON2:
		break;
	}

Result: sane, clean code.

  Ralf

MIPS: Fix TLBR-use hazards for R2 cores in the TLB reload handlers

MIPS R2 documents state that an execution hazard barrier is needed
after a TLBR before reading EntryLo.

Original patch by Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
---
 arch/mips/mm/tlbex.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index bfff8fe..34c882c 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1932,6 +1932,19 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		uasm_i_nop(&p);
 
 		uasm_i_tlbr(&p);
+
+		switch (current_cpu_type()) {
+		default:
+			if (cpu_has_mips_r2) {
+				uasm_i_ehb(&p);
+
+		case CPU_CAVIUM_OCTEON:
+		case CPU_CAVIUM_OCTEON_PLUS:
+		case CPU_CAVIUM_OCTEON2:
+				break;
+			}
+		}
+
 		/* Examine  entrylo 0 or 1 based on ptr. */
 		if (use_bbit_insns()) {
 			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
@@ -1986,6 +1999,19 @@ static void __cpuinit build_r4000_tlb_load_handler(void)
 		uasm_i_nop(&p);
 
 		uasm_i_tlbr(&p);
+
+		switch (current_cpu_type()) {
+		default:
+			if (cpu_has_mips_r2) {
+				uasm_i_ehb(&p);
+
+		case CPU_CAVIUM_OCTEON:
+		case CPU_CAVIUM_OCTEON_PLUS:
+		case CPU_CAVIUM_OCTEON2:
+				break;
+			}
+		}
+
 		/* Examine  entrylo 0 or 1 based on ptr. */
 		if (use_bbit_insns()) {
 			uasm_i_bbit0(&p, wr.r2, ilog2(sizeof(pte_t)), 8);
