Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 03:59:29 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:19192 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225240AbUJUC7Z>; Thu, 21 Oct 2004 03:59:25 +0100
Received: from prometheus.mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 4B417184F7; Wed, 20 Oct 2004 19:59:23 -0700 (PDT)
Subject: [PATCH]MIPS64 RAMDISK in 2.6
From: Manish Lachwani <mlachwani@mvista.com>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Content-Type: text/plain
Organization: 
Message-Id: <1098327563.4266.26.camel@prometheus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Oct 2004 19:59:23 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello !

I needed the following patch to get the RAMDISK support working in
MIPS64. Tested on the Broadcom SWARM. Please review

Thanks
Manish Lachwani

--- arch/mips/ramdisk/Makefile.orig	2004-10-20 19:40:12.000000000 -0700
+++ arch/mips/ramdisk/Makefile	2004-10-20 19:45:27.000000000 -0700
@@ -5,7 +5,11 @@
 obj-y += ramdisk.o
 
 
+ifndef CONFIG_MIPS64
 O_FORMAT = $(shell $(OBJDUMP) -i | head -n 2 | grep elf32)
+else
+O_FORMAT = $(shell $(OBJDUMP) -i | head -n 15 | grep elf64)
+endif
 img := $(subst ",,$(CONFIG_EMBEDDED_RAMDISK_IMAGE))
 # add $(src) when $(img) is relative
 img := $(subst $(src)//,/,$(src)/$(img))
