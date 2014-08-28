Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 05:16:05 +0200 (CEST)
Received: from mail-oi0-f73.google.com ([209.85.218.73]:43488 "EHLO
        mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006945AbaH1DQDnLqUM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 05:16:03 +0200
Received: by mail-oi0-f73.google.com with SMTP id u20so205925oif.0
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 20:15:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nSPJEKwzKAE56Kjtm9qzIIKzQ2dK5s6P7j1DypD/XDM=;
        b=EcJ4TYALra6CbL1U7gZ/fHrN1eX2a+LzAV+zPIq9eNnOZT0KkvW2nkTr+ljUF8v2hV
         e21ruuvkhL2r0+mfgDLcrjfmqAVejMoa9sWH1s8/Rhj4lmbllhZA9WmM8KFHDQxKpp+j
         ArJcDxzKdLJ46ACpVApxFgNNfPnBU+SJvVz5APnwyh5pNe9EJR8sIjqChKu7n8KdnMYn
         +v+QxjSE6bwkiql1QLzKcGuDlau+/0IVVqKBwfVDZxqCTMsPH0mWFDfktyG8VaxsHk1S
         n7DAYqhq1TiJB9cmYN3s+icuy73LAAomjuN3AyCjnl5NNKCPeN2PLqc7ts1T8QWPh0tN
         ASGQ==
X-Gm-Message-State: ALoCoQkk9JUbIJ+XC/KsUlfL6ueRnl3GMz6L4fu8BwghZfhLt5mVhgYaaGDzOOYTG/pbz6u9HD4O
X-Received: by 10.182.29.10 with SMTP id f10mr691201obh.23.1409195757516;
        Wed, 27 Aug 2014 20:15:57 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id m14si150350yhm.7.2014.08.27.20.15.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Aug 2014 20:15:57 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D67792F4042;
        Wed, 27 Aug 2014 19:10:17 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 963AF22121C; Wed, 27 Aug 2014 19:10:17 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        John Crispin <blogic@openwrt.org>,
        Jayachandran C <jchandra@broadcom.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH v2 4/7] MIPS: Lantiq: Move device-trees to arch/mips/boot/dts/lantiq/
Date:   Wed, 27 Aug 2014 19:10:09 -0700
Message-Id: <1409191812-23697-5-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
References: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Move the Lantiq device-trees to arch/mips/boot/dts/lantiq/ and update
the Makefiles accordingly.  There is currently only a single Lantiq
device-tree (EASY50712), and it's required to be built into the kernel,
so select BUILTIN_DTB for it.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/boot/dts/Makefile                             | 1 +
 arch/mips/boot/dts/lantiq/Makefile                      | 1 +
 arch/mips/{lantiq/dts => boot/dts/lantiq}/danube.dtsi   | 0
 arch/mips/{lantiq/dts => boot/dts/lantiq}/easy50712.dts | 0
 arch/mips/lantiq/Kconfig                                | 1 +
 arch/mips/lantiq/Makefile                               | 2 --
 arch/mips/lantiq/dts/Makefile                           | 1 -
 7 files changed, 3 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/boot/dts/lantiq/Makefile
 rename arch/mips/{lantiq/dts => boot/dts/lantiq}/danube.dtsi (100%)
 rename arch/mips/{lantiq/dts => boot/dts/lantiq}/easy50712.dts (100%)
 delete mode 100644 arch/mips/lantiq/dts/Makefile

diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index a8daed1..0f16e92 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,4 +1,5 @@
 include arch/mips/boot/dts/cavium-octeon/Makefile
+include arch/mips/boot/dts/lantiq/Makefile
 
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
new file mode 100644
index 0000000..d68f45a
--- /dev/null
+++ b/arch/mips/boot/dts/lantiq/Makefile
@@ -0,0 +1 @@
+dtb-$(CONFIG_DT_EASY50712)	+= lantiq/easy50712.dtb
diff --git a/arch/mips/lantiq/dts/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
similarity index 100%
rename from arch/mips/lantiq/dts/danube.dtsi
rename to arch/mips/boot/dts/lantiq/danube.dtsi
diff --git a/arch/mips/lantiq/dts/easy50712.dts b/arch/mips/boot/dts/lantiq/easy50712.dts
similarity index 100%
rename from arch/mips/lantiq/dts/easy50712.dts
rename to arch/mips/boot/dts/lantiq/easy50712.dts
diff --git a/arch/mips/lantiq/Kconfig b/arch/mips/lantiq/Kconfig
index c002191..e10d333 100644
--- a/arch/mips/lantiq/Kconfig
+++ b/arch/mips/lantiq/Kconfig
@@ -30,6 +30,7 @@ choice
 config DT_EASY50712
 	bool "Easy50712"
 	depends on SOC_XWAY
+	select BUILTIN_DTB
 endchoice
 
 config PCI_LANTIQ
diff --git a/arch/mips/lantiq/Makefile b/arch/mips/lantiq/Makefile
index d6bdc57..690257a 100644
--- a/arch/mips/lantiq/Makefile
+++ b/arch/mips/lantiq/Makefile
@@ -6,8 +6,6 @@
 
 obj-y := irq.o clk.o prom.o
 
-obj-y += dts/
-
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 
 obj-$(CONFIG_SOC_TYPE_XWAY) += xway/
diff --git a/arch/mips/lantiq/dts/Makefile b/arch/mips/lantiq/dts/Makefile
deleted file mode 100644
index 6fa72dd..0000000
--- a/arch/mips/lantiq/dts/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_DT_EASY50712) := easy50712.dtb.o
-- 
2.1.0.rc2.206.gedb03e5
