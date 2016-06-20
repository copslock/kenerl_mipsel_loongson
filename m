Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Jun 2016 11:13:56 +0200 (CEST)
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36062 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27043106AbcFTJNyECOgJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Jun 2016 11:13:54 +0200
Received: by mail-wm0-f65.google.com with SMTP id c82so9445380wme.3
        for <linux-mips@linux-mips.org>; Mon, 20 Jun 2016 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Daqf83TsxQ90xekzrS9JpDS/uOOoA0/HU5HNp90/9ec=;
        b=zNXQonQQ8wVCwOiwCu+nRM+rd4pm5Ekv/j+lf6PS8EmTFzMUdi0wWSikh0y1KLttRz
         O76DA2+S6Uqg/z/XRXSmMq7WIKCUYUTfa2eG6UkOFQecxaz9DHywczBzvAbosR88jXtH
         Ev5Sju7un6X73xlIYWu3HoHDToQV/IDAbSGKU9NJ5vgJwonfV6P4SJ9l7DfpmjITDpxr
         Ie61uqOEI5sDKkQ2VkSrEDLbLtYEm2Yw0X2mYEqqpjllMr/nRbweLfqNrjkl1vpyQ2X5
         JXh07HZbQoxcXkgiFx+90BVfABA9+IuJxUtmAhg9khnsEAD0MTKxNTPNsv7RAHccdFD/
         YYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Daqf83TsxQ90xekzrS9JpDS/uOOoA0/HU5HNp90/9ec=;
        b=ZvJvq5o5+2nusM3CfoQ8ggxGxfQTnNhsBBrA8LFUTRL80eHoa2VKWm63R0qSoHv3iE
         EWBGsDSdgpm4Tottborekk5WNINmlhar2jyp3JqGE5J8hEM/NWRzZgihEZ4YCiMtAedc
         89QShJvYdN4/Bnt7F6XQM+hQai6Wq/rxOnEuCAEHI6sU1WzJTCt/fUUaBsrgU4sM84qp
         ZRR7oQtg9sp376DMPO+jIv0sYg0xBxTpmtdKzIiPiNqSKA/de96413qLJqQ0gKZLO8w3
         W8iL9CGhlNGgtHDGFovFIhlh5yEdoirG293OrK0RFb1EpF6bdTzEVbs9P0XJbXU9gNHY
         h/2Q==
X-Gm-Message-State: ALyK8tJF89Vbdl+7Kl0g4uxOVypH7oAyw45rHniXv4h+fivacZ2oOUh2HYOSiBRGrTc7Mw==
X-Received: by 10.194.139.162 with SMTP id qz2mr13501552wjb.111.1466414023830;
        Mon, 20 Jun 2016 02:13:43 -0700 (PDT)
Received: from localhost.localdomain ([188.24.248.70])
        by smtp.gmail.com with ESMTPSA id u6sm62289807wjy.17.2016.06.20.02.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2016 02:13:43 -0700 (PDT)
From:   Alexandru Moise <00moses.alexander00@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, bamvor.zhangjian@linaro.org,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        Alexandru Moise <00moses.alexander00@gmail.com>
Subject: [PATCH] devpts: remove DEVPTS_MULTIPLE_INSTANCES from all configs
Date:   Mon, 20 Jun 2016 12:12:58 +0300
Message-Id: <20160620091258.11233-1-00moses.alexander00@gmail.com>
X-Mailer: git-send-email 2.8.3
Return-Path: <00moses.alexander00@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: 00moses.alexander00@gmail.com
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

As each mount of devpts is now an independent filesystem,
the DEVPTS_MULTIPLE_INSTANCES config option no longer exists.
So remove it.

Signed-off-by: Alexandru Moise <00moses.alexander00@gmail.com>
---
 arch/arc/configs/tb10x_defconfig            | 1 -
 arch/arm/configs/mxs_defconfig              | 1 -
 arch/mips/configs/ip27_defconfig            | 1 -
 arch/mips/configs/nlm_xlp_defconfig         | 1 -
 arch/mips/configs/nlm_xlr_defconfig         | 1 -
 arch/parisc/configs/generic-64bit_defconfig | 1 -
 arch/powerpc/configs/powernv_defconfig      | 1 -
 arch/powerpc/configs/pseries_defconfig      | 1 -
 arch/s390/configs/default_defconfig         | 1 -
 arch/s390/configs/gcov_defconfig            | 1 -
 arch/s390/configs/performance_defconfig     | 1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig   | 1 -
 arch/xtensa/configs/iss_defconfig           | 1 -
 tools/testing/selftests/mount/config        | 1 -
 14 files changed, 14 deletions(-)

diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index 4c51183..be0b4fb 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -58,7 +58,6 @@ CONFIG_STMMAC_ETH=y
 # CONFIG_INPUT is not set
 # CONFIG_SERIO is not set
 # CONFIG_VT is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_8250=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 6e0f751..65a84b4 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -77,7 +77,6 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_TSC2007=m
 # CONFIG_SERIO is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
 CONFIG_SERIAL_AMBA_PL011=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index 2b74aee..df11563 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -266,7 +266,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_HW_RANDOM_TIMERIOMEM=m
 CONFIG_I2C_CHARDEV=m
 CONFIG_I2C_ALI1535=m
diff --git a/arch/mips/configs/nlm_xlp_defconfig b/arch/mips/configs/nlm_xlp_defconfig
index b496c25..5c40b48 100644
--- a/arch/mips/configs/nlm_xlp_defconfig
+++ b/arch/mips/configs/nlm_xlp_defconfig
@@ -409,7 +409,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
diff --git a/arch/mips/configs/nlm_xlr_defconfig b/arch/mips/configs/nlm_xlr_defconfig
index 8e99ad8..47a2756 100644
--- a/arch/mips/configs/nlm_xlr_defconfig
+++ b/arch/mips/configs/nlm_xlr_defconfig
@@ -347,7 +347,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIO_RAW=m
 CONFIG_VT_HW_CONSOLE_BINDING=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_N_HDLC=m
diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
index e945c08..69aa66c 100644
--- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -166,7 +166,6 @@ CONFIG_INPUT_MISC=y
 CONFIG_SERIO_SERPORT=m
 # CONFIG_HP_SDC is not set
 CONFIG_SERIO_RAW=m
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_NOZOMI=m
 # CONFIG_DEVKMEM is not set
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 0450310..2fd6bbe 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -176,7 +176,6 @@ CONFIG_PPP_SYNC_TTY=m
 CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 # CONFIG_SERIO_SERPORT is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_JSM=m
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index 36871a4..3c325ba 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -180,7 +180,6 @@ CONFIG_INPUT_EVDEV=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PCSPKR=m
 # CONFIG_SERIO_SERPORT is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_ICOM=m
diff --git a/arch/s390/configs/default_defconfig b/arch/s390/configs/default_defconfig
index d5ec71b..501e93a 100644
--- a/arch/s390/configs/default_defconfig
+++ b/arch/s390/configs/default_defconfig
@@ -453,7 +453,6 @@ CONFIG_PPP_SYNC_TTY=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
diff --git a/arch/s390/configs/gcov_defconfig b/arch/s390/configs/gcov_defconfig
index f46a351..bd34600 100644
--- a/arch/s390/configs/gcov_defconfig
+++ b/arch/s390/configs/gcov_defconfig
@@ -447,7 +447,6 @@ CONFIG_PPP_SYNC_TTY=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
diff --git a/arch/s390/configs/performance_defconfig b/arch/s390/configs/performance_defconfig
index ba0f2a5..cfb7c50 100644
--- a/arch/s390/configs/performance_defconfig
+++ b/arch/s390/configs/performance_defconfig
@@ -447,7 +447,6 @@ CONFIG_PPP_SYNC_TTY=m
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 CONFIG_LEGACY_PTY_COUNT=0
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
diff --git a/arch/sh/configs/sh7785lcr_32bit_defconfig b/arch/sh/configs/sh7785lcr_32bit_defconfig
index 9bdcf72..48df495 100644
--- a/arch/sh/configs/sh7785lcr_32bit_defconfig
+++ b/arch/sh/configs/sh7785lcr_32bit_defconfig
@@ -79,7 +79,6 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=6
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
diff --git a/arch/xtensa/configs/iss_defconfig b/arch/xtensa/configs/iss_defconfig
index 44c6764..d7b905a 100644
--- a/arch/xtensa/configs/iss_defconfig
+++ b/arch/xtensa/configs/iss_defconfig
@@ -374,7 +374,6 @@ CONFIG_DEVKMEM=y
 #
 # CONFIG_SERIAL_TIMBERDALE is not set
 CONFIG_UNIX98_PTYS=y
-# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
diff --git a/tools/testing/selftests/mount/config b/tools/testing/selftests/mount/config
index b5d881e..416bd53 100644
--- a/tools/testing/selftests/mount/config
+++ b/tools/testing/selftests/mount/config
@@ -1,2 +1 @@
 CONFIG_USER_NS=y
-CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
-- 
2.8.3
