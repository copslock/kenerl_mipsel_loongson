Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2012 00:02:39 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:52007 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903737Ab2DSWAS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2012 00:00:18 +0200
Received: by obcni5 with SMTP id ni5so5398697obc.36
        for <multiple recipients>; Thu, 19 Apr 2012 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1HjJQTzfzV9OCeFFb18RrQzCRwoKNNJLNYB80iw+TLo=;
        b=ot+TtZ6IJ8w/Dm/oC4AFQj66zWJw7EDunwSWydN7pN4uxug0XIpnX+pXjUx9PK8Mfh
         c2OkxE4u1ieP6mbncNcVPwNLSYrIuWzaJhAkquTWPrj7GQy7blgiJCC1KZ03D8jesRRk
         BAkSyztJTFpefYBdNKeWgbsH76oBufUS5PIvkMZh0NAJkMb57ZuhI/8YknB7771zeJl1
         +DfvO5Ds6bNyXQ7sAvIWLngDS3AQNzVaKzkxW3hOOP7TCvbz+td6ivd2fxtcXNwhJv5R
         JQQw0LvcC0UDOYa5IDA3Eswsyb4SqC+oURNSoI0cVzNaWE1DqGzhkOJE6WrXJazWaUgV
         Ra2g==
Received: by 10.60.25.162 with SMTP id d2mr5652502oeg.30.1334872812123;
        Thu, 19 Apr 2012 15:00:12 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id xh3sm4222007obb.13.2012.04.19.15.00.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Apr 2012 15:00:09 -0700 (PDT)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id q3JM07rR014640;
        Thu, 19 Apr 2012 15:00:07 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id q3JM07rS014639;
        Thu, 19 Apr 2012 15:00:07 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 3/5] kbuild/extable: Hook up sortextable into the build system.
Date:   Thu, 19 Apr 2012 14:59:57 -0700
Message-Id: <1334872799-14589-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com>
References: <1334872799-14589-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 32984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

Define a config variable BUILDTIME_EXTABLE_SORT to control build time
sorting of the kernel's exception table.

Patch Makefile to do the sorting when BUILDTIME_EXTABLE_SORT is
selected.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 Makefile     |   10 ++++++++++
 init/Kconfig |    3 +++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ae947cc..e3bbca9 100644
--- a/Makefile
+++ b/Makefile
@@ -784,6 +784,10 @@ quiet_cmd_vmlinux_version = GEN     .version
 quiet_cmd_sysmap = SYSMAP
       cmd_sysmap = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
 
+# Sort exception table at build time
+quiet_cmd_sortextable = SORTEX
+      cmd_sortextable = $(objtree)/scripts/sortextable
+
 # Link of vmlinux
 # If CONFIG_KALLSYMS is set .version is already updated
 # Generate System.map and verify that the content is consistent
@@ -796,6 +800,12 @@ define rule_vmlinux__
 	$(call cmd,vmlinux__)
 	$(Q)echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
 
+	$(if $(CONFIG_BUILDTIME_EXTABLE_SORT),				\
+	  $(Q)$(if $($(quiet)cmd_sortextable),				\
+	    echo '  $($(quiet)cmd_sortextable)  vmlinux' &&)		\
+	  $(cmd_sortextable)  vmlinux)
+
+
 	$(Q)$(if $($(quiet)cmd_sysmap),                                      \
 	  echo '  $($(quiet)cmd_sysmap)  System.map' &&)                     \
 	$(cmd_sysmap) $@ System.map;                                         \
diff --git a/init/Kconfig b/init/Kconfig
index 6cfd71d..92a1296 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -27,6 +27,9 @@ config IRQ_WORK
 	bool
 	depends on HAVE_IRQ_WORK
 
+config BUILDTIME_EXTABLE_SORT
+	bool
+
 menu "General setup"
 
 config EXPERIMENTAL
-- 
1.7.2.3
