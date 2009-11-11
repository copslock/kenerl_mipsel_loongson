Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 06:40:03 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:53662 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492134AbZKKFjf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 06:39:35 +0100
Received: by pxi6 with SMTP id 6so849476pxi.0
        for <multiple recipients>; Tue, 10 Nov 2009 21:39:27 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=xLfQB6SvxrMyNbzvbJgtZFemC/MXrmo9KO5IMRA9jHs=;
        b=CSq+sgcE7ja+D1lygxhaGCIRQcuWxjqC8sgTvTRPbwyVEJo00c2IKFfWt3pVsJ59Ti
         RxVvlInkGKXQcBzemTCninQwPDQ6U55IyHMI9Ujuse2FQIoPLnUyV9zEVE21hyq+sCIF
         cTL0O7hsHI48hV1ipWbhAoWccFgtOHkbyeCAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OvMzavt+4SSJPCIx8kmztR1k1xuOQlB1Bq74ac4FGhdE/4bbVdoJM39IznTh3cAJRn
         2FPprPSijGntRH08/Rqpx6VM7NClYCNYDhJbBHxpqk47X3u3Q6OTlAQKoNV6H7KnGXKK
         ugRofAxE1XR8yDtOzFLT6avLjeJTUnb3i0Hj0=
Received: by 10.114.51.12 with SMTP id y12mr2310816way.33.1257917967206;
        Tue, 10 Nov 2009 21:39:27 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm850415pxi.6.2009.11.10.21.39.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 21:39:26 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 1/2] [loongson] mem.c: indent the file with TAB instead of whitespaces
Date:	Wed, 11 Nov 2009 13:39:11 +0800
Message-Id: <1cb2ae6fba2acd5e5d276f49f5b734876859e589.1257917611.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257917611.git.wuzhangjin@gmail.com>
References: <cover.1257917611.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1257917611.git.wuzhangjin@gmail.com>
References: <cover.1257917611.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/mem.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/mips/loongson/common/mem.c b/arch/mips/loongson/common/mem.c
index 45991af..312c765 100644
--- a/arch/mips/loongson/common/mem.c
+++ b/arch/mips/loongson/common/mem.c
@@ -16,10 +16,11 @@
 
 void __init prom_init_memory(void)
 {
-    add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+	add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
 
-    add_memory_region(memsize << 20, LOONGSON_PCI_MEM_START - (memsize <<
-			    20), BOOT_MEM_RESERVED);
+	add_memory_region(memsize << 20,
+			LOONGSON_PCI_MEM_START - (memsize << 20),
+			  BOOT_MEM_RESERVED);
 #ifdef CONFIG_64BIT
 #ifdef CONFIG_CPU_LOONGSON2F
 	{
@@ -36,16 +37,16 @@ void __init prom_init_memory(void)
 					  0x80000000ul, (1 << bit));
 		mmiowb();
 	}
-#endif	/* CONFIG_CPU_LOONGSON2F */
+#endif				/* CONFIG_CPU_LOONGSON2F */
 
-    if (highmemsize > 0)
-	add_memory_region(LOONGSON_HIGHMEM_START,
-		highmemsize << 20, BOOT_MEM_RAM);
+	if (highmemsize > 0)
+		add_memory_region(LOONGSON_HIGHMEM_START,
+				  highmemsize << 20, BOOT_MEM_RAM);
 
-    add_memory_region(LOONGSON_PCI_MEM_END + 1, LOONGSON_HIGHMEM_START -
-		    LOONGSON_PCI_MEM_END - 1, BOOT_MEM_RESERVED);
+	add_memory_region(LOONGSON_PCI_MEM_END + 1, LOONGSON_HIGHMEM_START -
+			  LOONGSON_PCI_MEM_END - 1, BOOT_MEM_RESERVED);
 
-#endif /* CONFIG_64BIT */
+#endif				/* CONFIG_64BIT */
 }
 
 /* override of arch/mips/mm/cache.c: __uncached_access */
@@ -55,6 +56,6 @@ int __uncached_access(struct file *file, unsigned long addr)
 		return 1;
 
 	return addr >= __pa(high_memory) ||
-		((addr >= LOONGSON_MMIO_MEM_START) &&
-		 (addr < LOONGSON_MMIO_MEM_END));
+	    ((addr >= LOONGSON_MMIO_MEM_START) &&
+	     (addr < LOONGSON_MMIO_MEM_END));
 }
-- 
1.6.2.1
