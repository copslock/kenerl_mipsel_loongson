Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2008 15:07:35 +0000 (GMT)
Received: from smtp15.dti.ne.jp ([202.216.231.190]:54498 "EHLO
	smtp15.dti.ne.jp") by ftp.linux-mips.org with ESMTP
	id S22509297AbYJ0PH0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Oct 2008 15:07:26 +0000
Received: from [192.168.1.3] (PPPa1553.tokyo-ip.dti.ne.jp [210.170.207.53]) by smtp15.dti.ne.jp (3.11s) with ESMTP AUTH id m9RF7Jc1000347;Tue, 28 Oct 2008 00:07:21 +0900 (JST)
Message-ID: <4905D927.3050005@ruby.dti.ne.jp>
Date:	Tue, 28 Oct 2008 00:07:19 +0900
From:	Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	shinya.kuribayashi@necel.com
Subject: [PATCH] MIPS: EMMA2RH: Fix incorrect header references
References: <4900A510.3000101@ruby.dti.ne.jp> <4900A69C.7060208@ruby.dti.ne.jp>
In-Reply-To: <4900A69C.7060208@ruby.dti.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <skuribay@ruby.dti.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: skuribay@ruby.dti.ne.jp
Precedence: bulk
X-list: linux-mips

Now we have <asm/emma/emma2rh.h> as a new EMMA2RH header place.  This
patch will fix all of the remaining <asm/emma2rh/emma2rh.h> references.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 arch/mips/include/asm/emma/emma2rh.h |    2 +-
 arch/mips/pci/fixup-emma2rh.c        |    2 +-
 arch/mips/pci/ops-emma2rh.c          |    2 +-
 arch/mips/pci/pci-emma2rh.c          |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/emma/emma2rh.h b/arch/mips/include/asm/emma/emma2rh.h
index cd84850..30aea91 100644
--- a/arch/mips/include/asm/emma/emma2rh.h
+++ b/arch/mips/include/asm/emma/emma2rh.h
@@ -1,5 +1,5 @@
 /*
- *  include/asm-mips/emma2rh/emma2rh.h
+ *  arch/mips/include/asm/emma/emma2rh.h
  *      This file is EMMA2RH common header.
  *
  *  Copyright (C) NEC Electronics Corporation 2005-2006
diff --git a/arch/mips/pci/fixup-emma2rh.c b/arch/mips/pci/fixup-emma2rh.c
index 846eae9..fba5aad 100644
--- a/arch/mips/pci/fixup-emma2rh.c
+++ b/arch/mips/pci/fixup-emma2rh.c
@@ -30,7 +30,7 @@
 
 #include <asm/bootinfo.h>
 
-#include <asm/emma2rh/emma2rh.h>
+#include <asm/emma/emma2rh.h>
 
 #define EMMA2RH_PCI_HOST_SLOT 0x09
 #define EMMA2RH_USB_SLOT 0x03
diff --git a/arch/mips/pci/ops-emma2rh.c b/arch/mips/pci/ops-emma2rh.c
index d31bfc6..5947a70 100644
--- a/arch/mips/pci/ops-emma2rh.c
+++ b/arch/mips/pci/ops-emma2rh.c
@@ -30,7 +30,7 @@
 #include <asm/addrspace.h>
 #include <asm/debug.h>
 
-#include <asm/emma2rh/emma2rh.h>
+#include <asm/emma/emma2rh.h>
 
 #define RTABORT (0x1<<9)
 #define RMABORT (0x1<<10)
diff --git a/arch/mips/pci/pci-emma2rh.c b/arch/mips/pci/pci-emma2rh.c
index 772e283..2df4190 100644
--- a/arch/mips/pci/pci-emma2rh.c
+++ b/arch/mips/pci/pci-emma2rh.c
@@ -30,7 +30,7 @@
 
 #include <asm/bootinfo.h>
 
-#include <asm/emma2rh/emma2rh.h>
+#include <asm/emma/emma2rh.h>
 
 static struct resource pci_io_resource = {
 	.name = "pci IO space",
