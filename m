Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 21:36:58 +0200 (CEST)
Received: from mail-lb0-f171.google.com ([209.85.217.171]:57567 "EHLO
        mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008902AbaINTcONmQwF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 21:32:14 +0200
Received: by mail-lb0-f171.google.com with SMTP id 10so3393370lbg.16
        for <multiple recipients>; Sun, 14 Sep 2014 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3Jez9tlntlwd1yKGVithilVkSNGjOIspUz1cuoawfY8=;
        b=XnFPvYm0pK4iiQ2yD+QEesQK4Kco3GHQ2teARtOp6yrIQXreZSUPfaiA2LQQbjXAmF
         Z/Pf/Ve/LDMJCVhhbbMmSTtmX8DzE8lzvAC4trmWK26/LrRKRVBE9+GXvaSQy9qZQayl
         jU2LJEN5hjQAhKhD+pTieaE+PZ5znOvrNh0bhuY/phhr6TYRCfZBMHQbHpen24ASDQ+F
         S+Yk9DxAmmEpSoSGrURlIchuvy9958ThgC7ekdGuzZkTmDOtPyObL8ZqjSahf5xMVzCK
         6ZssVtfJV6iw5PEOCVdo2lKub0c+e/8/Q2DU8XyWw0ByPW7HroPMd2ywH9JPxr7abEAw
         QwUw==
X-Received: by 10.112.150.106 with SMTP id uh10mr21866994lbb.11.1410723128868;
        Sun, 14 Sep 2014 12:32:08 -0700 (PDT)
Received: from rsa-laptop.internal.lan ([217.25.229.52])
        by mx.google.com with ESMTPSA id y5sm3339621laa.20.2014.09.14.12.32.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 12:32:08 -0700 (PDT)
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        linux-wireless@vger.kernel.org, ath5k-devel@lists.ath5k.org
Subject: [RFC 18/18] ath5k: correct dependency
Date:   Sun, 14 Sep 2014 23:33:33 +0400
Message-Id: <1410723213-22440-19-git-send-email-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 1.8.1.5
In-Reply-To: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com>
Return-Path: <ryazanov.s.a@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ryazanov.s.a@gmail.com
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

Some of AR231x SoCs (e.g. AR2315) have PCI bus support, so remove !PCI
dependency, which block AHB support build.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>
Cc: Nick Kossifidis <mickflemm@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: linux-wireless@vger.kernel.org
Cc: ath5k-devel@lists.ath5k.org
---
 drivers/net/wireless/ath/ath5k/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath5k/Kconfig b/drivers/net/wireless/ath/ath5k/Kconfig
index 027c11c..2b2a399 100644
--- a/drivers/net/wireless/ath/ath5k/Kconfig
+++ b/drivers/net/wireless/ath/ath5k/Kconfig
@@ -6,8 +6,8 @@ config ATH5K
 	select LEDS_CLASS
 	select NEW_LEDS
 	select AVERAGE
-	select ATH5K_AHB if (AR231X && !PCI)
-	select ATH5K_PCI if (!AR231X && PCI)
+	select ATH5K_AHB if AR231X
+	select ATH5K_PCI if !AR231X
 	---help---
 	  This module adds support for wireless adapters based on
 	  Atheros 5xxx chipset.
@@ -54,7 +54,7 @@ config ATH5K_TRACER
 
 config ATH5K_AHB
 	bool "Atheros 5xxx AHB bus support"
-	depends on (AR231X && !PCI)
+	depends on AR231X
 	---help---
 	  This adds support for WiSoC type chipsets of the 5xxx Atheros
 	  family.
-- 
1.8.1.5
