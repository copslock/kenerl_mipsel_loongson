Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 04:15:41 +0200 (CEST)
Received: from mail-oa0-f74.google.com ([209.85.219.74]:56668 "EHLO
        mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006953AbaH1CPk6lxMf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Aug 2014 04:15:40 +0200
Received: by mail-oa0-f74.google.com with SMTP id eb12so198284oac.1
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 19:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZgng3cxkdgZaBZmRnVsJA1AJr1KiCiKnjesmdUI6ro=;
        b=IdnaqfM4RO40IZxsP9vblrgQaHTJ6YaUccmh0sSJRtINocypPSNDAbo5NEkJm28rau
         3k3Mfa6zAYBnupAJX4Lrgr+YSs1PGBPlMXKBkhd4mlbMhSMdoFvi0SPxD7wkjxwMTp69
         D0JWsWtyNLEJ6YaPS3NCnZ0Pcpg6SoSh5CPzwPvAyW+XPmwfAaWgLy+x5K8i0lvv5wNr
         OBP5T3wtw3IKB65imf5SJZ8hQEY3Z8SAvy72wHPAxWfxWtf1SZCGze7gsYBPtqLZvlh7
         q7JV+hB60fxkRzvre9M+oY8+TqBrnyE3uZCZXXxjxbroerrvyi2IRTOfeSRlDVHDAGsK
         y3oQ==
X-Gm-Message-State: ALoCoQm60Df0S5BMq48QP950FseU70sY51UbFbuPYGLADdAYv11bb9TgzMnNWeuYhWh2PFCD4JUI
X-Received: by 10.43.64.202 with SMTP id xj10mr1333027icb.0.1409192135190;
        Wed, 27 Aug 2014 19:15:35 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id d7si146035yho.2.2014.08.27.19.15.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Aug 2014 19:15:35 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 978D02F4043;
        Wed, 27 Aug 2014 19:10:18 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 575CA22121C; Wed, 27 Aug 2014 19:10:18 -0700 (PDT)
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
Subject: [PATCH v2 5/7] MIPS: sead3: Move device-trees to arch/mips/boot/dts/mti/
Date:   Wed, 27 Aug 2014 19:10:10 -0700
Message-Id: <1409191812-23697-6-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
References: <1409191812-23697-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42295
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

Move the SEAD-3 device-tree to arch/mips/boot/dts/mti/ and update the
Makefiles accordingly.  Since SEAD-3 requires the device-tree to be
built into the kernel, select BUILTIN_DTB when building for SEAD-3.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/Kconfig                               | 1 +
 arch/mips/boot/dts/Makefile                     | 1 +
 arch/mips/boot/dts/mti/Makefile                 | 1 +
 arch/mips/{mti-sead3 => boot/dts/mti}/sead3.dts | 0
 arch/mips/mti-sead3/Makefile                    | 4 ----
 5 files changed, 3 insertions(+), 4 deletions(-)
 create mode 100644 arch/mips/boot/dts/mti/Makefile
 rename arch/mips/{mti-sead3 => boot/dts/mti}/sead3.dts (100%)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dbfcf35..a72c7c9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -353,6 +353,7 @@ config MIPS_SEAD3
 	bool "MIPS SEAD3 board"
 	select BOOT_ELF32
 	select BOOT_RAW
+	select BUILTIN_DTB
 	select CEVT_R4K
 	select CSRC_R4K
 	select CSRC_GIC
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 0f16e92..e32cc0f 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,5 +1,6 @@
 include arch/mips/boot/dts/cavium-octeon/Makefile
 include arch/mips/boot/dts/lantiq/Makefile
+include arch/mips/boot/dts/mti/Makefile
 
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
new file mode 100644
index 0000000..913fac9
--- /dev/null
+++ b/arch/mips/boot/dts/mti/Makefile
@@ -0,0 +1 @@
+dtb-$(CONFIG_MIPS_SEAD3)	+= mti/sead3.dtb
diff --git a/arch/mips/mti-sead3/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
similarity index 100%
rename from arch/mips/mti-sead3/sead3.dts
rename to arch/mips/boot/dts/mti/sead3.dts
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index 071786f..febf433 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -19,9 +19,5 @@ obj-y				+= sead3-i2c-dev.o sead3-i2c.o \
 
 obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
 obj-$(CONFIG_USB_EHCI_HCD)	+= sead3-ehci.o
-obj-$(CONFIG_OF)		+= sead3.dtb.o
 
 CFLAGS_sead3-setup.o = -I$(src)/../../../scripts/dtc/libfdt
-
-$(obj)/%.dtb: $(obj)/%.dts
-	$(call if_changed,dtc)
-- 
2.1.0.rc2.206.gedb03e5
