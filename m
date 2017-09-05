Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Sep 2017 18:39:23 +0200 (CEST)
Received: from smtp3-g21.free.fr ([IPv6:2a01:e0c:1:1599::12]:25286 "EHLO
        smtp3-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994920AbdIEQjMLbGG2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Sep 2017 18:39:12 +0200
Received: from macbookpro.malat.net (unknown [78.225.226.121])
        by smtp3-g21.free.fr (Postfix) with ESMTP id E648613F8F2;
        Tue,  5 Sep 2017 18:39:10 +0200 (CEST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 12C6F10C07EA; Tue,  5 Sep 2017 18:39:10 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] MIPS: Ci20: Enable RTC driver
Date:   Tue,  5 Sep 2017 18:38:58 +0200
Message-Id: <20170905163901.10542-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <mathieu@macbookpro.malat.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

Update the Ci20's defconfig to enable the JZ4780's RTC driver.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/configs/ci20_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index 99719cc4c137..2571045e14df 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -105,6 +105,8 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_JZ4740=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_MEMORY=y
 # CONFIG_DNOTIFY is not set
-- 
2.11.0
