Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 22:59:48 +0100 (CET)
Received: from smtp-out-no.shaw.ca ([64.59.134.13]:35183 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992178AbdBGV72dC8BC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 22:59:28 +0100
Received: from triton.mmayer.net ([70.71.160.251])
        by shaw.ca with SMTP
        id bDnCcMntQVQuxbDnDcVskQ; Tue, 07 Feb 2017 14:59:22 -0700
X-Authority-Analysis: v=2.2 cv=BNTDlBYG c=1 sm=1 tr=0
 a=6xzog4CasRozao6qlzTIAw==:117 a=6xzog4CasRozao6qlzTIAw==:17
 a=n2v9WMKugxEA:10 a=Q-fNiiVtAAAA:8 a=KKAkSRfTAAAA:8 a=1vzQUOBs5t2bzyhwSnoA:9
 a=Fp8MccfUoT0GBdDC_Lng:22 a=cvBusfyB2V15izCimMoJ:22
Received: by triton.mmayer.net (Postfix, from userid 501)
        id 5D70E33B35EF; Tue,  7 Feb 2017 13:59:18 -0800 (PST)
From:   Markus Mayer <code@mmayer.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/4] MIPS: BMIPS: Update defconfig
Date:   Tue,  7 Feb 2017 13:58:53 -0800
Message-Id: <20170207215856.8999-2-code@mmayer.net>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20170207215856.8999-1-code@mmayer.net>
References: <20170207215856.8999-1-code@mmayer.net>
X-CMAE-Envelope: MS4wfHnpUM9uhIArC74nViaZhDqpp52+ooJdym3PLqe+LOkaWys3Hnhk4Qrkq/T48ndRSIDuKqT0ZLFAHuZbIp3pdfYINOp2BQ9dotk13c2XKc/PJKAuX48j
 cfe0yrOiEhNpt+5ofOJ7+EU4azPKmNFGkWc9z3dTcMfRIf/ZuwvLxj1VksUeJdpIQWAY7fd3KIK24EHgVQadEGpus/B+lX3wfKGtwmB5a4Z2mGKVyDuRyO7b
 EG02cMGuHPilrc6c+Q8QlH91LAA4sUivuC06l0zoMGraO0h76OCdBGqxE3iQr3zDd37UlhN7t3nOptOb5bN12EHqGLFaHIkXPU9OOeq4Gsq9nHvYcByJF2zp
 XV2CiXc9dcGjnoMcV8Qm0lsBT/6yug==
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: code@mmayer.net
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

From: Markus Mayer <mmayer@broadcom.com>

Ran "make savedefconfig" to bring bmips_stb_defconfig up to date.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/mips/configs/bmips_stb_defconfig | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 4eb5d6e..3be15cb 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -9,7 +9,6 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_SWAP is not set
 CONFIG_NO_HZ=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_RD_GZIP=y
 CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
@@ -24,7 +23,6 @@ CONFIG_INET=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
 # CONFIG_INET_DIAG is not set
 CONFIG_CFG80211=y
 CONFIG_NL80211_TESTMODE=y
@@ -34,8 +32,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
-CONFIG_PRINTK_TIME=y
-CONFIG_BRCMSTB_GISB_ARB=y
 CONFIG_MTD=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
@@ -51,16 +47,15 @@ CONFIG_USB_USBNET=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-# CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
 # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_BRCMSTB=y
 CONFIG_POWER_RESET_SYSCON=y
+CONFIG_POWER_SUPPLY=y
 # CONFIG_HWMON is not set
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
@@ -82,6 +77,7 @@ CONFIG_CIFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CMDLINE_BOOL=y
-- 
2.7.4
