Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2018 11:18:21 +0200 (CEST)
Received: from newton.telenet-ops.be ([IPv6:2a02:1800:120:4::f00:d]:39632 "EHLO
        newton.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992864AbeEPJSKFl07p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 May 2018 11:18:10 +0200
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by newton.telenet-ops.be (Postfix) with ESMTPS id 40m83w4LjxzMsJng
        for <linux-mips@linux-mips.org>; Wed, 16 May 2018 11:18:04 +0200 (CEST)
Received: from ayla.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id mxJ31x0023XaVaC06xJ3BU; Wed, 16 May 2018 11:18:04 +0200
Received: from ramsan.of.borg ([192.168.97.29] helo=ramsan)
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fIsZO-0003HZ-UQ; Wed, 16 May 2018 11:18:02 +0200
Received: from geert by ramsan with local (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fIsZO-0005Q8-SG; Wed, 16 May 2018 11:18:02 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>, netdev@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] net: 8390: ne: Fix accidentally removed RBTX4927 support
Date:   Wed, 16 May 2018 11:18:01 +0200
Message-Id: <1526462281-20772-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

The configuration settings for RBTX4927 were accidentally removed,
leading to a silently broken network interface.

Re-add the missing settings to fix this.

Fixes: 8eb97ff5a4ec941d ("net: 8390: remove m32r specific bits")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Bisected between v4.9-rc2 (doh) and v4.17-rc5.

Note to myself: I should do more boot testing on RBTX4927.
Fortunately I caught it before it ends up in a point release ;-)
---
 drivers/net/ethernet/8390/ne.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/8390/ne.c b/drivers/net/ethernet/8390/ne.c
index ac99d089ac7266c3..1c97e39b478e9f89 100644
--- a/drivers/net/ethernet/8390/ne.c
+++ b/drivers/net/ethernet/8390/ne.c
@@ -164,7 +164,9 @@ bad_clone_list[] __initdata = {
 #define NESM_START_PG	0x40	/* First page of TX buffer */
 #define NESM_STOP_PG	0x80	/* Last page +1 of RX ring */
 
-#if defined(CONFIG_ATARI)	/* 8-bit mode on Atari, normal on Q40 */
+#if defined(CONFIG_MACH_TX49XX)
+#  define DCR_VAL 0x48		/* 8-bit mode */
+#elif defined(CONFIG_ATARI)	/* 8-bit mode on Atari, normal on Q40 */
 #  define DCR_VAL (MACH_IS_ATARI ? 0x48 : 0x49)
 #else
 #  define DCR_VAL 0x49
-- 
2.7.4
