Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Mar 2016 23:21:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16985 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008265AbcCAWUD3Kyi- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Mar 2016 23:20:03 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id E7B6F4AE46FE6;
        Tue,  1 Mar 2016 22:19:50 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 22:19:54 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Tue, 1 Mar 2016 22:19:54 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH 4/4] MIPS: Add and use watch register field definitions
Date:   Tue, 1 Mar 2016 22:19:39 +0000
Message-ID: <1456870779-21007-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1456870779-21007-1-git-send-email-james.hogan@imgtec.com>
References: <1456870779-21007-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The files watch.c and ptrace.c contain various magic masks for
WatchLo/WatchHi register fields. Add some definitions to mipsregs.h for
these registers and make use of them in both watch.c and ptrace.c,
hopefully making them more readable.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 18 ++++++++++
 arch/mips/kernel/ptrace.c        |  7 ++--
 arch/mips/kernel/watch.c         | 74 ++++++++++++++++++++++------------------
 3 files changed, 63 insertions(+), 36 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index f7e3215ca2f6..b04f80271f46 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -647,6 +647,24 @@
 /* FTLB probability bits for R6 */
 #define MIPS_CONF7_FTLBP_SHIFT	(18)
 
+/* WatchLo* register definitions */
+#define MIPS_WATCHLO_IRW	(_ULCAST_(0x7) << 0)
+
+/* WatchHi* register definitions */
+#define MIPS_WATCHHI_M		(_ULCAST_(1) << 31)
+#define MIPS_WATCHHI_G		(_ULCAST_(1) << 30)
+#define MIPS_WATCHHI_WM		(_ULCAST_(0x3) << 28)
+#define MIPS_WATCHHI_WM_R_RVA	(_ULCAST_(0) << 28)
+#define MIPS_WATCHHI_WM_R_GPA	(_ULCAST_(1) << 28)
+#define MIPS_WATCHHI_WM_G_GVA	(_ULCAST_(2) << 28)
+#define MIPS_WATCHHI_EAS	(_ULCAST_(0x3) << 24)
+#define MIPS_WATCHHI_ASID	(_ULCAST_(0xff) << 16)
+#define MIPS_WATCHHI_MASK	(_ULCAST_(0x1ff) << 3)
+#define MIPS_WATCHHI_I		(_ULCAST_(1) << 2)
+#define MIPS_WATCHHI_R		(_ULCAST_(1) << 1)
+#define MIPS_WATCHHI_W		(_ULCAST_(1) << 0)
+#define MIPS_WATCHHI_IRW	(_ULCAST_(0x7) << 0)
+
 /* MAAR bit definitions */
 #define MIPS_MAAR_ADDR		((BIT_ULL(BITS_PER_LONG - 12) - 1) << 12)
 #define MIPS_MAAR_ADDR_SHIFT	12
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index a5279b2f3198..48c0534c4d15 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -210,7 +210,8 @@ int ptrace_get_watch_regs(struct task_struct *child,
 	for (i = 0; i < boot_cpu_data.watch_reg_use_cnt; i++) {
 		__put_user(child->thread.watch.mips3264.watchlo[i],
 			   &addr->WATCH_STYLE.watchlo[i]);
-		__put_user(child->thread.watch.mips3264.watchhi[i] & 0xfff,
+		__put_user(child->thread.watch.mips3264.watchhi[i] &
+				(MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW),
 			   &addr->WATCH_STYLE.watchhi[i]);
 		__put_user(boot_cpu_data.watch_reg_masks[i],
 			   &addr->WATCH_STYLE.watch_masks[i]);
@@ -252,12 +253,12 @@ int ptrace_set_watch_regs(struct task_struct *child,
 		}
 #endif
 		__get_user(ht[i], &addr->WATCH_STYLE.watchhi[i]);
-		if (ht[i] & ~0xff8)
+		if (ht[i] & ~MIPS_WATCHHI_MASK)
 			return -EINVAL;
 	}
 	/* Install them. */
 	for (i = 0; i < boot_cpu_data.watch_reg_use_cnt; i++) {
-		if (lt[i] & 7)
+		if (lt[i] & MIPS_WATCHLO_IRW)
 			watch_active = 1;
 		child->thread.watch.mips3264.watchlo[i] = lt[i];
 		/* Set the G bit. */
diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
index 9b78e375118e..19fcab7348b1 100644
--- a/arch/mips/kernel/watch.c
+++ b/arch/mips/kernel/watch.c
@@ -25,16 +25,20 @@ void mips_install_watch_registers(struct task_struct *t)
 		write_c0_watchlo3(watches->watchlo[3]);
 		/* Write 1 to the I, R, and W bits to clear them, and
 		   1 to G so all ASIDs are trapped. */
-		write_c0_watchhi3(0x40000007 | watches->watchhi[3]);
+		write_c0_watchhi3(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
+				  watches->watchhi[3]);
 	case 3:
 		write_c0_watchlo2(watches->watchlo[2]);
-		write_c0_watchhi2(0x40000007 | watches->watchhi[2]);
+		write_c0_watchhi2(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
+				  watches->watchhi[2]);
 	case 2:
 		write_c0_watchlo1(watches->watchlo[1]);
-		write_c0_watchhi1(0x40000007 | watches->watchhi[1]);
+		write_c0_watchhi1(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
+				  watches->watchhi[1]);
 	case 1:
 		write_c0_watchlo0(watches->watchlo[0]);
-		write_c0_watchhi0(0x40000007 | watches->watchhi[0]);
+		write_c0_watchhi0(MIPS_WATCHHI_G | MIPS_WATCHHI_IRW |
+				  watches->watchhi[0]);
 	}
 }
 
@@ -51,22 +55,26 @@ void mips_read_watch_registers(void)
 	default:
 		BUG();
 	case 4:
-		watches->watchhi[3] = (read_c0_watchhi3() & 0x0fff);
+		watches->watchhi[3] = (read_c0_watchhi3() &
+				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
 	case 3:
-		watches->watchhi[2] = (read_c0_watchhi2() & 0x0fff);
+		watches->watchhi[2] = (read_c0_watchhi2() &
+				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
 	case 2:
-		watches->watchhi[1] = (read_c0_watchhi1() & 0x0fff);
+		watches->watchhi[1] = (read_c0_watchhi1() &
+				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
 	case 1:
-		watches->watchhi[0] = (read_c0_watchhi0() & 0x0fff);
+		watches->watchhi[0] = (read_c0_watchhi0() &
+				       (MIPS_WATCHHI_MASK | MIPS_WATCHHI_IRW));
 	}
 	if (current_cpu_data.watch_reg_use_cnt == 1 &&
-	    (watches->watchhi[0] & 7) == 0) {
+	    (watches->watchhi[0] & MIPS_WATCHHI_IRW) == 0) {
 		/* Pathological case of release 1 architecture that
 		 * doesn't set the condition bits.  We assume that
 		 * since we got here, the watch condition was met and
 		 * signal that the conditions requested in watchlo
 		 * were met.  */
-		watches->watchhi[0] |= (watches->watchlo[0] & 7);
+		watches->watchhi[0] |= (watches->watchlo[0] & MIPS_WATCHHI_IRW);
 	}
  }
 
@@ -109,86 +117,86 @@ void mips_probe_watch_registers(struct cpuinfo_mips *c)
 	 * Check which of the I,R and W bits are supported, then
 	 * disable the register.
 	 */
-	write_c0_watchlo0(7);
+	write_c0_watchlo0(MIPS_WATCHLO_IRW);
 	back_to_back_c0_hazard();
 	t = read_c0_watchlo0();
 	write_c0_watchlo0(0);
-	c->watch_reg_masks[0] = t & 7;
+	c->watch_reg_masks[0] = t & MIPS_WATCHLO_IRW;
 
 	/* Write the mask bits and read them back to determine which
 	 * can be used. */
 	c->watch_reg_count = 1;
 	c->watch_reg_use_cnt = 1;
 	t = read_c0_watchhi0();
-	write_c0_watchhi0(t | 0xff8);
+	write_c0_watchhi0(t | MIPS_WATCHHI_MASK);
 	back_to_back_c0_hazard();
 	t = read_c0_watchhi0();
-	c->watch_reg_masks[0] |= (t & 0xff8);
-	if ((t & 0x80000000) == 0)
+	c->watch_reg_masks[0] |= (t & MIPS_WATCHHI_MASK);
+	if ((t & MIPS_WATCHHI_M) == 0)
 		return;
 
-	write_c0_watchlo1(7);
+	write_c0_watchlo1(MIPS_WATCHLO_IRW);
 	back_to_back_c0_hazard();
 	t = read_c0_watchlo1();
 	write_c0_watchlo1(0);
-	c->watch_reg_masks[1] = t & 7;
+	c->watch_reg_masks[1] = t & MIPS_WATCHLO_IRW;
 
 	c->watch_reg_count = 2;
 	c->watch_reg_use_cnt = 2;
 	t = read_c0_watchhi1();
-	write_c0_watchhi1(t | 0xff8);
+	write_c0_watchhi1(t | MIPS_WATCHHI_MASK);
 	back_to_back_c0_hazard();
 	t = read_c0_watchhi1();
-	c->watch_reg_masks[1] |= (t & 0xff8);
-	if ((t & 0x80000000) == 0)
+	c->watch_reg_masks[1] |= (t & MIPS_WATCHHI_MASK);
+	if ((t & MIPS_WATCHHI_M) == 0)
 		return;
 
-	write_c0_watchlo2(7);
+	write_c0_watchlo2(MIPS_WATCHLO_IRW);
 	back_to_back_c0_hazard();
 	t = read_c0_watchlo2();
 	write_c0_watchlo2(0);
-	c->watch_reg_masks[2] = t & 7;
+	c->watch_reg_masks[2] = t & MIPS_WATCHLO_IRW;
 
 	c->watch_reg_count = 3;
 	c->watch_reg_use_cnt = 3;
 	t = read_c0_watchhi2();
-	write_c0_watchhi2(t | 0xff8);
+	write_c0_watchhi2(t | MIPS_WATCHHI_MASK);
 	back_to_back_c0_hazard();
 	t = read_c0_watchhi2();
-	c->watch_reg_masks[2] |= (t & 0xff8);
-	if ((t & 0x80000000) == 0)
+	c->watch_reg_masks[2] |= (t & MIPS_WATCHHI_MASK);
+	if ((t & MIPS_WATCHHI_M) == 0)
 		return;
 
-	write_c0_watchlo3(7);
+	write_c0_watchlo3(MIPS_WATCHLO_IRW);
 	back_to_back_c0_hazard();
 	t = read_c0_watchlo3();
 	write_c0_watchlo3(0);
-	c->watch_reg_masks[3] = t & 7;
+	c->watch_reg_masks[3] = t & MIPS_WATCHLO_IRW;
 
 	c->watch_reg_count = 4;
 	c->watch_reg_use_cnt = 4;
 	t = read_c0_watchhi3();
-	write_c0_watchhi3(t | 0xff8);
+	write_c0_watchhi3(t | MIPS_WATCHHI_MASK);
 	back_to_back_c0_hazard();
 	t = read_c0_watchhi3();
-	c->watch_reg_masks[3] |= (t & 0xff8);
-	if ((t & 0x80000000) == 0)
+	c->watch_reg_masks[3] |= (t & MIPS_WATCHHI_MASK);
+	if ((t & MIPS_WATCHHI_M) == 0)
 		return;
 
 	/* We use at most 4, but probe and report up to 8. */
 	c->watch_reg_count = 5;
 	t = read_c0_watchhi4();
-	if ((t & 0x80000000) == 0)
+	if ((t & MIPS_WATCHHI_M) == 0)
 		return;
 
 	c->watch_reg_count = 6;
 	t = read_c0_watchhi5();
-	if ((t & 0x80000000) == 0)
+	if ((t & MIPS_WATCHHI_M) == 0)
 		return;
 
 	c->watch_reg_count = 7;
 	t = read_c0_watchhi6();
-	if ((t & 0x80000000) == 0)
+	if ((t & MIPS_WATCHHI_M) == 0)
 		return;
 
 	c->watch_reg_count = 8;
-- 
2.4.10
