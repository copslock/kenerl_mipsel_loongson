Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Oct 2008 14:56:20 +0100 (BST)
Received: from smtp15.dti.ne.jp ([202.216.231.190]:12990 "EHLO
	smtp15.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S21286933AbYJLN4S (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Oct 2008 14:56:18 +0100
Received: from [192.168.1.3] (PPPa2341.tokyo-ip.dti.ne.jp [61.195.18.91]) by smtp15.dti.ne.jp (3.11s) with ESMTP AUTH id m9CDuBrE002495 for <linux-mips@linux-mips.org>; Sun, 12 Oct 2008 22:56:15 +0900 (JST)
Message-ID: <48F201FB.90303@ruby.dti.ne.jp>
Date:	Sun, 12 Oct 2008 22:56:11 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS] Kill unused <asm/debug.h> inclusions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
---
Hi,

noticed while cleaning up the EMMA2RH port. Build tested wih emma2rh,
rb532 and pnx8550-stb810.

Thanks,

  Shinya

 arch/mips/emma2rh/common/irq.c        |    1 -
 arch/mips/emma2rh/common/prom.c       |    1 -
 arch/mips/emma2rh/markeins/platform.c |    1 -
 arch/mips/pci/fixup-emma2rh.c         |    1 -
 arch/mips/pci/ops-pnx8550.c           |    2 --
 arch/mips/pci/pci-emma2rh.c           |    1 -
 arch/mips/rb532/time.c                |    1 -
 7 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/mips/emma2rh/common/irq.c b/arch/mips/emma2rh/common/irq.c
index d956047..91cbd95 100644
--- a/arch/mips/emma2rh/common/irq.c
+++ b/arch/mips/emma2rh/common/irq.c
@@ -29,7 +29,6 @@
 
 #include <asm/system.h>
 #include <asm/mipsregs.h>
-#include <asm/debug.h>
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 
diff --git a/arch/mips/emma2rh/common/prom.c b/arch/mips/emma2rh/common/prom.c
index 5e92b3a..e14a2e3 100644
--- a/arch/mips/emma2rh/common/prom.c
+++ b/arch/mips/emma2rh/common/prom.c
@@ -30,7 +30,6 @@
 #include <asm/addrspace.h>
 #include <asm/bootinfo.h>
 #include <asm/emma2rh/emma2rh.h>
-#include <asm/debug.h>
 
 const char *get_system_type(void)
 {
diff --git a/arch/mips/emma2rh/markeins/platform.c b/arch/mips/emma2rh/markeins/platform.c
index d70627d..fb9cda2 100644
--- a/arch/mips/emma2rh/markeins/platform.c
+++ b/arch/mips/emma2rh/markeins/platform.c
@@ -35,7 +35,6 @@
 #include <asm/irq.h>
 #include <asm/reboot.h>
 #include <asm/traps.h>
-#include <asm/debug.h>
 
 #include <asm/emma2rh/emma2rh.h>
 
diff --git a/arch/mips/pci/fixup-emma2rh.c b/arch/mips/pci/fixup-emma2rh.c
index a270589..846eae9 100644
--- a/arch/mips/pci/fixup-emma2rh.c
+++ b/arch/mips/pci/fixup-emma2rh.c
@@ -29,7 +29,6 @@
 #include <linux/pci.h>
 
 #include <asm/bootinfo.h>
-#include <asm/debug.h>
 
 #include <asm/emma2rh/emma2rh.h>
 
diff --git a/arch/mips/pci/ops-pnx8550.c b/arch/mips/pci/ops-pnx8550.c
index 0e160d9..1e6213f 100644
--- a/arch/mips/pci/ops-pnx8550.c
+++ b/arch/mips/pci/ops-pnx8550.c
@@ -29,8 +29,6 @@
 
 #include <asm/mach-pnx8550/pci.h>
 #include <asm/mach-pnx8550/glb.h>
-#include <asm/debug.h>
-
 
 static inline void clear_status(void)
 {
diff --git a/arch/mips/pci/pci-emma2rh.c b/arch/mips/pci/pci-emma2rh.c
index d99591a..772e283 100644
--- a/arch/mips/pci/pci-emma2rh.c
+++ b/arch/mips/pci/pci-emma2rh.c
@@ -29,7 +29,6 @@
 #include <linux/pci.h>
 
 #include <asm/bootinfo.h>
-#include <asm/debug.h>
 
 #include <asm/emma2rh/emma2rh.h>
 
diff --git a/arch/mips/rb532/time.c b/arch/mips/rb532/time.c
index 8e7a468..1377d59 100644
--- a/arch/mips/rb532/time.c
+++ b/arch/mips/rb532/time.c
@@ -28,7 +28,6 @@
 #include <linux/timex.h>
 
 #include <asm/mipsregs.h>
-#include <asm/debug.h>
 #include <asm/time.h>
 #include <asm/mach-rc32434/rc32434.h>
 
