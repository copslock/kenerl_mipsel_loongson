Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 09:17:49 +0200 (CEST)
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:1533 "EHLO
        mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6856088AbaF2HRpEW0pv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 09:17:45 +0200
X-Belgacom-Dynamic: yes
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApcIAMe8r1NbsmJR/2dsb2JhbABagw2sLwsFAW4BmUaBBxd1hGAjgRo3iEYBxX8XhWSJIx2ELQWaXos/iD6CAIFEOw
Received: from 81.98-178-91.adsl-dyn.isp.belgacom.be (HELO linux-zvq9.site) ([91.178.98.81])
  by relay.skynet.be with ESMTP; 29 Jun 2014 09:17:39 +0200
From:   Fabian Frederick <fabf@skynet.be>
To:     linux-kernel@vger.kernel.org
Cc:     Fabian Frederick <fabf@skynet.be>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 1/1] MIPS: Octeon: remove unnecessary null test before debugfs_remove_recursive
Date:   Sun, 29 Jun 2014 09:16:19 +0200
Message-Id: <1404026179-2910-1-git-send-email-fabf@skynet.be>
X-Mailer: git-send-email 1.8.4.5
Return-Path: <fabf@skynet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40914
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
WARNING: debugfs_remove_recursive(NULL) is safe this check is probably not required

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/mips/cavium-octeon/oct_ilm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/oct_ilm.c b/arch/mips/cavium-octeon/oct_ilm.c
index 71b213d..2d68a39 100644
--- a/arch/mips/cavium-octeon/oct_ilm.c
+++ b/arch/mips/cavium-octeon/oct_ilm.c
@@ -194,8 +194,7 @@ err_irq:
 static __exit void oct_ilm_module_exit(void)
 {
 	disable_timer(TIMER_NUM);
-	if (dir)
-		debugfs_remove_recursive(dir);
+	debugfs_remove_recursive(dir);
 	free_irq(OCTEON_IRQ_TIMER0 + TIMER_NUM, 0);
 }
 
-- 
1.8.4.5
