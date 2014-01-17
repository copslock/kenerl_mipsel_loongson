Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2014 17:47:21 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:54865 "EHLO localhost"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817237AbaAQQrTQkuuk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jan 2014 17:47:19 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1W4CZc-0005BP-Dw; Fri, 17 Jan 2014 10:47:12 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     blogic@openwrt.org
Subject: [PATCH] MIPS: APRP: Fix breakage due to new wait_event interface.
Date:   Fri, 17 Jan 2014 10:47:07 -0600
Message-Id: <1389977227-16694-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

Commit 35a2af94c7ce7130ca292c68b1d27fcfdb648f6b changed the
__wait_event*() interfaces. Fix the RTLX open() function to
use the new interface.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/kernel/rtlx.c |    5 ++---
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
1.7.10.4
