Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 10:30:14 +0100 (CET)
Received: from nbd.name ([IPv6:2a01:4f8:131:30e2::2]:56146 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992942AbdBTJ3rJa0z4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Feb 2017 10:29:47 +0100
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 1/3] arch: mips: pci: remove duplicate define in mt7620 driver
Date:   Mon, 20 Feb 2017 10:29:42 +0100
Message-Id: <1487582984-40143-2-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1487582984-40143-1-git-send-email-john@phrozen.org>
References: <1487582984-40143-1-git-send-email-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

An invalid and duplicate define has gone unnoticed for some time. lets
remove it. The correct define is 3 lines below.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/pci/pci-mt7620.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index 628c513..3fdaf7c 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -33,7 +33,6 @@
 #define RALINK_GPIOMODE			0x60
 
 #define PPLL_CFG1			0x9c
-#define PDRV_SW_SET			BIT(23)
 
 #define PPLL_DRV			0xa0
 #define PDRV_SW_SET			(1<<31)
-- 
1.7.10.4
