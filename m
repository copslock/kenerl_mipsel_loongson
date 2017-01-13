Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jan 2017 11:49:06 +0100 (CET)
Received: from host.76.145.23.62.rev.coltfrance.com ([62.23.145.76]:51398 "EHLO
        proxy.6wind.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992183AbdAMKrQAP4P- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jan 2017 11:47:16 +0100
Received: from elsass.dev.6wind.com (unknown [10.16.0.149])
        by proxy.6wind.com (Postfix) with ESMTPS id 2284C257AE;
        Fri, 13 Jan 2017 11:46:56 +0100 (CET)
Received: from root by elsass.dev.6wind.com with local (Exim 4.84_2)
        (envelope-from <root@elsass.dev.6wind.com>)
        id 1cRzNl-0002qH-Eq; Fri, 13 Jan 2017 11:46:53 +0100
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
To:     arnd@arndb.de
Cc:     mmarek@suse.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-nfs@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
        fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
        linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk,
        bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch,
        rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de,
        hch@infradead.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH v3 6/8] Makefile.headersinst: remove destination-y option
Date:   Fri, 13 Jan 2017 11:46:44 +0100
Message-Id: <1484304406-10820-7-git-send-email-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
References: <3131144.4Ej3KFWRbz@wuerfel>
 <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
Return-Path: <root@6wind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.dichtel@6wind.com
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

This option was added in commit c7bb349e7c25 ("kbuild: introduce destination-y
for exported headers") but never used in-tree.

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 Documentation/kbuild/makefiles.txt | 23 ++++-------------------
 scripts/Makefile.headersinst       |  2 +-
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 9b9c4797fc55..37b525d329ae 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -46,9 +46,8 @@ This document describes the Linux kernel Makefiles.
 	=== 7 Kbuild syntax for exported headers
 		--- 7.1 header-y
 		--- 7.2 genhdr-y
-		--- 7.3 destination-y
-		--- 7.4 generic-y
-		--- 7.5 generated-y
+		--- 7.3 generic-y
+		--- 7.4 generated-y
 
 	=== 8 Kbuild Variables
 	=== 9 Makefile language
@@ -1295,21 +1294,7 @@ See subsequent chapter for the syntax of the Kbuild file.
 			#include/linux/Kbuild
 			genhdr-y += version.h
 
-	--- 7.3 destination-y
-
-	When an architecture has a set of exported headers that needs to be
-	exported to a different directory destination-y is used.
-	destination-y specifies the destination directory for all exported
-	headers in the file where it is present.
-
-		Example:
-			#arch/xtensa/platforms/s6105/include/platform/Kbuild
-			destination-y := include/linux
-
-	In the example above all exported headers in the Kbuild file
-	will be located in the directory "include/linux" when exported.
-
-	--- 7.4 generic-y
+	--- 7.3 generic-y
 
 	If an architecture uses a verbatim copy of a header from
 	include/asm-generic then this is listed in the file
@@ -1336,7 +1321,7 @@ See subsequent chapter for the syntax of the Kbuild file.
 		Example: termios.h
 			#include <asm-generic/termios.h>
 
-	--- 7.5 generated-y
+	--- 7.4 generated-y
 
 	If an architecture generates other header files alongside generic-y
 	wrappers, and not included in genhdr-y, then generated-y specifies
diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 3e20d03432d2..876b42cfede4 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -14,7 +14,7 @@ kbuild-file := $(srctree)/$(obj)/Kbuild
 include $(kbuild-file)
 
 # called may set destination dir (when installing to asm/)
-_dst := $(if $(destination-y),$(destination-y),$(if $(dst),$(dst),$(obj)))
+_dst := $(if $(dst),$(dst),$(obj))
 
 old-kbuild-file := $(srctree)/$(subst uapi/,,$(obj))/Kbuild
 ifneq ($(wildcard $(old-kbuild-file)),)
-- 
2.8.1
