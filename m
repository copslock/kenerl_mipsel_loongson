Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jun 2013 18:36:26 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:17172 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827479Ab3FOQgYbAwJv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 15 Jun 2013 18:36:24 +0200
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] mips: fix execution hazard during watchpoint register probe
Date:   Sat, 15 Jun 2013 17:34:40 +0100
Message-ID: <1371314080-48198-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-SEF-Processed: 7_3_0_01192__2013_06_15_17_36_18
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Writing a value to a WatchLo* register creates an execution hazard, so
if its value is then read before that hazard is cleared then said value
may be invalid. The mips_probe_watch_registers function must therefore
clear the execution hazard between setting the match bits in a WatchLo*
register & reading the register back in order to check which are set.

This fixes intermittent incorrect watchpoint register probing on some
MIPS cores such as interAptiv & proAptiv.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/kernel/watch.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/watch.c b/arch/mips/kernel/watch.c
index 7726f61..cbdc4de 100644
--- a/arch/mips/kernel/watch.c
+++ b/arch/mips/kernel/watch.c
@@ -111,6 +111,7 @@ __cpuinit void mips_probe_watch_registers(struct cpuinfo_mips *c)
 	 * disable the register.
 	 */
 	write_c0_watchlo0(7);
+	back_to_back_c0_hazard();
 	t = read_c0_watchlo0();
 	write_c0_watchlo0(0);
 	c->watch_reg_masks[0] = t & 7;
@@ -121,12 +122,14 @@ __cpuinit void mips_probe_watch_registers(struct cpuinfo_mips *c)
 	c->watch_reg_use_cnt = 1;
 	t = read_c0_watchhi0();
 	write_c0_watchhi0(t | 0xff8);
+	back_to_back_c0_hazard();
 	t = read_c0_watchhi0();
 	c->watch_reg_masks[0] |= (t & 0xff8);
 	if ((t & 0x80000000) == 0)
 		return;
 
 	write_c0_watchlo1(7);
+	back_to_back_c0_hazard();
 	t = read_c0_watchlo1();
 	write_c0_watchlo1(0);
 	c->watch_reg_masks[1] = t & 7;
@@ -135,12 +138,14 @@ __cpuinit void mips_probe_watch_registers(struct cpuinfo_mips *c)
 	c->watch_reg_use_cnt = 2;
 	t = read_c0_watchhi1();
 	write_c0_watchhi1(t | 0xff8);
+	back_to_back_c0_hazard();
 	t = read_c0_watchhi1();
 	c->watch_reg_masks[1] |= (t & 0xff8);
 	if ((t & 0x80000000) == 0)
 		return;
 
 	write_c0_watchlo2(7);
+	back_to_back_c0_hazard();
 	t = read_c0_watchlo2();
 	write_c0_watchlo2(0);
 	c->watch_reg_masks[2] = t & 7;
@@ -149,12 +154,14 @@ __cpuinit void mips_probe_watch_registers(struct cpuinfo_mips *c)
 	c->watch_reg_use_cnt = 3;
 	t = read_c0_watchhi2();
 	write_c0_watchhi2(t | 0xff8);
+	back_to_back_c0_hazard();
 	t = read_c0_watchhi2();
 	c->watch_reg_masks[2] |= (t & 0xff8);
 	if ((t & 0x80000000) == 0)
 		return;
 
 	write_c0_watchlo3(7);
+	back_to_back_c0_hazard();
 	t = read_c0_watchlo3();
 	write_c0_watchlo3(0);
 	c->watch_reg_masks[3] = t & 7;
@@ -163,6 +170,7 @@ __cpuinit void mips_probe_watch_registers(struct cpuinfo_mips *c)
 	c->watch_reg_use_cnt = 4;
 	t = read_c0_watchhi3();
 	write_c0_watchhi3(t | 0xff8);
+	back_to_back_c0_hazard();
 	t = read_c0_watchhi3();
 	c->watch_reg_masks[3] |= (t & 0xff8);
 	if ((t & 0x80000000) == 0)
-- 
1.8.3.1
