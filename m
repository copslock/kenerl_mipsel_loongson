Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 20:38:15 +0100 (CET)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:53656 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904142Ab1KRTiL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 20:38:11 +0100
Received: by yenr8 with SMTP id r8so2854537yen.36
        for <multiple recipients>; Fri, 18 Nov 2011 11:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oE8YWidER0TDLf2hsyFxDQLamk46KVhqkbzL41Pj2dc=;
        b=rvY0UWrRddC5wxY02EoPqTh9ct7wHK2UGQ9ebokiSwMQOuLQlbOIIuH7vE5g8AP9ll
         ap23w0Dm3lH0M9Jp9LKzwKSowGXW6nYdKjxlP6DrZ2RQZYbI7PfudSD8olTaDeme2U9a
         +Eh2aid62nshqXKaEYy5k6HiU48IPMxLKdC1g=
Received: by 10.236.190.197 with SMTP id e45mr7473207yhn.101.1321645085243;
        Fri, 18 Nov 2011 11:38:05 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id d63sm2132968yhl.10.2011.11.18.11.38.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 11:38:04 -0800 (PST)
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.4) with ESMTP id pAIJc2q8020525;
        Fri, 18 Nov 2011 11:38:02 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id pAIJc2Zi020524;
        Fri, 18 Nov 2011 11:38:02 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-embedded@vger.kernel.org, x86@kernel.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH RFC 3/5] kbuild/extable: Hook up sortextable into the build system.
Date:   Fri, 18 Nov 2011 11:37:46 -0800
Message-Id: <1321645068-20475-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com>
X-archive-position: 31808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15859

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
index dab8610..747074e 100644
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
+	$(Q)$(if $($(quiet)cmd_sortextable),				\
+	  echo '  $($(quiet)cmd_sortextable)  vmlinux' &&)		\
+	  $(cmd_sortextable)  vmlinux)
+
+
 	$(Q)$(if $($(quiet)cmd_sysmap),                                      \
 	  echo '  $($(quiet)cmd_sysmap)  System.map' &&)                     \
 	$(cmd_sysmap) $@ System.map;                                         \
diff --git a/init/Kconfig b/init/Kconfig
index 43298f9..b1bcfbd 100644
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
