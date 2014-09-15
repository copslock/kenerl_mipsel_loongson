Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 19:54:28 +0200 (CEST)
Received: from mail-pd0-f202.google.com ([209.85.192.202]:41262 "EHLO
        mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008984AbaIORyJi2DNE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 19:54:09 +0200
Received: by mail-pd0-f202.google.com with SMTP id ft15so904943pdb.1
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 10:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wyISoLytTY0CgTVz+n2dViI+Jk5zN7HmHZG0SritNR0=;
        b=HFRSt7ctJF3FyTNkfjRgGcK1c3I2CdfcZln8T9EpOhHYH2cHuSMJ7taBnIqupsfWAd
         CxLlq/8z1bOAUiPFOfDoQ+dN8fyX370TbWutZw1A02FZYSDwOxu29/SJZCiDHRZxasGI
         eB5IXE4W3Sf2hIYwKZZwK/HY6uMwMoHcUKnXeJOr2mr48VGcCJCQ23zyM4srfjzv05Q9
         ZkESS6lVGLT6wXLEWa9FWxWTFN9bMvmZVJuQi9NSa7mhQRaBHMCFZJk2ahcZGBHaqQV7
         tXIyLxCvkTe9kZwAd/rTJxL8UBjRnDDxf+F4jjiUVR1PbR4hUuBO3TV4pCRE4cXyXrMl
         8sIA==
X-Gm-Message-State: ALoCoQlaGDl7MAkyTGMQ/MW2kvbFwMTOUVPST93MFvimnyilXTbgD6GqPM6o8lfZclzUrU2nwmh4
X-Received: by 10.66.156.100 with SMTP id wd4mr16021907pab.31.1410803643097;
        Mon, 15 Sep 2014 10:54:03 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n24si575731yha.6.2014.09.15.10.54.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 10:54:03 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id hSixDVIG.1; Mon, 15 Sep 2014 10:54:02 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 45253220CE8; Mon, 15 Sep 2014 10:54:01 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        James Hogan <james.hogan@imgtec.com>,
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
        devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] MIPS: Create common infrastructure for building built-in device-trees
Date:   Mon, 15 Sep 2014 10:53:57 -0700
Message-Id: <1410803639-3159-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410803639-3159-1-git-send-email-abrestic@chromium.org>
References: <1410803639-3159-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42572
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

In preparation for moving the device-trees to a common location,
introduce the config option BUILTIN_DTB, which can be selected by
platforms that use a device-tree built into the kernel image, and
create a Makefile to build the device-trees in arch/mips/boot/dts/.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes from v2:
 - use $(dts-dirs) for descending into vendor subdirs
No changes from v1.
---
 arch/mips/Kconfig           | 3 +++
 arch/mips/Makefile          | 6 ++++++
 arch/mips/boot/dts/Makefile | 4 ++++
 3 files changed, 13 insertions(+)
 create mode 100644 arch/mips/boot/dts/Makefile

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 900c7e5..ffa8388 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2479,6 +2479,9 @@ config USE_OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
 
+config BUILTIN_DTB
+	bool
+
 endmenu
 
 config LOCKDEP_SUPPORT
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 9336509..72cdd6a 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -324,6 +324,12 @@ endif
 
 CLEAN_FILES += vmlinux.32 vmlinux.64
 
+# device-trees
+core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
+
+%.dtb %.dtb.S %.dtb.o: | scripts
+	$(Q)$(MAKE) $(build)=arch/mips/boot/dts arch/mips/boot/dts/$@
+
 archprepare:
 ifdef CONFIG_MIPS32_N32
 	@echo '  Checking missing-syscalls for N32'
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
new file mode 100644
index 0000000..4a78bad
--- /dev/null
+++ b/arch/mips/boot/dts/Makefile
@@ -0,0 +1,4 @@
+obj-y		+= $(addsuffix /, $(dts-dirs))
+
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb *.dtb.S
-- 
2.1.0.rc2.206.gedb03e5
