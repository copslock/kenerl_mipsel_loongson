Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 10:50:24 +0200 (CEST)
Received: from xavier.telenet-ops.be ([195.130.132.52]:60470 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006682AbaHYIuXXtzhC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Aug 2014 10:50:23 +0200
Received: from ayla.of.borg ([84.193.84.167])
        by xavier.telenet-ops.be with bizsmtp
        id iwqM1o00A3cczKo01wqMv3; Mon, 25 Aug 2014 10:50:23 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.76)
        (envelope-from <geert@linux-m68k.org>)
        id 1XLpyk-0005QC-DI; Mon, 25 Aug 2014 10:50:18 +0200
Received: from geert by ramsan with local (Exim 4.82)
        (envelope-from <geert@linux-m68k.org>)
        id 1XLpyk-0004LO-UI; Mon, 25 Aug 2014 10:50:18 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-mips@linux-mips.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] MIPS: Spelling s/confugrations/configurations/
Date:   Mon, 25 Aug 2014 10:50:12 +0200
Message-Id: <1408956612-16665-1-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 1.9.1
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert+renesas@glider.be
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

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/mips/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 5699ec3a71af..e4ef8343ad51 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -37,7 +37,7 @@
 
 /*
  * This is used for calculating the real page sizes
- * for FTLB or VTLB + FTLB confugrations.
+ * for FTLB or VTLB + FTLB configurations.
  */
 static inline unsigned int page_size_ftlb(unsigned int mmuextdef)
 {
-- 
1.9.1
