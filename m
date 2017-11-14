Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 18:16:51 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:34527 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbdKNRQpCy5Lh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 18:16:45 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 17:16:36 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 14 Nov 2017 09:16:34 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: BCM47XX Avoid compile error with MIPS allnoconfig
Date:   Tue, 14 Nov 2017 17:16:27 +0000
Message-ID: <1510679787-7944-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1510679791-321457-1720-3690-2
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186919
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Currently MIPS allnoconfig with CONFIG_BCM47XX=y fails to compile due to
neither BCM47XX_BCMA nor BCM47XX_SSB being selected. This leads the
enumeration in arch/mips/include/asm/mach-bcm47xx/bcm47xx.h to be empty,
and compilation fails:

In file included from arch/mips/bcm47xx/irq.c:32:0:
./arch/mips/include/asm/mach-bcm47xx/bcm47xx.h:34:1: error: expected
identifier before '}' token
 };
 ^
make[2]: *** [scripts/Makefile.build:314: arch/mips/bcm47xx/irq.o] Error 1

Fix this by ensuring that BCM47XX_SSB is selected if BCM47XX_BCMA is
not. This allows us to select either system or both, but not neither.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990fc719..659e0079487f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -259,6 +259,7 @@ config BCM47XX
 	select LEDS_GPIO_REGISTER
 	select BCM47XX_NVRAM
 	select BCM47XX_SPROM
+	select BCM47XX_SSB if !BCM47XX_BCMA
 	help
 	 Support for BCM47XX based boards
 
-- 
2.7.4
