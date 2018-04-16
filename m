Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Apr 2018 17:43:50 +0200 (CEST)
Received: from conuserg-12.nifty.com ([210.131.2.79]:47434 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeDPPnnlKogm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Apr 2018 17:43:43 +0200
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id w3GFfg6B014506;
        Tue, 17 Apr 2018 00:41:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w3GFfg6B014506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1523893303;
        bh=xYSM9Qb1MQG/0LnCI922LcJpXJR80XGJBen3B9H/aNI=;
        h=From:To:Cc:Subject:Date:From;
        b=w8KRbQG8CK0fXUMwXl2p9PAkC/n7HLdPop7uPMTGSNnbR1VIwspogRwmmfeRsIzrz
         YiwidHMsFyubqPd/4LIUwWVlciKIh9KjkTCeewke+Wb7KRzC++9HDDjIm19LMHUQjs
         pgvEpavTq5pLKQCY67H74GJwVUn2wpZaGEdoweA2QEE2Wo+T4CvJuL1wBvUODgNJtJ
         /yGNF3EzFnLiC4/l7J6sI05eAURBAxleaCMCqakBlbhD5OZJQQyWnrHuWZG44aOe2K
         duCcWwk04ruHeTlc1zzKUowcgK2HeCP9NiRjqoxoM6HGXGoE0QE2gjxOKUbGpJkdpy
         nB5GLgWOGoIFQ==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Cercueil <paul@crapouillou.net>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Mathieu Malaterre <malat@debian.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Harvey Hunt <harvey.hunt@imgtec.com>
Subject: [PATCH] MIPS: dts: avoid unneeded built-in.a creation in vendor DTS directories
Date:   Tue, 17 Apr 2018 00:41:30 +0900
Message-Id: <1523893290-7958-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

arch/mips/boot/dts/Makefile collects objects from sub-directories
into built-in.a only when CONFIG_BUILTIN_DTB is enabled.  Reflect
it also to the sub-directory Makefiles.  This suppresses unneeded
built-in.a creation in arch/mips/boot/dts/*/ directories.

While I am here, I replaced $(patsubst %.dtb, %.dtb.o, $(dtb-y))
with $(addsuffix .o, $(dtb-y)) to simplify the code a little bit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/mips/boot/dts/brcm/Makefile          | 2 +-
 arch/mips/boot/dts/cavium-octeon/Makefile | 2 +-
 arch/mips/boot/dts/ingenic/Makefile       | 2 +-
 arch/mips/boot/dts/lantiq/Makefile        | 2 +-
 arch/mips/boot/dts/mscc/Makefile          | 2 +-
 arch/mips/boot/dts/mti/Makefile           | 2 +-
 arch/mips/boot/dts/netlogic/Makefile      | 2 +-
 arch/mips/boot/dts/pic32/Makefile         | 2 +-
 arch/mips/boot/dts/ralink/Makefile        | 2 +-
 arch/mips/boot/dts/xilfpga/Makefile       | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index d8787c9..d85f446 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -34,4 +34,4 @@ dtb-$(CONFIG_DT_NONE) += \
 	bcm97425svmb.dtb \
 	bcm97435svmb.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/cavium-octeon/Makefile b/arch/mips/boot/dts/cavium-octeon/Makefile
index 24a8efc..17aef35 100644
--- a/arch/mips/boot/dts/cavium-octeon/Makefile
+++ b/arch/mips/boot/dts/cavium-octeon/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_CAVIUM_OCTEON_SOC)	+= octeon_3xxx.dtb octeon_68xx.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/ingenic/Makefile b/arch/mips/boot/dts/ingenic/Makefile
index 5b1361a..9cc4844 100644
--- a/arch/mips/boot/dts/ingenic/Makefile
+++ b/arch/mips/boot/dts/ingenic/Makefile
@@ -3,4 +3,4 @@ dtb-$(CONFIG_JZ4740_QI_LB60)	+= qi_lb60.dtb
 dtb-$(CONFIG_JZ4770_GCW0)	+= gcw0.dtb
 dtb-$(CONFIG_JZ4780_CI20)	+= ci20.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
index 51ab9c1..f5dfc06 100644
--- a/arch/mips/boot/dts/lantiq/Makefile
+++ b/arch/mips/boot/dts/lantiq/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_DT_EASY50712)	+= easy50712.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
index c511645..3c6aed9 100644
--- a/arch/mips/boot/dts/mscc/Makefile
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -1,3 +1,3 @@
 dtb-$(CONFIG_LEGACY_BOARD_OCELOT)	+= ocelot_pcb123.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
index 3508720..b5f7426 100644
--- a/arch/mips/boot/dts/mti/Makefile
+++ b/arch/mips/boot/dts/mti/Makefile
@@ -2,4 +2,4 @@
 dtb-$(CONFIG_MIPS_MALTA)	+= malta.dtb
 dtb-$(CONFIG_LEGACY_BOARD_SEAD3)	+= sead3.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/netlogic/Makefile b/arch/mips/boot/dts/netlogic/Makefile
index d630b27..45af422 100644
--- a/arch/mips/boot/dts/netlogic/Makefile
+++ b/arch/mips/boot/dts/netlogic/Makefile
@@ -5,4 +5,4 @@ dtb-$(CONFIG_DT_XLP_FVP)	+= xlp_fvp.dtb
 dtb-$(CONFIG_DT_XLP_GVP)	+= xlp_gvp.dtb
 dtb-$(CONFIG_DT_XLP_RVP)	+= xlp_rvp.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/pic32/Makefile b/arch/mips/boot/dts/pic32/Makefile
index ba9bcef..fb57f36 100644
--- a/arch/mips/boot/dts/pic32/Makefile
+++ b/arch/mips/boot/dts/pic32/Makefile
@@ -4,4 +4,4 @@ dtb-$(CONFIG_DTB_PIC32_MZDA_SK)		+= pic32mzda_sk.dtb
 dtb-$(CONFIG_DTB_PIC32_NONE)		+= \
 					pic32mzda_sk.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
index 94bee5b..6c26dfa 100644
--- a/arch/mips/boot/dts/ralink/Makefile
+++ b/arch/mips/boot/dts/ralink/Makefile
@@ -6,4 +6,4 @@ dtb-$(CONFIG_DTB_MT7620A_EVAL)	+= mt7620a_eval.dtb
 dtb-$(CONFIG_DTB_OMEGA2P)	+= omega2p.dtb
 dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/xilfpga/Makefile b/arch/mips/boot/dts/xilfpga/Makefile
index 9987e0e3..285973f 100644
--- a/arch/mips/boot/dts/xilfpga/Makefile
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= nexys4ddr.dtb
 
-obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
+obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
-- 
2.7.4
