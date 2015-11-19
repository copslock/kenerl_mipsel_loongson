Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2015 03:36:34 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32991 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012444AbbKSCfd6s0yC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2015 03:35:33 +0100
Received: by pabfh17 with SMTP id fh17so66573158pab.0;
        Wed, 18 Nov 2015 18:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bd4MO+oN36WvM0AXYV2QNCWWCZCbPqu2iMFOZ1BafQQ=;
        b=uDFkYgx7VdoW7iaCfXaWR9x+Jq85tmLrnRX3WigK+s7bk6d4AbREFpdqpOY4csGpW9
         l0GfzjoQdiTc6/pVsgKIhB0cjHUKPDBAKla6vBaumHTMBURXOpLv/3G/YsXa56Wxf5oE
         H5Hp/gA0GlAacC7P7a/VymrM67S/cd3d7SqjLbzRmBgzzEFjjQDGpPP1+O1Az+Kk+59D
         5W4pOOZE2BvkRoyzlFn1BDGMV2u+LFBkuMB4bLkbzXtCxW0GIJmMKHYheEjo3c3fMP+H
         Kt6N5wzT2JvcMmr2pNG27t0VqsvmH/ou3lPYWAnT5LSXj+RV1xzJWA3yXP0rF5sTrxK4
         amgg==
X-Received: by 10.66.150.165 with SMTP id uj5mr6991605pab.23.1447900527262;
        Wed, 18 Nov 2015 18:35:27 -0800 (PST)
Received: from praha.local.private ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id ns1sm6719515pbc.67.2015.11.18.18.35.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Nov 2015 18:35:26 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 4/7] MIPS: BMIPS: fix interrupt number in bcm7425.dtsi
Date:   Thu, 19 Nov 2015 11:34:50 +0900
Message-Id: <1447900493-1167-5-git-send-email-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
References: <1447900493-1167-1-git-send-email-jaedon.shin@gmail.com>
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Fixes interrupt number property in bcm7425.dtsi. The SATA AHCI hardware
interrupt number with periph_intc is 41.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 arch/mips/boot/dts/brcm/bcm7425.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
index dfeb112da954..dfadd04d56d1 100644
--- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
@@ -227,7 +227,7 @@
 			reg-names = "ahci", "top-ctrl";
 			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
 			interrupt-parent = <&periph_intc>;
-			interrupts = <40>;
+			interrupts = <41>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.6.3
