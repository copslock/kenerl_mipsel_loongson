Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 May 2017 21:51:24 +0200 (CEST)
Received: from mout.kundenserver.de ([212.227.126.134]:65470 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993937AbdEETtM24-3p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 May 2017 21:49:12 +0200
Received: from wuerfel.lan ([78.42.17.5]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MZKwe-1dKxmU2R3s-00KvK5; Fri, 05 May 2017 21:48:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     stable@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.16-stable 85/87] MIPS: Fix the build on jz4740 after removing the custom gpio.h
Date:   Fri,  5 May 2017 21:47:43 +0200
Message-Id: <20170505194745.3627137-86-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170505194745.3627137-1-arnd@arndb.de>
References: <20170505194745.3627137-1-arnd@arndb.de>
X-Provags-ID: V03:K0:J6mrv7o+7gW9TbulpeDYFh+TvZKTE+3NT9/j4UKAC/eCkpRuQlN
 RQ1ReEhVO0qkA4NIt9TKvCZ7ECb5mlfIhBGQlqw1WVPSyMU9m8xYEVligF8r8TuYiKLyW7f
 66M75T1mwNDCLaCiibvPNy4zMr3WbcRqFAZfxIYlnx873aBfVhpwWVcsx6lUJNAP/+7jmGO
 coK3RrsNt6hFpWS7FMmIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b31yLW2N8aU=:cqJYHTu4Eo8x50KNsPXkLg
 fMaJgFGUHRmTIS8oYrBxwvmFg44gjfyigUdgm60l0ThEM529xYN7iNGXtK5pmsUetLYZxsYI1
 Qa1VIhChrKo3xAbdC+oQjUEQwy+PV4xedjQCuwckyKbTyeY+BRbnpwV5ikFx38zH10le8T1Rj
 rIioqb8OWVUbedEvdyUo+uaKqiRrR7w4FPts4mb8NtBTTGuJ5eabJHOliXFnEiP7lWOY6r4nf
 Z1GwWPDndEt3goSBOrjYLyFch7z4ucPsrlgYEUlEAR8gQf9welaqF+xe+Q+pn8hjZ8V08oCQi
 Zrc613vSz2zMOWWdJhclBHQe+z9dzl+gGLYg7gfGOLH1jqDny66GMKlrm3mujb75RMt975jJ+
 jLEUrNUnKjfxxj8AEFMiLgOv+grf3Sj9K6BWbTLth1LDkkW36tMUR6W3LTs9YZnHNV5hWskIC
 9mySlV9DEypVHVs7L2w2CsMcHF9FPcPTlVRD5m17iaxWCsYCV/XWItRHb4lsl2rDLNITCIOCE
 UnIYjidkwf5iUHjs2IpNsh6uzRWdBKl+cI+ckAhti+pSx5gDTkKr98DzYnP+/8du8X2RIjcPO
 dI1UYkx2ifjSnwSYL3bm4H+RefpMYQgzbCFAL4uMAGNFxOpGV0ZQZziBzyZjb1TfayMCeIWu8
 taeVpK4ZR+ix0zM02dKzbPdPlEkwT9lQfqIvLAnYWFzWIdM8gNw3fCgfh3xHlru+smYI=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57858
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

From: Alban Bedel <albeu@free.fr>

Commit 8293821972679f185562c9d2bfadd897fac40243 upstream.

Somehow the wrong version of the patch to remove the use of custom
gpio.h on mips has been merged. This patch add the missing fixes for a
build error on jz4740 because linux/gpio.h doesn't provide any machine
specfics definitions anymore.

Signed-off-by: Alban Bedel <albeu@free.fr>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/11089/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/jz4740/board-qi_lb60.c | 1 +
 arch/mips/jz4740/gpio.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 088e92a79ae6..7da9ff143499 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -25,6 +25,7 @@
 #include <linux/power/jz4740-battery.h>
 #include <linux/power/gpio-charger.h>
 
+#include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/jz4740_fb.h>
 #include <asm/mach-jz4740/jz4740_mmc.h>
 #include <asm/mach-jz4740/jz4740_nand.h>
diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 00b798d2fb7c..000d2d91b704 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -27,6 +27,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/mach-jz4740/base.h>
+#include <asm/mach-jz4740/gpio.h>
 
 #include "irq.h"
 
-- 
2.9.0
