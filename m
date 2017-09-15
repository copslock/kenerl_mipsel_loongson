Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Sep 2017 21:18:12 +0200 (CEST)
Received: from smtp3-g21.free.fr ([IPv6:2a01:e0c:1:1599::12]:18926 "EHLO
        smtp3-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991500AbdIOTSFlCWg5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Sep 2017 21:18:05 +0200
Received: from macbookpro.malat.net (unknown [78.225.226.121])
        by smtp3-g21.free.fr (Postfix) with ESMTP id 47DD913F8AF;
        Fri, 15 Sep 2017 21:18:04 +0200 (CEST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 98C4F10C0911; Fri, 15 Sep 2017 21:18:03 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] MIPS: Ci20: Enable watchdog driver
Date:   Fri, 15 Sep 2017 21:17:54 +0200
Message-Id: <20170915191756.27413-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170908183558.1537-1-malat@debian.org>
References: <20170908183558.1537-1-malat@debian.org>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <mathieu@macbookpro.malat.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60030
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

Update the Ci20's defconfig to enable the JZ4740's watchdog driver.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
Changes in v2:
* none

 arch/mips/configs/ci20_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index 19a8ebd1d374..ed8d3d2f63cf 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -100,6 +100,8 @@ CONFIG_I2C_JZ4780=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_INGENIC=y
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_JZ4740_WDT=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DEBUG=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.11.0
