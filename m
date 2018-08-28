Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Aug 2018 16:27:54 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.133]:35811 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992494AbeH1O1vtWUnq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Aug 2018 16:27:51 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue004 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LpiwE-1fPQwz3sBi-00fTIF; Tue, 28 Aug 2018 16:27:28 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-rtc@vger.kernel.org
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        keguang.zhang@gmail.com, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] rtc: mips: default to rtc-cmos on mips
Date:   Tue, 28 Aug 2018 16:26:30 +0200
Message-Id: <20180828142724.4067857-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:DmjXOi4/gJR2KnJwod3hWwHoDox+Y29gAUi3IYfc8UHwkVPajxY
 B6crdUCfMGVsn5WsMRO9snGl5u+SWAv5fNi0Hb2Me2emXh8lofVX06RIu0k8SZXugAp+xOU
 yfFyomLDPGY6qi4WUKxomKX6KGDoPjS7+/WgMjsIl0HEytGgBmqZRGQHCY1WYCvyne//2FM
 CikQb1SKhD3tChAuQpZ8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iE5WrV4a8O0=:v+nti9amxgnZBwOPU9RL9C
 mzHOjgaX2Wzk0tGsmZVblac5fnMWdl9Xc/PlwHkuhw97oCLamrdLDyZkHK1pKZKP87yMXbwIi
 vFzrDtIZuM492miLk7AoDGPaRaMELfkGRlvKf3BT4j1gSS3UTirs115I4ceBb17glWxdcQCQ7
 uH1DhkkoceNSrXP91RDdqNnSQiwmm20NADZaI/Srb0AE8hF4P4CLxQS19lajNUEkVCURq1X26
 x7RZA2R1pL9D20BaUIMsz8s/h5gT9viwDhq1xNjhwBhi2E53UsEJ+hblzsVvKUL0HNxoLF6yA
 cS7mmcfbYU11Q8DGf0eyf+xDN7uJAKezpGfP1MDpLM/Q/N/fdi5mkuuuUMd0+QOJsM4ryx5yV
 fZOqerY4yUK7a4Gy+CN51+QlUBLTDLRFydatCdQ8ityufEOJV9x2qGl+qCufW917dlzDXmFke
 BMd9yaXhF346/HqYn7bGg5wALEM62R3XvY3QaesY2fkwE1iaa5XWGvRS5yWnGCAj7Qgf7EDAy
 19QFB0ArsybuxLEh8Fs9NcO4mULf7p93OfQFtm2QTzUrxS2i72bDVxBIy7lkBfkPa1twP2+rb
 5wkBj6rP6bXcx30mZcWskNIk03P55aJr25bQ7W/buue4cASIFlNOV3+LRb6AlAOyZByeb54ST
 RQ59FuMXIHwGJ2OUKLu3b5SyyA0is92klbTBUnoq7K5EwZnS5uqPPUwYMo9tCzvi1S0g=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65761
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
