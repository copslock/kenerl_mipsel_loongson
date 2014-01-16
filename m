Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jan 2014 22:37:17 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44987 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827341AbaAPVhO6xSZU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Jan 2014 22:37:14 +0100
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     <Steven.Hill@imgtec.com>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH upstream-sfr] MIPS: APRP: Use the new __wait_event*() interface in RTLX
Date:   Thu, 16 Jan 2014 13:36:52 -0800
Message-ID: <1389908212-19898-1-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.136.61]
X-SEF-Processed: 7_3_0_01192__2014_01_16_21_37_09
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

The commit 35a2af94c7 (sched/wait: Make the __wait_event*() interface more
friendly) changed __wait_event_interruptible() to use 2 parameters instead
of 3. It also made corresponding changes to rtlx.c. However, these changes
were partially reverted by 9d4147a783 (MIPS: APRP: Code formatting
clean-ups.). This patch fixes it.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
Ralf, this needs to go upstream-sfr/mips-for-linux-next to fix the APRP
build error: macro "__wait_event_interruptible" passed 3 arguments, but
takes just 2

 arch/mips/kernel/rtlx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index 4658350..31b1b76 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -108,10 +108,9 @@ int rtlx_open(int index, int can_sleep)
 		p = vpe_get_shared(aprp_cpu_index());
 		if (p == NULL) {
 			if (can_sleep) {
-				__wait_event_interruptible(
+				ret = __wait_event_interruptible(
 					channel_wqs[index].lx_queue,
-					(p = vpe_get_shared(aprp_cpu_index())),
-					ret);
+					(p = vpe_get_shared(aprp_cpu_index())));
 				if (ret)
 					goto out_fail;
 			} else {
-- 
1.8.5.3
