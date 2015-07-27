Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jul 2015 16:03:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:58110 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011332AbbG0OC3vD3sd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jul 2015 16:02:29 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 147CD91BEEFE2;
        Mon, 27 Jul 2015 15:02:21 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 27 Jul
 2015 15:02:24 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 27 Jul 2015 15:02:23 +0100
From:   Govindraj Raja <govindraj.raja@imgtec.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <devicetree@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        "Govindraj Raja" <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH v4 7/7] mips: pistachio: Allow to enable the external timer based clocksource
Date:   Mon, 27 Jul 2015 15:02:35 +0100
Message-ID: <1438005755-27051-3-git-send-email-govindraj.raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438005755-27051-1-git-send-email-govindraj.raja@imgtec.com>
References: <1438005755-27051-1-git-send-email-govindraj.raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: govindraj.raja@imgtec.com
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

From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

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
index cee5f93..c0cc9e4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -948,6 +948,7 @@ source "arch/mips/jazz/Kconfig"
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
1.9.1
