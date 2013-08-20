Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Aug 2013 21:39:01 +0200 (CEST)
Received: from gerard.telenet-ops.be ([195.130.132.48]:51654 "EHLO
        gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6828766Ab3HTTi6jIYTN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Aug 2013 21:38:58 +0200
Received: from ayla.of.borg ([84.193.72.141])
        by gerard.telenet-ops.be with bizsmtp
        id F7eg1m01G32ts5g0H7egjx; Tue, 20 Aug 2013 21:38:56 +0200
Received: from geert by ayla.of.borg with local (Exim 4.76)
        (envelope-from <geert@linux-m68k.org>)
        id 1VBrkm-0004R7-Ql; Tue, 20 Aug 2013 21:38:08 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Kconfig: Remove hotplug enable hints in CONFIG_KEXEC help texts
Date:   Tue, 20 Aug 2013 21:38:03 +0200
Message-Id: <1377027483-17025-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

commit 40b313608ad4ea655addd2ec6cdd106477ae8e15 ("Finally eradicate
CONFIG_HOTPLUG") removed remaining references to CONFIG_HOTPLUG, but missed
a few plain English references in the CONFIG_KEXEC help texts.

Remove them, too.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/arm/Kconfig     |    3 +--
 arch/ia64/Kconfig    |    6 +++---
 arch/mips/Kconfig    |    6 +++---
 arch/powerpc/Kconfig |    6 +++---
 arch/sh/Kconfig      |    6 +++---
 arch/x86/Kconfig     |    6 +++---
 6 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43594d5..cd5c1c9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2064,8 +2064,7 @@ config KEXEC
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  It may help to enable device hotplugging
-	  support.
+	  initially work for you.
 
 config ATAGS_PROC
 	bool "Export atags in procfs"
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 5a768ad..b36370d 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -565,9 +565,9 @@ config KEXEC
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  It may help to enable device hotplugging
-	  support.  As of this writing the exact hardware interface is
-	  strongly in flux, so no good recommendation can be made.
+	  initially work for you.  As of this writing the exact hardware
+	  interface is strongly in flux, so no good recommendation can be
+	  made.
 
 config CRASH_DUMP
 	  bool "kernel crash dumps"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e12764c..dccd7ce 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2305,9 +2305,9 @@ config KEXEC
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  It may help to enable device hotplugging
-	  support.  As of this writing the exact hardware interface is
-	  strongly in flux, so no good recommendation can be made.
+	  initially work for you.  As of this writing the exact hardware
+	  interface is strongly in flux, so no good recommendation can be
+	  made.
 
 config CRASH_DUMP
 	  bool "Kernel crash dumps"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dbd9d3c..cc61418 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -369,9 +369,9 @@ config KEXEC
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  It may help to enable device hotplugging
-	  support.  As of this writing the exact hardware interface is
-	  strongly in flux, so no good recommendation can be made.
+	  initially work for you.  As of this writing the exact hardware
+	  interface is strongly in flux, so no good recommendation can be
+	  made.
 
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 1020dd8..1018ed3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -643,9 +643,9 @@ config KEXEC
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  It may help to enable device hotplugging
-	  support.  As of this writing the exact hardware interface is
-	  strongly in flux, so no good recommendation can be made.
+	  initially work for you.  As of this writing the exact hardware
+	  interface is strongly in flux, so no good recommendation can be
+	  made.
 
 config CRASH_DUMP
 	bool "kernel crash dumps (EXPERIMENTAL)"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b32ebf9..6ace5de 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1627,9 +1627,9 @@ config KEXEC
 
 	  It is an ongoing process to be certain the hardware in a machine
 	  is properly shutdown, so do not be surprised if this code does not
-	  initially work for you.  It may help to enable device hotplugging
-	  support.  As of this writing the exact hardware interface is
-	  strongly in flux, so no good recommendation can be made.
+	  initially work for you.  As of this writing the exact hardware
+	  interface is strongly in flux, so no good recommendation can be
+	  made.
 
 config CRASH_DUMP
 	bool "kernel crash dumps"
-- 
1.7.9.5
