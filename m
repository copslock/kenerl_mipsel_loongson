Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 00:37:59 +0200 (CEST)
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34662 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026974AbcDSWh43YWHB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 00:37:56 +0200
Received: by mail-pf0-f181.google.com with SMTP id c20so11038266pfc.1;
        Tue, 19 Apr 2016 15:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=orcEiIaraxrMlqidPDyxEr31ubqDP2aCUXLIz6U88Z8=;
        b=GMO3DbJpbN/rI2C1p6Q19vB0+wRdGiNttu/nFn2bL8Fzc4WLmp+bka+wa2b5qjl+Pw
         +5+45AtgsNgyhD5BNKhtxpwSrkKmVQwMRbWpwYXBx96XoBOYj54mI3S/X5nIZwLHgiTy
         jpdPjjfVnXAuKRDivNnT3wgu0TuhVNPfH5I4f2bbdXLQA/aEFtUu6DL9dx0/Jj8HgYcQ
         eKVaW7Cd8VFieSquqeafNmRyGAUyvA6Qqd/YShW2XFv0ZwdXp9hUUqQRbx3N6flPxZRy
         7JDlJBUFelQJt4yOt3sE2VsFfuryumA/Dp5ZWw2b60KvWIiCbwPSuiCloq4Aff7jTpeL
         m/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=orcEiIaraxrMlqidPDyxEr31ubqDP2aCUXLIz6U88Z8=;
        b=Nrt7ZpZxP94fe8IUfGACfEmikgkjWynjKVSwT7kYvgwUjftzap6NHdz9JtdLu7kwJw
         rzJR+r4eYgNRkXsyixqMHIlGTusZC0AkwCPybGSSK4ye/WU6TBF0VVn6RTvumW6ZAmTo
         XxBFzQZb/XFDuO2dgs48hPAE7FVB5W9y8T5FL1DlFIE2SJ3j1CRkkQrIF9p6RtqKmJGO
         mDAtFTxtzZFB8YJfv12wb9FSB9iNhWtWUX59Ijg99xlSYoMwMr0sVec1jyF/jkFU1PhF
         bTax+n6UfhoTLx6Xp1SasYtVczVMYFhAdSspcTgPNoxv5Fu7/LLs/keo+OgNE9b96xFM
         ax/g==
X-Gm-Message-State: AOPr4FXspXLZ6pP4xZsqf1tcvQCepkga6d9S5Lwsjx3TSmICkarWFTrwVBmEMMZCvyorqw==
X-Received: by 10.98.15.145 with SMTP id 17mr7506129pfp.19.1461105470447;
        Tue, 19 Apr 2016 15:37:50 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.gmail.com with ESMTPSA id a5sm33109216pat.19.2016.04.19.15.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 15:37:49 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jaedon.shin@gmail.com, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2] MIPS: BMIPS: Adjust mips-hpt-frequency for BCM7435
Date:   Tue, 19 Apr 2016 15:35:39 -0700
Message-Id: <1461105339-27679-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

The CPU actually runs at 1405Mhz which gives us a 175625000 Hz MIPS timer
frequency (CPU frequency / 8).

Fixes: 8394968be4c7 ("MIPS: BMIPS: Add BCM7435 dtsi")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- fixed Signed-off-by tag

 arch/mips/boot/dts/brcm/bcm7435.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
index cce752b27055..a874d3a0e2ee 100644
--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -7,7 +7,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		mips-hpt-frequency = <163125000>;
+		mips-hpt-frequency = <175625000>;
 
 		cpu@0 {
 			compatible = "brcm,bmips5200";
-- 
2.1.0
