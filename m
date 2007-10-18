Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 22:15:55 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.190]:7432 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20043426AbXJRVOL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 22:14:11 +0100
Received: by nf-out-0910.google.com with SMTP id c10so259839nfd
        for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 14:13:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Z7wAIc2szSEKBpJtAoodXpBXWMjiST3m9QRSuNSHvNE=;
        b=c9d4OUNUyuzzsoycK63bz8LRh9YEeGznB5R+vGdZsgnHskC/zbVcLiylX1AxsA4TZC13gv/taSsFJO6IL1WfAScjXYY3x9s1qCgRilFxLXNUUzp4d1b9IHgJcSU4lF/jM6NElXNHsfoCVQDUYV/ViPVGDObPshlcD/W3ACL6md8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QijigNswnqY1WJjWN0MMNA9KVpIsXi0/hwlgqCnqBd+6c/OuwYkYi5nTP+8eZjlQvsZRCbJdkVxkmGBIXlBVs3RRzcwy3iEo7NIGMGLv2rEX6mgqakC2D13XDgdnyzD7SIrxVTlhhrv8b07jvCyfEaqJu290fXoL47RsFVOpIio=
Received: by 10.86.84.5 with SMTP id h5mr769659fgb.1192742034438;
        Thu, 18 Oct 2007 14:13:54 -0700 (PDT)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id j12sm2455317fkf.2007.10.18.14.13.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2007 14:13:53 -0700 (PDT)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, macro@linux-mips.org
Subject: [PATCH 1/4] Add .bss.{init,exit} sections
Date:	Thu, 18 Oct 2007 23:12:30 +0200
Message-Id: <1192741953-7040-2-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1192741953-7040-1-git-send-email-fbuihuu@gmail.com>
References: <1192741953-7040-1-git-send-email-fbuihuu@gmail.com>
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

This patch creates a new init section called .bss.init.

This section is similar to .init.data but doesn't consume
any space in the vmlinux image.

All data marked as part of this section must not be initialized,
of course.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/linux/init.h |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 74b1f43..0febf3e 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -43,6 +43,8 @@
 #define __init		__attribute__ ((__section__ (".init.text"))) __cold
 #define __initdata	__attribute__ ((__section__ (".init.data")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
+#define __initbss	__attribute__ ((__section__ (".bss.init")))
+#define __exitbss	__attribute__ ((__section__ (".bss.exit")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
 /* modpost check for section mismatches during the kernel build.
@@ -68,6 +70,7 @@
 #define __INIT		.section	".init.text","ax"
 #define __FINIT		.previous
 #define __INITDATA	.section	".init.data","aw"
+#define __INITBSS	.section	".bss.init","aw",@nobits
 
 #ifndef __ASSEMBLY__
 /*
@@ -257,10 +260,12 @@ void __init parse_early_param(void);
 #define __devexit
 #define __devexitdata
 #else
-#define __devinit __init
-#define __devinitdata __initdata
-#define __devexit __exit
-#define __devexitdata __exitdata
+#define __devinit	__init
+#define __devinitdata	__initdata
+#define __devinitbss	__initbss
+#define __devexit	__exit
+#define __devexitdata	__exitdata
+#define __devexitbss	__exitbss
 #endif
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -270,9 +275,11 @@ void __init parse_early_param(void);
 #define __cpuexitdata
 #else
 #define __cpuinit	__init
-#define __cpuinitdata __initdata
-#define __cpuexit __exit
+#define __cpuinitdata	__initdata
+#define __cpuinitbss	__initbss
+#define __cpuexit	__exit
 #define __cpuexitdata	__exitdata
+#define __cpuexitbss	__exitbss
 #endif
 
 #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_ACPI_HOTPLUG_MEMORY) \
@@ -283,9 +290,11 @@ void __init parse_early_param(void);
 #define __memexitdata
 #else
 #define __meminit	__init
-#define __meminitdata __initdata
-#define __memexit __exit
+#define __meminitdata	__initdata
+#define __meminitbss	__meminitbss
+#define __memexit	__exit
 #define __memexitdata	__exitdata
+#define __memexitbss	__exitbss
 #endif
 
 /* Functions marked as __devexit may be discarded at kernel link time, depending
-- 
1.5.3.4
