Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2017 08:18:44 +0200 (CEST)
Received: from mail-wm0-x244.google.com ([IPv6:2a00:1450:400c:c09::244]:32804
        "EHLO mail-wm0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbdEKGShAqN7K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 May 2017 08:18:37 +0200
Received: by mail-wm0-x244.google.com with SMTP id y10so4473129wmh.0
        for <linux-mips@linux-mips.org>; Wed, 10 May 2017 23:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2kM6X3OfxcmZgvsWqNAv2lccQIRmIzMiS3/kFI2SsYw=;
        b=hwamMOOT2MDVcdNymh3sXYFhLi1fPgZGeF2+6uq4VC6QQK4rLQ5zGzemZnxDX8tbtJ
         WnLhnWEoxniATaTKXjnfJKlJuGc87wr8KUYY96zEQMOyGexdB5ZN0jAPMiGa6u//80xc
         O3XB5De/PDXLmDmdkN1ByE/8SC3O2eUrntgcuMfxDTHQiA0dcpiSk7gP4k9vMd7/93Yv
         jBNoiAM4swilDtGExxhf1dgWr+lPYoXjPpjjkFUtP+AcYFxhNSvrSvgvLietwt/FwcJ8
         cq7FVy5HGSSZiLnXgD3yVCXHy5R6I737ddDFdlTWA+OfOtPmLz6XTVapdtSTI/ayfTvL
         JJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2kM6X3OfxcmZgvsWqNAv2lccQIRmIzMiS3/kFI2SsYw=;
        b=W4eAWKulqet+/WjPzXPAKMwPHSVJaLCfa106Ay2uDiaERCt2V6JWbAfI0kjmIrU6w6
         qPy7VhOtUTcS/QNu6F48IYoSqVSzu50R0aq8Fm9m2+xXMXZJ5VGnhlqGOLDyoT5zVjMF
         LTL02+lEWP6Eh0aRHcbdh5yXAezFocqoaXUlazvFCURRWpMq5mL1Fo07JBQFgjAYBGOy
         nwf5xiHuyVQslcnTuzQGIgTTW8KVv7adbCeI5SzQMMn1wV12C6UTL/0BY2oj3/Y+iDVf
         w4EKRCljgzdZcyf8ghnNAM8RAC3pwtf8/hQp1lGYSk9ypcmv5Kf/D3YNaDUKZrjeItNV
         Odtg==
X-Gm-Message-State: AODbwcDDuGHX5HxsdjC3vmjpaYXv8RFEfRZyvwFGu0tIYck3d0gKokoZ
        GGjNy/Oxy/LTayYc
X-Received: by 10.28.208.130 with SMTP id h124mr5955688wmg.21.1494483511691;
        Wed, 10 May 2017 23:18:31 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p4FC0AE18.dip0.t-ipconnect.de. [79.192.174.24])
        by smtp.gmail.com with ESMTPSA id w68sm432052wrb.49.2017.05.10.23.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 May 2017 23:18:31 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/2] MIPS: ath79: fix AR724X_PLL_REG_PCIE_CONFIG offset
Date:   Thu, 11 May 2017 08:18:24 +0200
Message-Id: <1494483505-18609-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Return-Path: <dev@kresin.me>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57866
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev@kresin.me
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

According to the QCA u-boot source the "PCIE Phase Lock Loop
Configuration (PCIE_PLL_CONFIG)" register is for all SoCs except the
QCA955X and QCA956X at offset 0x10.

Since the PCIE PLL config register is only defined for the AR724x fix
only this value. The value is wrong since the day it was added and isn't
used by any driver yet.

Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index aa3800c..d99ca86 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -167,7 +167,7 @@
 #define AR71XX_AHB_DIV_MASK		0x7
 
 #define AR724X_PLL_REG_CPU_CONFIG	0x00
-#define AR724X_PLL_REG_PCIE_CONFIG	0x18
+#define AR724X_PLL_REG_PCIE_CONFIG	0x10
 
 #define AR724X_PLL_FB_SHIFT		0
 #define AR724X_PLL_FB_MASK		0x3ff
-- 
2.7.4
