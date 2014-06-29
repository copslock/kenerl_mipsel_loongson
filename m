Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 09:25:51 +0200 (CEST)
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:25837 "EHLO
        mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856088AbaF2HZsN82gt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 09:25:48 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApcIACq+r1NbsmJR/2dsb2JhbABZgw2sLwsFAW4BmUaBBxd1hDEvI4EaN4hGAcYAF4VkiSMdhC0Fml6LP4g+g0Q7
Received: from 81.98-178-91.adsl-dyn.isp.belgacom.be (HELO linux-zvq9.site) ([91.178.98.81])
  by relay.skynet.be with ESMTP; 29 Jun 2014 09:25:42 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     linux-kernel@vger.kernel.org
Cc:     Fabian Frederick <fabf@skynet.be>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/1] MIPS: jz4740: remove unnecessary null test before debugfs_remove
Date:   Sun, 29 Jun 2014 09:24:23 +0200
Message-Id: <1404026663-3510-1-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 1.8.4.5
Return-Path: <fabf@skynet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fabf@skynet.be
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

Fix checkpatch warning:
WARNING: debugfs_remove(NULL) is safe this check is probably not required

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/mips/jz4740/clock-debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/jz4740/clock-debugfs.c b/arch/mips/jz4740/clock-debugfs.c
index a8acdef..325422d0 100644
--- a/arch/mips/jz4740/clock-debugfs.c
+++ b/arch/mips/jz4740/clock-debugfs.c
@@ -87,8 +87,7 @@ void jz4740_clock_debugfs_add_clk(struct clk *clk)
 /* TODO: Locking */
 void jz4740_clock_debugfs_update_parent(struct clk *clk)
 {
-	if (clk->debugfs_parent_entry)
-		debugfs_remove(clk->debugfs_parent_entry);
+	debugfs_remove(clk->debugfs_parent_entry);
 
 	if (clk->parent) {
 		char parent_path[100];
-- 
1.8.4.5
