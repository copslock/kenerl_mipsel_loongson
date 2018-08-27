Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2018 22:04:15 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.130]:54806 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994572AbeH0UENFJfCn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Aug 2018 22:04:13 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue007 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MMcW2-1g0Pbd0oHu-008GrQ; Mon, 27 Aug 2018 22:03:43 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-rtc@vger.kernel.org
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        keguang.zhang@gmail.com, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtc: mips: default to rtc-cmos on mips
Date:   Mon, 27 Aug 2018 22:03:08 +0200
Message-Id: <20180827200338.220211-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:4+MfkGX8EpaKqKEPEiV8v+YbGtFRfp0teaMnyqe8y2PMHhf1Ki/
 s9xlBiB8J+Jec+TxcvZIH0ClHYWNgG+jMuLWw0d0K7dr/TN8wbDgcWjcaNglLjksHaTqfGr
 tmFcwyiZjRM4Y6/qVgpURiZWz+xBvT2BSFGnOiPWCb9CdeKzSJrWahOXirntyIdDpU1xi8l
 gUFfGFm93+IlQrkX5cGfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:haLpucbZYLU=:JJZ4zlHDF4o/52I49b/Q/B
 niujBBc5eyg5xVtJalJ6ReoBAK4OU3WIka+Yu7HFTmupJWVVPUcTOe1ADueYkXoPLNvkXiUCg
 nYKl+HzM5bMOMYBf1U8Zzbp2zaXGF5+twFpyqr2SRswC0Nl+dUWxXoZbVq+NsIKU11X/aPN4V
 TCTia0GTGYSApdwYD7vaSnhxFGryM9GFZ0DfmHKshw+NMpC18F2vmeu/YKDx6EEvQKaCLMKfk
 yoDUV3a1c5zuUebd6mnzXhbF3n4WFW8xwY3WzPTnuWXBzvQvxtpbjMDU8vsEwq8ldxKIO3cFv
 hsjeIyGo1jgeTT/cH7d9zOab8v/Iw668spaMw0frJk90l2xnlCzIhPAe+1CJRe2nH9poOdJyz
 Xa7Vg0z0y5wwGjm/lriy7Ioy2OufYmGSKXzGLYb3QND8B1JgYJ5BxzFwGccCXW5i2mUGLPua3
 y1eADRPO62xbt1VB3pBtfJMb0khqepUibZz6N7dA/GWf000i22yHSeLvKgOqMfPpmtFIcILGK
 I3ZEOLKbFG+isuBBEy2WfcrzJ+4njbxYoZBI91xQZ+vr8kHp4t7XNJ5l1UlrcrKzWU4uF6m5l
 pXpXeV0nuAcKPRScE/HoxY7qaBlB6aTFoM9RhfI50HlRucJseP/DpEcuTHmIkCeFbKB9O2Ev+
 vGi5HnyYdd4q6Va6uUPjEiAoXrAv3sHqyuJzGw6s3Jp4+HSxZ3A4Iqbbptr183Ycdlec=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

The old rtc driver is getting in the way of some compat_ioctl
simplification. Looking up the loongson64 git history, it seems
that everyone uses the more modern but compatible RTC_CMOS driver
anyway, so let's remove the special case for loongson64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/Kconfig    | 2 +-
 drivers/char/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 35511999156a..c695825d9377 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -75,7 +75,7 @@ config MIPS
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select MODULES_USE_ELF_REL if MODULES
 	select PERF_USE_VMALLOC
-	select RTC_LIB if !MACH_LOONGSON64
+	select RTC_LIB
 	select SYSCTL_EXCEPTION_TRACE
 	select VIRT_TO_BUS
 
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index ce277ee0a28a..131b4c300050 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -268,7 +268,7 @@ if RTC_LIB=n
 
 config RTC
 	tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"
-	depends on ALPHA || (MIPS && MACH_LOONGSON64)
+	depends on ALPHA
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you
-- 
2.18.0
