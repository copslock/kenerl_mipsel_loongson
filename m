Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2013 02:36:21 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:51195 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831312Ab3IKAgSnHpn4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Sep 2013 02:36:18 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1VJYPi-00006i-Am; Tue, 10 Sep 2013 19:36:10 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, ralf@linux-mips.org,
        "Steven J. Hill" <Steven.Hill@imgtec.com>
Subject: [PATCH] MIPS: Fix VGA_MAP_MEM macro.
Date:   Tue, 10 Sep 2013 19:36:04 -0500
Message-Id: <1378859764-17544-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37779
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Use the CKSEG1ADDR macro when calculating VGA_MAP_MEM.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/vga.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/vga.h b/arch/mips/include/asm/vga.h
index f4cff7e..4795206 100644
--- a/arch/mips/include/asm/vga.h
+++ b/arch/mips/include/asm/vga.h
@@ -13,7 +13,7 @@
  *	access the videoram directly without any black magic.
  */
 
-#define VGA_MAP_MEM(x, s)	(0xb0000000L + (unsigned long)(x))
+#define VGA_MAP_MEM(x, s)	CKSEG1ADDR(0x10000000L + (unsigned long)(x))
 
 #define vga_readb(x)	(*(x))
 #define vga_writeb(x, y)	(*(y) = (x))
-- 
1.7.9.5
