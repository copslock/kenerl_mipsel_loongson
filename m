Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 May 2015 23:50:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8993 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013589AbbEUVuJl6yZe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 21 May 2015 23:50:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id E88A2DE9312EC;
        Thu, 21 May 2015 22:50:02 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 21 May
 2015 22:46:59 +0100
Received: from laptop.hh.imgtec.org (10.100.200.44) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 21 May
 2015 22:46:58 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <Damien.Horsley@imgtec.com>, <Govindraj.Raja@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 7/7] mips: pistachio: Allow to enable the external timer based clocksource
Date:   Thu, 21 May 2015 18:43:38 -0300
Message-ID: <1432244618-15548-1-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.44]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

This commit introduces a new config, so the user can choose to enable
the General Purpose Timer based clocksource. This option is required
to have CPUFreq support.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 arch/mips/Kconfig           |  1 +
 arch/mips/pistachio/Kconfig | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 arch/mips/pistachio/Kconfig

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f501665..91f6ca0 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -934,6 +934,7 @@ source "arch/mips/jazz/Kconfig"
 source "arch/mips/jz4740/Kconfig"
 source "arch/mips/lantiq/Kconfig"
 source "arch/mips/lasat/Kconfig"
+source "arch/mips/pistachio/Kconfig"
 source "arch/mips/pmcs-msp71xx/Kconfig"
 source "arch/mips/ralink/Kconfig"
 source "arch/mips/sgi-ip27/Kconfig"
diff --git a/arch/mips/pistachio/Kconfig b/arch/mips/pistachio/Kconfig
new file mode 100644
index 0000000..97731ea
--- /dev/null
+++ b/arch/mips/pistachio/Kconfig
@@ -0,0 +1,13 @@
+config PISTACHIO_GPTIMER_CLKSRC
+	bool "Enable General Purpose Timer based clocksource"
+	depends on MACH_PISTACHIO
+	select CLKSRC_PISTACHIO
+	select MIPS_EXTERNAL_TIMER
+	help
+	  This option enables a clocksource driver based on a Pistachio
+	  SoC General Purpose external timer.
+
+	  If you want to enable the CPUFreq, you need to enable
+	  this option.
+
+	  If you don't want to enable CPUFreq, you can leave this disabled.
-- 
2.3.3
