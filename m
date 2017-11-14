Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 11:54:21 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:46879 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdKNKyOjnIQo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 11:54:14 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 10:53:16 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 14 Nov 2017 02:53:06 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        "# 4 . 11 +" <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: indydog: Add dependency on SGI_HAS_INDYDOG
Date:   Tue, 14 Nov 2017 10:52:54 +0000
Message-ID: <1510656774-31464-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1510656794-298552-31901-35895-10
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186911
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
X-archive-position: 60910
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

Commit da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
enabled building the Indy watchdog driver when COMPILE_TEST is enabled.
However, the driver makes reference to symbols that are only defined for
certain platforms are selected in the config. These platforms select
SGI_HAS_INDYDOG. Without this, link time errors result, for example
when building a MIPS allyesconfig.

drivers/watchdog/indydog.o: In function `indydog_write':
indydog.c:(.text+0x18): undefined reference to `sgimc'
indydog.c:(.text+0x1c): undefined reference to `sgimc'
drivers/watchdog/indydog.o: In function `indydog_start':
indydog.c:(.text+0x54): undefined reference to `sgimc'
indydog.c:(.text+0x58): undefined reference to `sgimc'
drivers/watchdog/indydog.o: In function `indydog_stop':
indydog.c:(.text+0xa4): undefined reference to `sgimc'
drivers/watchdog/indydog.o:indydog.c:(.text+0xa8): more undefined
references to `sgimc' follow
make: *** [Makefile:1005: vmlinux] Error 1

Fix this by ensuring that CONFIG_INDIDOG can only be selected when the
necessary dependent platform symbols are built in.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Cc: <stable@vger.kernel.org> # 4.11 +
---

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ca200d1f310a..d96e2e7544fc 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1451,7 +1451,7 @@ config RC32434_WDT
 
 config INDYDOG
 	tristate "Indy/I2 Hardware Watchdog"
-	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST)
+	depends on SGI_HAS_INDYDOG || (MIPS && COMPILE_TEST && SGI_HAS_INDYDOG)
 	help
 	  Hardware driver for the Indy's/I2's watchdog. This is a
 	  watchdog timer that will reboot the machine after a 60 second
-- 
2.7.4
