Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Dec 2013 18:00:45 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:46408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823900Ab3LNRAkRItYr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 Dec 2013 18:00:40 +0100
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rBEH0Ja9029670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sat, 14 Dec 2013 12:00:19 -0500
Received: from deneb.redhat.com (ovpn-113-72.phx2.redhat.com [10.3.113.72])
        by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id rBEGxotD012322;
        Sat, 14 Dec 2013 12:00:16 -0500
From:   Mark Salter <msalter@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Salter <msalter@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        linux-alpha@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
Date:   Sat, 14 Dec 2013 11:59:36 -0500
Message-Id: <1387040376-26906-11-git-send-email-msalter@redhat.com>
In-Reply-To: <1387040376-26906-1-git-send-email-msalter@redhat.com>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Return-Path: <msalter@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: msalter@redhat.com
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

Remove messy dependencies from SERIO_I8042 by having it depend on one
Kconfig symbol (ARCH_MIGHT_HAVE_PC_SERIO) and having architectures
which need it select ARCH_MIGHT_HAVE_PC_SERIO in arch/*/Kconfig.
New architectures are unlikely to need SERIO_I8042, so this avoids
having an ever growing list of architectures to exclude.

Signed-off-by: Mark Salter <msalter@redhat.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Richard Henderson <rth@twiddle.net>
CC: linux-alpha@vger.kernel.org
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel@lists.infradead.org
CC: Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>
CC: linux-ia64@vger.kernel.org
CC: Ralf Baechle <ralf@linux-mips.org>
CC: linux-mips@linux-mips.org
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@lists.ozlabs.org
CC: Paul Mundt <lethal@linux-sh.org>
CC: linux-sh@vger.kernel.org
CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
CC: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
---
 drivers/input/serio/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 8541f94..1f5cec2 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -16,14 +16,19 @@ config SERIO
 	  To compile this driver as a module, choose M here: the
 	  module will be called serio.
 
+config ARCH_MIGHT_HAVE_PC_SERIO
+	bool
+	help
+	  Select this config option from the architecture Kconfig if
+	  the architecture might use a PC serio device (i8042) to
+          communicate with keyboard, mouse, etc.
+
 if SERIO
 
 config SERIO_I8042
 	tristate "i8042 PC Keyboard controller"
 	default y
-	depends on !PARISC && (!ARM || FOOTBRIDGE_HOST) && \
-		   (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN && !S390 && \
-		   !ARC
+	depends on ARCH_MIGHT_HAVE_PC_SERIO
 	help
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,
-- 
1.8.3.1
