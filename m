Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 10:55:03 +0100 (BST)
Received: from mu-out-0910.google.com ([209.85.134.191]:54853 "EHLO
	mu-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021525AbXJKJyz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 10:54:55 +0100
Received: by mu-out-0910.google.com with SMTP id w1so569561mue
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2007 02:54:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=2EKZZqxR/gAYwzGTd1koyw5PhBuGixGo1v05dD8kGxM=;
        b=sCtl9AzrWd1rOwVXRXQB1lxps+6+7MR9BijJ1Nj46hEmg7sRyxisKrkhNjati6I53ojwGdl5aN6A4fdvuYmQIM9msiS7cxPd12ylpBuA/BSQ9PDV53alek6i7kWh+LL6eITknaZhI8qH6lSjE7NVe2AJewkuRZ9+d8OIS9LRKac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=esdUQgKN7HBmwZekJG4tj7Fua4YAiWibc0Re8tL3RsEKcnq5PYIlNqeL70H8PBzrCDEB6UjakWRUqsOPUU7YdmM0dYHZmgBZeVjdFrKOcjCSaApv0djG5ZhMI48idZzslQzPWOPyKMf8pK4kksWf5+Uw8nFvKAk/tUnbs24Y6C4=
Received: by 10.82.162.14 with SMTP id k14mr3474975bue.1192096477289;
        Thu, 11 Oct 2007 02:54:37 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id e8sm4046074muf.2007.10.11.02.54.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Oct 2007 02:54:36 -0700 (PDT)
Message-ID: <470DF2C4.8050604@gmail.com>
Date:	Thu, 11 Oct 2007 11:54:12 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] Add .init.bss section 
References: <470DF25E.60009@gmail.com>
In-Reply-To: <470DF25E.60009@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

This patch creates a new init section called .init.bss.

This section is similar to .init.data but doesn't consume
any space in the vmlinux image.

All data marked as part of this section must not be initialized,
of course.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 include/linux/init.h |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 74b1f43..9fda0ec 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -43,6 +43,8 @@
 #define __init		__attribute__ ((__section__ (".init.text"))) __cold
 #define __initdata	__attribute__ ((__section__ (".init.data")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
+#define __initbss	__attribute__ ((__section__ (".init.bss")))
+#define __exitbss	__attribute__ ((__section__ (".exit.bss")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
 /* modpost check for section mismatches during the kernel build.
@@ -257,10 +259,12 @@ void __init parse_early_param(void);
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
@@ -270,9 +274,11 @@ void __init parse_early_param(void);
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
@@ -283,9 +289,11 @@ void __init parse_early_param(void);
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
1.5.3.3
