Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2015 17:41:06 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:20589 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013069AbbH0PjlQohex (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Aug 2015 17:39:41 +0200
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t7RFdTgo019200
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2015 15:39:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t7RFdSt3032316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 27 Aug 2015 15:39:28 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.13.8/8.13.8) with ESMTP id t7RFdRmk001864;
        Thu, 27 Aug 2015 15:39:28 GMT
Received: from lappy.us.oracle.com (/10.154.183.228)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2015 08:39:26 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 3.18 stable tree] MIPS: Flush RPS on kernel entry with EVA
Date:   Thu, 27 Aug 2015 11:37:23 -0400
Message-Id: <1440689954-10813-5-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1440689954-10813-1-git-send-email-sasha.levin@oracle.com>
References: <1440689954-10813-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49056
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

From: James Hogan <james.hogan@imgtec.com>

This patch has been added to the 3.18 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit 3aff47c062b944a5e1f9af56a37a23f5295628fc ]

When EVA is enabled, flush the Return Prediction Stack (RPS) present on
some MIPS cores on entry to the kernel from user mode.

This is important specifically for interAptiv with EVA enabled,
otherwise kernel mode RPS mispredicts may trigger speculative fetches of
user return addresses, which may be sensitive in the kernel address
space due to EVA's overlapping user/kernel address spaces.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.15.x-
Patchwork: https://patchwork.linux-mips.org/patch/10812/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 arch/mips/include/asm/stackframe.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index b188c79..0562a24 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -152,6 +152,31 @@
 		.set	noreorder
 		bltz	k0, 8f
 		 move	k1, sp
+#ifdef CONFIG_EVA
+		/*
+		 * Flush interAptiv's Return Prediction Stack (RPS) by writing
+		 * EntryHi. Toggling Config7.RPS is slower and less portable.
+		 *
+		 * The RPS isn't automatically flushed when exceptions are
+		 * taken, which can result in kernel mode speculative accesses
+		 * to user addresses if the RPS mispredicts. That's harmless
+		 * when user and kernel share the same address space, but with
+		 * EVA the same user segments may be unmapped to kernel mode,
+		 * even containing sensitive MMIO regions or invalid memory.
+		 *
+		 * This can happen when the kernel sets the return address to
+		 * ret_from_* and jr's to the exception handler, which looks
+		 * more like a tail call than a function call. If nested calls
+		 * don't evict the last user address in the RPS, it will
+		 * mispredict the return and fetch from a user controlled
+		 * address into the icache.
+		 *
+		 * More recent EVA-capable cores with MAAR to restrict
+		 * speculative accesses aren't affected.
+		 */
+		MFC0	k0, CP0_ENTRYHI
+		MTC0	k0, CP0_ENTRYHI
+#endif
 		.set	reorder
 		/* Called from user mode, new stack. */
 		get_saved_sp
-- 
2.1.4
