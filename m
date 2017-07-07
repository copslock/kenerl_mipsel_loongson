Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 18:12:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:5246 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993944AbdGGQM3CgK1- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 18:12:29 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 664A04BD61B5D;
        Fri,  7 Jul 2017 17:12:19 +0100 (IST)
Received: from LDT-H-Hunt.le.imgtec.org (192.168.154.107) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 7 Jul 2017 17:12:23 +0100
From:   Harvey Hunt <harvey.hunt@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     Harvey Hunt <harvey.hunt@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: Ci20: Enable GPIO driver
Date:   Fri, 7 Jul 2017 17:12:07 +0100
Message-ID: <1499443928-10620-1-git-send-email-harvey.hunt@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.107]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

Update the Ci20's defconfig to enable the JZ4780's GPIO driver.

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: linux-mips@linux-mips.org 
Cc: linux-kernel@vger.kernel.org 
---
Ralf, both of these patches rely on Paul Cercueil's pinctrl
and gpio patches from Linus Walleij's 4.13 pinctrl pull request.

 arch/mips/configs/ci20_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index 43e0ba2..ce317ff 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -92,6 +92,7 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_I2C=y
 CONFIG_I2C_JZ4780=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_INGENIC=y
 # CONFIG_HWMON is not set
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DEBUG=y
-- 
2.7.4
