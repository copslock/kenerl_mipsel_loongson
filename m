Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 22:28:18 +0200 (CEST)
Received: from mail-qa0-f73.google.com ([209.85.216.73]:51352 "EHLO
        mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006156AbaHVU2Ral3OT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 22:28:17 +0200
Received: by mail-qa0-f73.google.com with SMTP id s7so1317591qap.0
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 13:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1chXnKguoKiFAtYoNdljFfD+sHVEkh42069ZayxXFY=;
        b=Edorm24A+9uI6JUZnd+sp/toPtEWX6njP0LGewiQl9G1wKlbmSWZpr1WRTZACAXmQt
         jTn9YKwcBptb/d/Vnc/bfyXaltf8OFiDNX0PfK1wx3pHHm4DtvDiwkjTyIgast2VWpTL
         orJ28aPs2KzAAK2GQGfxdciC6k1j+RpYlVvQsuKTinn8K5JuBRXd7ITh578Pd0APJ/OC
         FsLU3hN3uEArSvxxgF3OSYsMlhOnk/V5EYFa6XCya5PqMSm/rto8SOvFzaqIXJfSY72w
         b8zkkFNkJ9VvxN3HXy4n+ozg4c+GdcciTtIAOvnzCXq0l3HsqSRYzHaNQl7v8Bvd/hJk
         FDjA==
X-Gm-Message-State: ALoCoQmrhosd7l+pyKQrxvz25ub22W7qvZPTk7fr8bzOVdY85I+8ouq91IqfsOH0zlwkDjpeO6PN
X-Received: by 10.236.77.42 with SMTP id c30mr631062yhe.6.1408651488701;
        Thu, 21 Aug 2014 13:04:48 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id f44si123257yhf.1.2014.08.21.13.04.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Aug 2014 13:04:48 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 66A7C31C5D0;
        Thu, 21 Aug 2014 13:04:48 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 26A9D220378; Thu, 21 Aug 2014 13:04:48 -0700 (PDT)
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
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 3/7] MIPS: Octeon: Move device-trees to arch/mips/boot/dts/
Date:   Thu, 21 Aug 2014 13:04:22 -0700
Message-Id: <1408651466-8334-4-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
References: <1408651466-8334-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42170
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

Move the Octeon device-trees to arch/mips/boot/dts/ and update the
Makefiles accordingly.  Since Octeon requires the device-tree to be
built into the kernel, select BUILTIN_DTB as well.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/Kconfig                                     |  1 +
 arch/mips/boot/dts/Makefile                           |  2 ++
 arch/mips/{cavium-octeon => boot/dts}/octeon_3xxx.dts |  0
 arch/mips/{cavium-octeon => boot/dts}/octeon_68xx.dts |  0
 arch/mips/cavium-octeon/.gitignore                    |  2 --
 arch/mips/cavium-octeon/Makefile                      | 10 ----------
 6 files changed, 3 insertions(+), 12 deletions(-)
 rename arch/mips/{cavium-octeon => boot/dts}/octeon_3xxx.dts (100%)
 rename arch/mips/{cavium-octeon => boot/dts}/octeon_68xx.dts (100%)
 delete mode 100644 arch/mips/cavium-octeon/.gitignore

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 19b8aac..dbfcf35 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -741,6 +741,7 @@ config CAVIUM_OCTEON_SOC
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_SMP
 	select NR_CPUS_DEFAULT_16
+	select BUILTIN_DTB
 	help
 	  This option supports all of the Octeon reference boards from Cavium
 	  Networks. It builds a kernel that dynamically determines the Octeon
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index 9b3da1f..51acad6 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -1,3 +1,5 @@
+dtb-$(CONFIG_CAVIUM_OCTEON_SOC)		+= octeon_3xxx.dtb octeon_68xx.dtb
+
 obj-y		+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
 
 targets		+= dtbs
diff --git a/arch/mips/cavium-octeon/octeon_3xxx.dts b/arch/mips/boot/dts/octeon_3xxx.dts
similarity index 100%
rename from arch/mips/cavium-octeon/octeon_3xxx.dts
rename to arch/mips/boot/dts/octeon_3xxx.dts
diff --git a/arch/mips/cavium-octeon/octeon_68xx.dts b/arch/mips/boot/dts/octeon_68xx.dts
similarity index 100%
rename from arch/mips/cavium-octeon/octeon_68xx.dts
rename to arch/mips/boot/dts/octeon_68xx.dts
diff --git a/arch/mips/cavium-octeon/.gitignore b/arch/mips/cavium-octeon/.gitignore
deleted file mode 100644
index 39c9686..0000000
--- a/arch/mips/cavium-octeon/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-*.dtb.S
-*.dtb
diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 4e95204..42f5f1a 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -20,13 +20,3 @@ obj-y += executive/
 obj-$(CONFIG_MTD)		      += flash_setup.o
 obj-$(CONFIG_SMP)		      += smp.o
 obj-$(CONFIG_OCTEON_ILM)	      += oct_ilm.o
-
-DTS_FILES = octeon_3xxx.dts octeon_68xx.dts
-DTB_FILES = $(patsubst %.dts, %.dtb, $(DTS_FILES))
-
-obj-y += $(patsubst %.dts, %.dtb.o, $(DTS_FILES))
-
-# Let's keep the .dtb files around in case we want to look at them.
-.SECONDARY:  $(addprefix $(obj)/, $(DTB_FILES))
-
-clean-files += $(DTB_FILES) $(patsubst %.dtb, %.dtb.S, $(DTB_FILES))
-- 
2.1.0.rc2.206.gedb03e5
