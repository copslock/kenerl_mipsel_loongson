Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 15:09:00 +0000 (GMT)
Received: from crystal.sipsolutions.net ([195.210.38.204]:174 "EHLO
	sipsolutions.net") by ftp.linux-mips.org with ESMTP
	id S28574134AbXKGPIv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Nov 2007 15:08:51 +0000
Received: from [131.234.77.13]
	by sipsolutions.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <johannes@sipsolutions.net>)
	id 1IpmVu-0004Vy-Ed; Wed, 07 Nov 2007 15:08:18 +0000
Message-Id: <20071107135849.207149000@sipsolutions.net>
References: <20071107135758.100171000@sipsolutions.net>
User-Agent: quilt/0.46-1
Date:	Wed, 07 Nov 2007 14:58:00 +0100
From:	Johannes Berg <johannes@sipsolutions.net>
To:	linux-pm@lists.linux-foundation.org
Cc:	"Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Scott Wood <scottwood@freescale.com>,
	David Howells <dhowells@redhat.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Paul Mundt <lethal@linux-sh.org>,
	Bryan Wu <bryan.wu@analog.com>,
	Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH (2.6.25) 2/2] suspend: clean up Kconfig
Content-Disposition: inline; filename=026-suspend-kconfig-cleanup.patch
Mime-Version: 1.0
X-Mailer: Evolution 2.12.0 
Content-Transfer-Encoding: 7bit
Return-Path: <johannes@sipsolutions.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johannes@sipsolutions.net
Precedence: bulk
X-list: linux-mips

This cleans up the suspend Kconfig and removes the need to
declare centrally which architectures support suspend. All
architectures that currently support suspend are modified
accordingly.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.linux-foundation.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Scott Wood <scottwood@freescale.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Bryan Wu <bryan.wu@analog.com>
Cc: Russell King <rmk@arm.linux.org.uk>
---
Architecture maintainers should evaluate whether their
ARCH_SUSPEND_POSSIBLE symbol should be set only under
stricter circumstances like I've done for powerpc.

Always setting it is not usually a problem, however, since the
infrastructure is only available for use after suspend_set_ops().

 arch/arm/Kconfig      |    3 +++
 arch/blackfin/Kconfig |    4 ++++
 arch/frv/Kconfig      |    5 +++++
 arch/i386/Kconfig     |    4 ++++
 arch/mips/Kconfig     |    4 ++++
 arch/powerpc/Kconfig  |    4 ++++
 arch/sh/Kconfig       |    4 ++++
 arch/x86_64/Kconfig   |    3 +++
 kernel/power/Kconfig  |   21 +++------------------
 9 files changed, 34 insertions(+), 18 deletions(-)

--- everything.orig/arch/i386/Kconfig	2007-11-07 14:45:28.591544215 +0100
+++ everything/arch/i386/Kconfig	2007-11-07 14:45:28.631515461 +0100
@@ -1323,3 +1323,7 @@ config KTIME_SCALAR
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 	depends on !SMP || !X86_VOYAGER
+
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !X86_VOYAGER
--- everything.orig/arch/x86_64/Kconfig	2007-11-07 14:45:28.591544215 +0100
+++ everything/arch/x86_64/Kconfig	2007-11-07 14:45:28.631515461 +0100
@@ -716,6 +716,9 @@ menu "Power management options"
 
 source kernel/power/Kconfig
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+
 config ARCH_HIBERNATION_POSSIBLE
 	def_bool y
 
--- everything.orig/kernel/power/Kconfig	2007-11-07 14:45:28.591544215 +0100
+++ everything/kernel/power/Kconfig	2007-11-07 14:45:28.641531465 +0100
@@ -64,7 +64,7 @@ config PM_TRACE
 config PM_SLEEP_SMP
 	bool
 	depends on SMP
-	depends on SUSPEND_SMP_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
+	depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
 	depends on PM_SLEEP
 	select HOTPLUG_CPU
 	default y
