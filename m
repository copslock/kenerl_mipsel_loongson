Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 17:34:07 +0100 (CET)
Received: from conuserg-09.nifty.com ([210.131.2.76]:63682 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdKGQdmGoiG0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 17:33:42 +0100
Received: from grover.sesame (FL1-125-199-20-195.osk.mesh.ad.jp [125.199.20.195]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id vA7GVppN022965;
        Wed, 8 Nov 2017 01:31:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com vA7GVppN022965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1510072315;
        bh=hIKfXklYtJtMD08LqiOrvSbmgn+vgA0tVYd4cfa2y6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2MOuvVEq2pMVWyk4vyFIs6j73KE1Jz2CNHzyBB70vl0dnPE+5blWPdQIStPMRGiaR
         oQVI5Hq7nN4yhrEhkQxjz8h4orrIwD8YbDwx+viFdx1AayO8ZUXGWiEBc41dZbj/DD
         pOgbrgkp47FSOLyEvCDnWHARuXF0AGhCOu6cUe1JAagHLRAT1eEpnOCDfrORbthEWR
         kAXzuM/IQGXmVxUV+moxZfLCxnJqFw7FvVsZDURbchR0NCfpp1aA5N2Y3KnWAYdYl7
         aFXcQb2eXdRXNd9CrRuByK23k4mmdA6x32EWanm6qYUXDO5Y2f6ZpE2ZoORHYb2/6n
         5IOe6lkjn5k/w==
X-Nifty-SrcIP: [125.199.20.195]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] kbuild: remove all dummy assignments to obj-
Date:   Wed,  8 Nov 2017 01:31:47 +0900
Message-Id: <1510072307-16819-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510072307-16819-1-git-send-email-yamada.masahiro@socionext.com>
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60747
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

Now kbuild core scripts create empty built-in.o where necessary.
Remove "obj- := dummy.o" tricks.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-uniphier/Makefile           | 1 -
 arch/mips/boot/dts/brcm/Makefile          | 3 ---
 arch/mips/boot/dts/cavium-octeon/Makefile | 3 ---
 arch/mips/boot/dts/img/Makefile           | 3 ---
 arch/mips/boot/dts/ingenic/Makefile       | 3 ---
 arch/mips/boot/dts/lantiq/Makefile        | 3 ---
 arch/mips/boot/dts/mti/Makefile           | 3 ---
 arch/mips/boot/dts/netlogic/Makefile      | 3 ---
 arch/mips/boot/dts/ni/Makefile            | 3 ---
 arch/mips/boot/dts/pic32/Makefile         | 3 ---
 arch/mips/boot/dts/qca/Makefile           | 3 ---
 arch/mips/boot/dts/ralink/Makefile        | 3 ---
 arch/mips/boot/dts/xilfpga/Makefile       | 3 ---
 firmware/Makefile                         | 3 ---
 samples/bpf/Makefile                      | 3 ---
 samples/hidraw/Makefile                   | 3 ---
 samples/seccomp/Makefile                  | 3 ---
 samples/sockmap/Makefile                  | 3 ---
 samples/statx/Makefile                    | 3 ---
 samples/uhid/Makefile                     | 3 ---
 20 files changed, 58 deletions(-)

diff --git a/arch/arm/mach-uniphier/Makefile b/arch/arm/mach-uniphier/Makefile
index 6bea3d3..e69de29 100644
--- a/arch/arm/mach-uniphier/Makefile
+++ b/arch/arm/mach-uniphier/Makefile
@@ -1 +0,0 @@
-obj- += dummy.o
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index bacb131..fcf68a2 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -34,6 +34,3 @@ dtb-$(CONFIG_DT_NONE) += \
 	bcm97435svmb.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/cavium-octeon/Makefile b/arch/mips/boot/dts/cavium-octeon/Makefile
index e9592a9..a857b4c 100644
--- a/arch/mips/boot/dts/cavium-octeon/Makefile
+++ b/arch/mips/boot/dts/cavium-octeon/Makefile
@@ -1,6 +1,3 @@
 dtb-$(CONFIG_CAVIUM_OCTEON_SOC)	+= octeon_3xxx.dtb octeon_68xx.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/img/Makefile b/arch/mips/boot/dts/img/Makefile
index a46d773..17dedb7 100644
--- a/arch/mips/boot/dts/img/Makefile
+++ b/arch/mips/boot/dts/img/Makefile
@@ -2,6 +2,3 @@ dtb-$(CONFIG_FIT_IMAGE_FDT_BOSTON)	+= boston.dtb
 
 dtb-$(CONFIG_MACH_PISTACHIO)	+= pistachio_marduk.dtb
 obj-$(CONFIG_MACH_PISTACHIO)	+= pistachio_marduk.dtb.o
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/ingenic/Makefile b/arch/mips/boot/dts/ingenic/Makefile
index ddd0faf..f2e516c 100644
--- a/arch/mips/boot/dts/ingenic/Makefile
+++ b/arch/mips/boot/dts/ingenic/Makefile
@@ -2,6 +2,3 @@ dtb-$(CONFIG_JZ4740_QI_LB60)	+= qi_lb60.dtb
 dtb-$(CONFIG_JZ4780_CI20)	+= ci20.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
index 586b1c9..fed59e0 100644
--- a/arch/mips/boot/dts/lantiq/Makefile
+++ b/arch/mips/boot/dts/lantiq/Makefile
@@ -1,6 +1,3 @@
 dtb-$(CONFIG_DT_EASY50712)	+= easy50712.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
index faf7ac4..35cf12b 100644
--- a/arch/mips/boot/dts/mti/Makefile
+++ b/arch/mips/boot/dts/mti/Makefile
@@ -2,6 +2,3 @@ dtb-$(CONFIG_MIPS_MALTA)	+= malta.dtb
 dtb-$(CONFIG_LEGACY_BOARD_SEAD3)	+= sead3.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/netlogic/Makefile b/arch/mips/boot/dts/netlogic/Makefile
index 77ffb30..84a38eb 100644
--- a/arch/mips/boot/dts/netlogic/Makefile
+++ b/arch/mips/boot/dts/netlogic/Makefile
@@ -5,6 +5,3 @@ dtb-$(CONFIG_DT_XLP_GVP)	+= xlp_gvp.dtb
 dtb-$(CONFIG_DT_XLP_RVP)	+= xlp_rvp.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/ni/Makefile b/arch/mips/boot/dts/ni/Makefile
index 6cd9c60..9e2c9fa 100644
--- a/arch/mips/boot/dts/ni/Makefile
+++ b/arch/mips/boot/dts/ni/Makefile
@@ -1,4 +1 @@
 dtb-$(CONFIG_FIT_IMAGE_FDT_NI169445)	+= 169445.dtb
-
-# Force kbuild to make empty built-in.o if necessary
-obj-					+= dummy.o
diff --git a/arch/mips/boot/dts/pic32/Makefile b/arch/mips/boot/dts/pic32/Makefile
index 5a08e48..6ecc249 100644
--- a/arch/mips/boot/dts/pic32/Makefile
+++ b/arch/mips/boot/dts/pic32/Makefile
@@ -4,6 +4,3 @@ dtb-$(CONFIG_DTB_PIC32_NONE)		+= \
 					pic32mzda_sk.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/qca/Makefile b/arch/mips/boot/dts/qca/Makefile
index 181db5d..ad6429b 100644
--- a/arch/mips/boot/dts/qca/Makefile
+++ b/arch/mips/boot/dts/qca/Makefile
@@ -4,6 +4,3 @@ dtb-$(CONFIG_ATH79)			+= ar9331_dpt_module.dtb
 dtb-$(CONFIG_ATH79)			+= ar9331_dragino_ms14.dtb
 dtb-$(CONFIG_ATH79)			+= ar9331_omega.dtb
 dtb-$(CONFIG_ATH79)			+= ar9331_tl_mr3020.dtb
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
index 7b64654..baaea4a 100644
--- a/arch/mips/boot/dts/ralink/Makefile
+++ b/arch/mips/boot/dts/ralink/Makefile
@@ -6,6 +6,3 @@ dtb-$(CONFIG_DTB_OMEGA2P)	+= omega2p.dtb
 dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/arch/mips/boot/dts/xilfpga/Makefile b/arch/mips/boot/dts/xilfpga/Makefile
index 77c8096..53f755f 100644
--- a/arch/mips/boot/dts/xilfpga/Makefile
+++ b/arch/mips/boot/dts/xilfpga/Makefile
@@ -1,6 +1,3 @@
 dtb-$(CONFIG_XILFPGA_NEXYS4DDR)	+= nexys4ddr.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
-
-# Force kbuild to make empty built-in.o if necessary
-obj-				+= dummy.o
diff --git a/firmware/Makefile b/firmware/Makefile
index fa08088..6524be1 100644
--- a/firmware/Makefile
+++ b/firmware/Makefile
@@ -58,6 +58,3 @@ endif
 
 targets := $(patsubst $(obj)/%,%, \
                                 $(shell find $(obj) -name \*.gen.S 2>/dev/null))
-# Without this, built-in.o won't be created when it's empty, and the
-# final vmlinux link will fail.
-obj- := dummy
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index cf17c79..4ea6f75 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -1,6 +1,3 @@
-# kbuild trick to avoid linker error. Can be omitted if a module is built.
-obj- := dummy.o
-
 # List of programs to build
 hostprogs-y := test_lru_dist
 hostprogs-y += sock_example
diff --git a/samples/hidraw/Makefile b/samples/hidraw/Makefile
index a9ab961..329da9c 100644
--- a/samples/hidraw/Makefile
+++ b/samples/hidraw/Makefile
@@ -1,6 +1,3 @@
-# kbuild trick to avoid linker error. Can be omitted if a module is built.
-obj- := dummy.o
-
 # List of programs to build
 hostprogs-y := hid-example
 
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index bf7cc6b..5c6baac 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -1,6 +1,3 @@
-# kbuild trick to avoid linker error. Can be omitted if a module is built.
-obj- := dummy.o
-
 hostprogs-$(CONFIG_SAMPLE_SECCOMP) := bpf-fancy dropper bpf-direct
 
 HOSTCFLAGS_bpf-fancy.o += -I$(objtree)/usr/include
diff --git a/samples/sockmap/Makefile b/samples/sockmap/Makefile
index 9291ab8..73f1da4 100644
--- a/samples/sockmap/Makefile
+++ b/samples/sockmap/Makefile
@@ -1,6 +1,3 @@
-# kbuild trick to avoid linker error. Can be omitted if a module is built.
-obj- := dummy.o
-
 # List of programs to build
 hostprogs-y := sockmap
 
diff --git a/samples/statx/Makefile b/samples/statx/Makefile
index 1f80a3d..59df7c2 100644
--- a/samples/statx/Makefile
+++ b/samples/statx/Makefile
@@ -1,6 +1,3 @@
-# kbuild trick to avoid linker error. Can be omitted if a module is built.
-obj- := dummy.o
-
 # List of programs to build
 hostprogs-$(CONFIG_SAMPLE_STATX) := test-statx
 
diff --git a/samples/uhid/Makefile b/samples/uhid/Makefile
index c95a696..8d7fd61 100644
--- a/samples/uhid/Makefile
+++ b/samples/uhid/Makefile
@@ -1,6 +1,3 @@
-# kbuild trick to avoid linker error. Can be omitted if a module is built.
-obj- := dummy.o
-
 # List of programs to build
 hostprogs-y := uhid-example
 
-- 
2.7.4
