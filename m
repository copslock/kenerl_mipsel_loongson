Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 May 2009 12:01:10 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:56050 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024943AbZEBLBC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 2 May 2009 12:01:02 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1M0Cxo-0004VQ-00; Sat, 02 May 2009 13:01:00 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 8B62AC2D1B; Sat,  2 May 2009 13:00:55 +0200 (CEST)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH] MIPS: check for R5k XKPHYS bug
To:	linux-mips@linux-mips.org
cc:	ralf@linux-mips.org
Message-Id: <20090502110055.8B62AC2D1B@solo.franken.de>
Date:	Sat,  2 May 2009 13:00:55 +0200 (CEST)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

R5k CPUs have a bug, where ll access to XKPHYS addresses don't work.
Check for this bug and enable workaround, if possible.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 arch/mips/kernel/cpu-bugs64.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.c
index 02b7713..8e55649 100644
--- a/arch/mips/kernel/cpu-bugs64.c
+++ b/arch/mips/kernel/cpu-bugs64.c
@@ -26,6 +26,8 @@ static char r4kwar[] __initdata =
 	"Enable CPU_R4000_WORKAROUNDS to rectify.";
 static char daddiwar[] __initdata =
 	"Enable CPU_DADDI_WORKAROUNDS to rectify.";
+static char xkphysllwar[] __initdata =
+	"CPU has ll xkphys bug.";
 
 static inline void align_mod(const int align, const int mod)
 {
@@ -307,10 +309,44 @@ static inline void check_daddiu(void)
 	panic(bug64hit, !DADDI_WAR ? daddiwar : nowar);
 }
 
+static u32 ll(u32 *p)
+{
+	u32 ret;
+
+	asm volatile(
+		"ll    %0, %1\n\t"
+		: "=&r" (ret)
+		: "m" (*p));
+
+	return ret;
+}
+
+void __init check_ll_xkphys(void)
+{
+	static u32 val;
+	u32 *p = (u32 *)PHYS_TO_XKPHYS(K_CALG_NONCOHERENT,
+				       CPHYSADDR((unsigned long)&val));
+
+	printk("Checking for the ll/lld xkphys bug... ");
+	memset(p, 0xff, sizeof(val));
+	if (ll(p) != 0xffffffff) {
+		printk("yes, enabling workaround... ");
+		cpu_data[0].options &= ~MIPS_CPU_LLSC;
+		if (cpu_has_llsc != (cpu_data[0].options & MIPS_CPU_LLSC)) {
+			printk("failed.\n");
+			panic(bug64hit, xkphysllwar);
+		}
+		printk("ok.\n");
+	} else
+		printk("no.\n");
+}
+
+
 void __init check_bugs64_early(void)
 {
 	check_mult_sh();
 	check_daddiu();
+	check_ll_xkphys();
 }
 
 void __init check_bugs64(void)
