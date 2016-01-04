Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 20:28:22 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57897 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008821AbcADT2VJA1cy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jan 2016 20:28:21 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id AEDB32804AF;
        Mon,  4 Jan 2016 20:27:50 +0100 (CET)
Received: from localhost.localdomain (p548C87BE.dip0.t-ipconnect.de [84.140.135.190])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Mon,  4 Jan 2016 20:27:50 +0100 (CET)
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: [PATCH 1/2] MAINTAINERS: add myself as Lantiq MIPS architecture maintainer
Date:   Mon,  4 Jan 2016 20:28:12 +0100
Message-Id: <1451935693-40889-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 MAINTAINERS             |    6 ++++++
 arch/mips/vdso/Makefile |    2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 233f834..a54824b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6215,6 +6215,12 @@ S:	Maintained
 F:	net/l3mdev
 F:	include/net/l3mdev.h
 
+LANTIQ MIPS ARCHITECTURE
+M:	John Crispin <blogic@openwrt.org>
+L:	linux-mips@linux-mips.org
+S:	Maintained
+F:	arch/mips/lantiq
+
 LAPB module
 L:	linux-x25@vger.kernel.org
 S:	Orphan
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index 018f8c7..1456890 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -26,7 +26,7 @@ aflags-vdso := $(ccflags-vdso) \
 # the comments on that file.
 #
 ifndef CONFIG_CPU_MIPSR6
-  ifeq ($(call ld-ifversion, -lt, 22500000, y),)
+  ifeq ($(call ld-ifversion, -lt, 22500000, y),y)
     $(warning MIPS VDSO requires binutils >= 2.25)
     obj-vdso-y := $(filter-out gettimeofday.o, $(obj-vdso-y))
     ccflags-vdso += -DDISABLE_MIPS_VDSO
-- 
1.7.10.4
