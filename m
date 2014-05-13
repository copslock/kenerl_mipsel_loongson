Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2014 17:07:27 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56775 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6854810AbaEMPHQ5QKK5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 May 2014 17:07:16 +0200
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1WkEIU-0001vh-Ny; Tue, 13 May 2014 17:07:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Hua Yan <yanh@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Hongliang Tao <taohl@lemote.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] MIPS: Lemote 2F: cs5536: mfgpt: depend on !highres
Date:   Tue, 13 May 2014 17:07:05 +0200
Message-Id: <1399993625-8747-2-git-send-email-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.0.0.rc0
In-Reply-To: <1399993625-8747-1-git-send-email-bigeasy@linutronix.de>
References: <1399993625-8747-1-git-send-email-bigeasy@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <bigeasy@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bigeasy@linutronix.de
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

This timer does not support oneshot mode and as such the system remains
in periodic mode and won't support high res timers.
This patch adds a note about this in Kconfig and lets it depend on
!highres so users which want to use high timers don' stuck with this
timer.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/mips/loongson/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
index 7397be2..0ed955e 100644
--- a/arch/mips/loongson/Kconfig
+++ b/arch/mips/loongson/Kconfig
@@ -96,10 +96,11 @@ config CS5536
 
 config CS5536_MFGPT
 	bool "CS5536 MFGPT Timer"
-	depends on CS5536
+	depends on CS5536 && !HIGH_RES_TIMERS
 	select MIPS_EXTERNAL_TIMER
 	help
-	  This option enables the mfgpt0 timer of AMD CS5536.
+	  This option enables the mfgpt0 timer of AMD CS5536. With this timer
+	  switched on you can not use high resolution timers.
 
 	  If you want to enable the Loongson2 CPUFreq Driver, Please enable
 	  this option at first, otherwise, You will get wrong system time.
-- 
2.0.0.rc0
