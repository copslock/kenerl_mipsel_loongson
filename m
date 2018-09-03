Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Sep 2018 19:22:44 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993900AbeICRWjxyy1H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Sep 2018 19:22:39 +0200
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7F6F8D0A;
        Mon,  3 Sep 2018 17:22:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Paul Burton <paul.burton@mips.com>,
        Michael Marley <michael@michaelmarley.com>,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 059/165] Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"
Date:   Mon,  3 Sep 2018 18:55:45 +0200
Message-Id: <20180903165658.087169226@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65906
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Rafał Miłecki" <rafal@milecki.pl>

[ Upstream commit d5ea019f8a381f88545bb26993b62ec24a2796b7 ]

This reverts commit 2a027b47dba6 ("MIPS: BCM47XX: Enable 74K Core
ExternalSync for PCIe erratum").

Enabling ExternalSync caused a regression for BCM4718A1 (used e.g. in
Netgear E3000 and ASUS RT-N16): it simply hangs during PCIe
initialization. It's likely that BCM4717A1 is also affected.

I didn't notice that earlier as the only BCM47XX devices with PCIe I
own are:
1) BCM4706 with 2 x 14e4:4331
2) BCM4706 with 14e4:4360 and 14e4:4331
it appears that BCM4706 is unaffected.

While BCM5300X-ES300-RDS.pdf seems to document that erratum and its
workarounds (according to quotes provided by Tokunori) it seems not even
Broadcom follows them.

According to the provided info Broadcom should define CONF7_ES in their
SDK's mipsinc.h and implement workaround in the si_mips_init(). Checking
both didn't reveal such code. It *could* mean Broadcom also had some
problems with the given workaround.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Michael Marley <michael@michaelmarley.com>
Patchwork: https://patchwork.linux-mips.org/patch/20032/
URL: https://bugs.openwrt.org/index.php?do=details&task_id=1688
Cc: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/bcm47xx/setup.c        |    6 ------
 arch/mips/include/asm/mipsregs.h |    3 ---
 2 files changed, 9 deletions(-)

--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -212,12 +212,6 @@ static int __init bcm47xx_cpu_fixes(void
 		 */
 		if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
 			cpu_wait = NULL;
-
-		/*
-		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
-		 * Enable ExternalSync for sync instruction to take effect
-		 */
-		set_c0_config7(MIPS_CONF7_ES);
 		break;
 #endif
 	}
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -680,8 +680,6 @@
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
-/* ExternalSync */
-#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
 
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
@@ -2747,7 +2745,6 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
-__BUILD_SET_C0(config7)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
