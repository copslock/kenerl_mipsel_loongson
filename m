Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 09:55:54 +0200 (CEST)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:55355 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492554Ab0FBHz1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 09:55:27 +0200
Received: by pzk35 with SMTP id 35so909179pzk.0
        for <multiple recipients>; Wed, 02 Jun 2010 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=BVHO8b2ehr74ZUiRhTAeWNGOPS+mov5wG83wXgUeE64=;
        b=MizZ/SAOawberxP+5DIES4+YK7eO8L8LekWT8WBUkBtRdezGBSIOSSLfjtHw9eFarU
         Z41+aZbeTY/x4nPMbTOSjADnFmRU0rfAC+o/8JQsh4NLP7Gl6ebLbd9RaQt1t4Soao4k
         EqOYSQTfUahbslmksCTtUY50LI9cuCJnhFZlw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Mp13/iHC+QIpprp15NM4DyCd+8prn9KSLObXjUk9jT+F7Y0dc6GFvQq3F52nM98yUZ
         yw6McjtzrNU35PRFrHE7dloc4VwRWRMY+8bsaX9ZXCtDeeol5I2bLAxC9UdBXSqyHRUE
         GPTXwTJbaMN3233KU3dhmNcnP20ToB4N75aBg=
Received: by 10.115.66.33 with SMTP id t33mr6492006wak.199.1275465319441;
        Wed, 02 Jun 2010 00:55:19 -0700 (PDT)
Received: from stratos (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id f11sm66781301wai.23.2010.06.02.00.55.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 00:55:18 -0700 (PDT)
Date:   Wed, 2 Jun 2010 16:52:21 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH -queue 2/2] MIPS: Move VR41xx Makefile parts to their own
 Platform file
Message-Id: <20100602165221.76438760.yuasa@linux-mips.org>
In-Reply-To: <20100602165116.3d8aae62.yuasa@linux-mips.org>
References: <20100602165116.3d8aae62.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.16.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 26987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1086

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/Kbuild.platforms       |    1 +
 arch/mips/Makefile               |   33 ---------------------------------
 arch/mips/vr41xx/Platform        |   32 ++++++++++++++++++++++++++++++++
 arch/mips/vr41xx/common/Makefile |    2 --
 4 files changed, 33 insertions(+), 35 deletions(-)
 create mode 100644 arch/mips/vr41xx/Platform

diff --git a/arch/mips/Kbuild.platforms b/arch/mips/Kbuild.platforms
index 6c163c2..9b6e8d7 100644
--- a/arch/mips/Kbuild.platforms
+++ b/arch/mips/Kbuild.platforms
@@ -6,6 +6,7 @@ platforms += cobalt
 platforms += loongson
 platforms += mipssim
 platforms += sgi-ip27
+platforms += vr41xx
 
 # include the platform specific files
 include $(patsubst %, $(srctree)/arch/mips/%/Platform, $(platforms))
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 6b6dc42..6997faa 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -243,39 +243,6 @@ core-$(CONFIG_LASAT)		+= arch/mips/lasat/
 cflags-$(CONFIG_LASAT)		+= -I$(srctree)/arch/mips/include/asm/mach-lasat
 load-$(CONFIG_LASAT)		+= 0xffffffff80000000
 
-#
-# Common VR41xx
-#
-core-$(CONFIG_MACH_VR41XX)	+= arch/mips/vr41xx/common/
-cflags-$(CONFIG_MACH_VR41XX)	+= -I$(srctree)/arch/mips/include/asm/mach-vr41xx
-
-#
-# ZAO Networks Capcella (VR4131)
-#
-load-$(CONFIG_ZAO_CAPCELLA)	+= 0xffffffff80000000
-
-#
-# Victor MP-C303/304 (VR4122)
-#
-load-$(CONFIG_VICTOR_MPC30X)	+= 0xffffffff80001000
-
-#
-# IBM WorkPad z50 (VR4121)
-#
-core-$(CONFIG_IBM_WORKPAD)	+= arch/mips/vr41xx/ibm-workpad/
-load-$(CONFIG_IBM_WORKPAD)	+= 0xffffffff80004000
-
-#
-# CASIO CASSIPEIA E-55/65 (VR4111)
-#
-core-$(CONFIG_CASIO_E55)	+= arch/mips/vr41xx/casio-e55/
-load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
-
-#
-# TANBAC VR4131 multichip module(TB0225) and TANBAC VR4131DIMM(TB0229) (VR4131)
-#
-load-$(CONFIG_TANBAC_TB022X)	+= 0xffffffff80000000
-
 # NXP STB225
 core-$(CONFIG_SOC_PNX833X)		+= arch/mips/nxp/pnx833x/common/
 cflags-$(CONFIG_SOC_PNX833X)	+= -Iarch/mips/include/asm/mach-pnx833x
diff --git a/arch/mips/vr41xx/Platform b/arch/mips/vr41xx/Platform
new file mode 100644
index 0000000..b6c8d5c
--- /dev/null
+++ b/arch/mips/vr41xx/Platform
@@ -0,0 +1,32 @@
+#
+# NEC VR4100 series based machines
+#
+platform-$(CONFIG_MACH_VR41XX)	+= vr41xx/common/
+cflags-$(CONFIG_MACH_VR41XX)	+= -I$(srctree)/arch/mips/include/asm/mach-vr41xx
+
+#
+# CASIO CASSIPEIA E-55/65 (VR4111)
+#
+platform-$(CONFIG_CASIO_E55)	+= vr41xx/casio-e55/
+load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
+
+#
+# IBM WorkPad z50 (VR4121)
+#
+platform-$(CONFIG_IBM_WORKPAD)	+= vr41xx/ibm-workpad/
+load-$(CONFIG_IBM_WORKPAD)	+= 0xffffffff80004000
+
+#
+# TANBAC VR4131 multichip module(TB0225) and TANBAC VR4131DIMM(TB0229) (VR4131)
+#
+load-$(CONFIG_TANBAC_TB022X)	+= 0xffffffff80000000
+
+#
+# Victor MP-C303/304 (VR4122)
+#
+load-$(CONFIG_VICTOR_MPC30X)	+= 0xffffffff80001000
+
+#
+# ZAO Networks Capcella (VR4131)
+#
+load-$(CONFIG_ZAO_CAPCELLA)	+= 0xffffffff80000000
diff --git a/arch/mips/vr41xx/common/Makefile b/arch/mips/vr41xx/common/Makefile
index 7d5d83b..d0d84ec 100644
--- a/arch/mips/vr41xx/common/Makefile
+++ b/arch/mips/vr41xx/common/Makefile
@@ -3,5 +3,3 @@
 #
 
 obj-y	+= bcu.o cmu.o giu.o icu.o init.o irq.o pmu.o rtc.o siu.o type.o
-
-EXTRA_CFLAGS += -Werror
-- 
1.7.1