@@ -74,29 +74,14 @@ config PM_SLEEP
 	depends on SUSPEND || HIBERNATION
 	default y
 
-config SUSPEND_UP_POSSIBLE
-	bool
-	depends on (X86 && !X86_VOYAGER) || PPC || ARM || BLACKFIN || MIPS \
-		   || SUPERH || FRV
-	depends on !SMP
-	default y
-
-config SUSPEND_SMP_POSSIBLE
-	bool
-	depends on (X86 && !X86_VOYAGER) \
-		   || (PPC && (PPC_PSERIES || PPC_PMAC)) || ARM
-	depends on SMP
-	default y
-
 config SUSPEND
 	bool "Suspend to RAM and standby"
-	depends on PM
-	depends on SUSPEND_UP_POSSIBLE || SUSPEND_SMP_POSSIBLE
+	depends on PM && ARCH_SUSPEND_POSSIBLE
 	default y
 	---help---
 	  Allow the system to enter sleep states in which main memory is
 	  powered and thus its contents are preserved, such as the
-	  suspend-to-RAM state (i.e. the ACPI S3 state).
+	  suspend-to-RAM state (e.g. the ACPI S3 state).
 
 config HIBERNATION
 	bool "Hibernation (aka 'suspend to disk')"
--- everything.orig/arch/blackfin/Kconfig	2007-11-07 14:44:55.551521971 +0100
+++ everything/arch/blackfin/Kconfig	2007-11-07 14:45:28.641531465 +0100
@@ -993,6 +993,10 @@ endmenu
 menu "Power management options"
 source "kernel/power/Kconfig"
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 choice
 	prompt "Select PM Wakeup Event Source"
 	default PM_WAKEUP_GPIO_BY_SIC_IWR
--- everything.orig/arch/arm/Kconfig	2007-11-07 14:44:55.651522948 +0100
+++ everything/arch/arm/Kconfig	2007-11-07 14:45:28.641531465 +0100
@@ -977,6 +977,9 @@ menu "Power management options"
 
 source "kernel/power/Kconfig"
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+
 endmenu
 
 source "net/Kconfig"
--- everything.orig/arch/mips/Kconfig	2007-11-07 14:44:55.701522460 +0100
+++ everything/arch/mips/Kconfig	2007-11-07 14:45:28.641531465 +0100
@@ -1999,6 +1999,10 @@ endmenu
 
 menu "Power management options"
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 source "kernel/power/Kconfig"
 
 endmenu
--- everything.orig/arch/sh/Kconfig	2007-11-07 14:44:55.801520344 +0100
+++ everything/arch/sh/Kconfig	2007-11-07 14:45:28.651528536 +0100
@@ -748,6 +748,10 @@ endmenu
 menu "Power management options (EXPERIMENTAL)"
 depends on EXPERIMENTAL && SYS_SUPPORTS_PM
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 source kernel/power/Kconfig
 
 endmenu
--- everything.orig/arch/frv/Kconfig	2007-11-07 14:44:55.861520941 +0100
+++ everything/arch/frv/Kconfig	2007-11-07 14:45:28.651528536 +0100
@@ -357,6 +357,11 @@ source "drivers/pcmcia/Kconfig"
 #	  should probably wait a while.
 
 menu "Power management options"
+
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on !SMP
+
 source kernel/power/Kconfig
 endmenu
 
--- everything.orig/arch/powerpc/Kconfig	2007-11-07 14:45:28.591544215 +0100
+++ everything/arch/powerpc/Kconfig	2007-11-07 14:45:28.651528536 +0100
@@ -155,6 +155,10 @@ config ARCH_HIBERNATION_POSSIBLE
 	depends on (PPC64 && HIBERNATE_64) || (PPC32 && HIBERNATE_32)
 	default y
 
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200
+
 config PPC_DCR_NATIVE
 	bool
 	default n

-- 
