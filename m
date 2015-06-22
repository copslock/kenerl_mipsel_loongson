Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jun 2015 06:14:29 +0200 (CEST)
Received: from userp1040.oracle.com ([156.151.31.81]:49737 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006533AbbFVEO13v0Uy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jun 2015 06:14:27 +0200
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t5M4EFU2008103
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Mon, 22 Jun 2015 04:14:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t5M4EDhc003164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 22 Jun 2015 04:14:13 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.13.8/8.13.8) with ESMTP id t5M4EDB4029882;
        Mon, 22 Jun 2015 04:14:13 GMT
Received: from lappy.hsd1.nh.comcast.net (/10.154.108.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 21 Jun 2015 21:14:13 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: unaligned: Fix regular load/store instruction emulation for EVA
Date:   Mon, 22 Jun 2015 00:13:17 -0400
Message-Id: <1434946411-9021-51-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1434946411-9021-1-git-send-email-sasha.levin@oracle.com>
References: <1434946411-9021-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: aserv0021.oracle.com [141.146.126.233]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: Markos Chandras <markos.chandras@imgtec.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 6eae35485b26f9e51ab896eb8a936bed9908fdf6 ]

When emulating a regular lh/lw/lhu/sh/sw we need to use the appropriate
instruction if we are in EVA mode. This is necessary for userspace
applications which trigger alignment exceptions. In such case, the
userspace load/store instruction needs to be emulated with the correct
eva/non-eva instruction by the kernel emulator.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: c1771216ab48 ("MIPS: kernel: unaligned: Handle unaligned accesses for EVA")
Cc: <stable@vger.kernel.org> # v3.15+
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9503/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/kernel/unaligned.c | 52 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index e11906d..91d5006 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -564,7 +564,15 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (!access_ok(VERIFY_READ, addr, 2))
 			goto sigbus;
 
-		LoadHW(addr, value, res);
+		if (config_enabled(CONFIG_EVA)) {
+			if (segment_eq(get_fs(), get_ds()))
+				LoadHW(addr, value, res);
+			else
+				LoadHWE(addr, value, res);
+		} else {
+			LoadHW(addr, value, res);
+		}
+
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -575,7 +583,15 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (!access_ok(VERIFY_READ, addr, 4))
 			goto sigbus;
 
-		LoadW(addr, value, res);
+		if (config_enabled(CONFIG_EVA)) {
+			if (segment_eq(get_fs(), get_ds()))
+				LoadW(addr, value, res);
+			else
+				LoadWE(addr, value, res);
+		} else {
+			LoadW(addr, value, res);
+		}
+
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -586,7 +602,15 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (!access_ok(VERIFY_READ, addr, 2))
 			goto sigbus;
 
-		LoadHWU(addr, value, res);
+		if (config_enabled(CONFIG_EVA)) {
+			if (segment_eq(get_fs(), get_ds()))
+				LoadHWU(addr, value, res);
+			else
+				LoadHWUE(addr, value, res);
+		} else {
+			LoadHWU(addr, value, res);
+		}
+
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -645,7 +669,16 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 
 		compute_return_epc(regs);
 		value = regs->regs[insn.i_format.rt];
-		StoreHW(addr, value, res);
+
+		if (config_enabled(CONFIG_EVA)) {
+			if (segment_eq(get_fs(), get_ds()))
+				StoreHW(addr, value, res);
+			else
+				StoreHWE(addr, value, res);
+		} else {
+			StoreHW(addr, value, res);
+		}
+
 		if (res)
 			goto fault;
 		break;
@@ -656,7 +689,16 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 
 		compute_return_epc(regs);
 		value = regs->regs[insn.i_format.rt];
-		StoreW(addr, value, res);
+
+		if (config_enabled(CONFIG_EVA)) {
+			if (segment_eq(get_fs(), get_ds()))
+				StoreW(addr, value, res);
+			else
+				StoreWE(addr, value, res);
+		} else {
+			StoreW(addr, value, res);
+		}
+
 		if (res)
 			goto fault;
 		break;
-- 
2.1.0
