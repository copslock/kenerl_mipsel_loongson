Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2014 04:50:35 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38603 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816417AbaGECubTtaB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jul 2014 04:50:31 +0200
Received: by mail-ig0-f170.google.com with SMTP id h15so8880428igd.3
        for <multiple recipients>; Fri, 04 Jul 2014 19:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Gq3SIY+5nmvP/i6qeKO4EHhetVT5ygPtpI1ot1ffU1k=;
        b=Rmyl1NZBjtSjBew7Sq9KjNNgAwedV322WhD8HczzIyiByvEeaMWG3NIrZ8JPEC7EBH
         GqwGx5Gn6mpCxOdpOAtiuxk4kZCXW9UNtQTfE05NgSQLTP1ciA52WeqD/41Xx5/dMGIv
         4JdZku+jxZ3zLf6mu4jL7HfGOEkdFrrc2zHRRHU+Dar50xIRABrTDwPb5Mcg2KVjc9Gx
         tuXwn/DJDzsVtwlwpjS0Y8+7GqhaOB5xhYCN27L5sZ3a/+owjsQ4y5VgjOwiK/2eVBi7
         ksamy6bKorxd3eaMRibtF7kAnWIrhNGzkdlEIjnFSSOIYuq/Z3+0Ej6T0tqLBWEKHDKn
         7cUg==
X-Received: by 10.50.120.65 with SMTP id la1mr23014012igb.23.1404528624944;
        Fri, 04 Jul 2014 19:50:24 -0700 (PDT)
Received: from nick-System-Product-Name.phub.net.cable.rogers.com (CPE0026f3330aca-CM0026f3330ac6.cpe.net.cable.rogers.com. [99.232.64.167])
        by mx.google.com with ESMTPSA id qa4sm67652483igb.10.2014.07.04.19.50.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jul 2014 19:50:24 -0700 (PDT)
From:   Nicholas Krause <xerofoify@gmail.com>
To:     ralf@linux-mips.org
Cc:     jchandra@broadcom.com, blogic@openwrt.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mips: Add #ifdef in file bridge.h
Date:   Fri,  4 Jul 2014 22:50:19 -0400
Message-Id: <1404528619-3715-1-git-send-email-xerofoify@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <xerofoify@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xerofoify@gmail.com
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

This patch addes a #ifdef __ASSEMBLY__ in order to check if this part
of the file is configured to fix this #ifdef block in bridge.h for mips.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
index 3067f98..4f315c3 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/bridge.h
@@ -143,7 +143,7 @@
 #define BRIDGE_GIO_WEIGHT		0x2cb
 #define BRIDGE_FLASH_WEIGHT		0x2cc
 
-/* FIXME verify */
+#ifdef __ASSEMBLY__
 #define BRIDGE_9XX_FLASH_BAR(i)		(0x11 + (i))
 #define BRIDGE_9XX_FLASH_BAR_LIMIT(i)	(0x15 + (i))
 
-- 
1.9.1
