Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Oct 2009 08:19:07 +0200 (CEST)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:43592 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493037AbZJPGR6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Oct 2009 08:17:58 +0200
Received: by pwj1 with SMTP id 1so254590pwj.24
        for <multiple recipients>; Thu, 15 Oct 2009 23:17:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Y7bnQeFCpPt1NSbR3tR4FliU7u2xvW4NnwD6A7QlaK0=;
        b=E1tpRxDiHirtWbsDBDrwlJh3Qfua5MBDJljm0TmIJE3xdgJllZ0GqwO3/MXBJ22zsI
         nNcFRW86EYN/Bmft/CohK2U3XC9W/sC0SxVcUU8wHBQlag0nuYpgN1kEppbVjSIZpfdh
         Zs2Vx/1FlMTNP+4V1wjpyPoicfrGyj/JnRhvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FkREEbRJ9sM55gZac7bkwLiW72g1ylwcmLhxoILEvxHYMRjZBUQgiYQanbvVgbAd3z
         6MDYTb42C9vKLpCKODmfakEjAKdhgTuLHSOin604MsEAnPN+6q/tPP/cMNQjkWmoX4o/
         LlBLoqTjEO0+0+NgqAodyl6Caiybxng06TLJc=
Received: by 10.114.237.37 with SMTP id k37mr1243318wah.31.1255673864117;
        Thu, 15 Oct 2009 23:17:44 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm591698pzk.3.2009.10.15.23.17.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Oct 2009 23:17:43 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, yanh@lemote.com,
	huhb@lemote.com, Zhang Le <r0bertz@gentoo.org>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue 2/7] [loongson] mem.c: Register reserved memory pages
Date:	Fri, 16 Oct 2009 14:17:15 +0800
Message-Id: <c709487f102bcd028fd637f5692ff42d94c55b33.1255673756.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <83f0ebe8e34e5da49d0cb3487a7ef53f4edd69af.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255672832.git.wuzhangjin@gmail.com>
 <83f0ebe8e34e5da49d0cb3487a7ef53f4edd69af.1255673756.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1255673756.git.wuzhangjin@gmail.com>
References: <cover.1255673756.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch registers the reserved pages for loongson family machines.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/mem.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/loongson/common/mem.c b/arch/mips/loongson/common/mem.c
index 7c92f79..47a20de 100644
--- a/arch/mips/loongson/common/mem.c
+++ b/arch/mips/loongson/common/mem.c
@@ -12,14 +12,22 @@
 
 #include <loongson.h>
 #include <mem.h>
+#include <pci.h>
 
 void __init prom_init_memory(void)
 {
     add_memory_region(0x0, (memsize << 20), BOOT_MEM_RAM);
+
+    add_memory_region(memsize << 20, LOONGSON_PCI_MEM_START - (memsize <<
+			    20), BOOT_MEM_RESERVED);
 #ifdef CONFIG_64BIT
     if (highmemsize > 0)
 	add_memory_region(LOONGSON_HIGHMEM_START,
 		highmemsize << 20, BOOT_MEM_RAM);
+
+    add_memory_region(LOONGSON_PCI_MEM_END + 1, LOONGSON_HIGHMEM_START -
+		    LOONGSON_PCI_MEM_END - 1, BOOT_MEM_RESERVED);
+
 #endif /* CONFIG_64BIT */
 }
 
-- 
1.6.2.1
