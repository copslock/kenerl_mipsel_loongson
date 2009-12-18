Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2009 14:01:37 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:41697 "EHLO
        mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493109AbZLRNA6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2009 14:00:58 +0100
Received: by gxk2 with SMTP id 2so2741347gxk.4
        for <multiple recipients>; Fri, 18 Dec 2009 05:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=cJctrNY0rIlM/42dttOKgqaFyEnHm4N3KU3l6IIkzZ4=;
        b=OA+US9Bo8YjeBdXSbIt/0n797uTAa1wQuHM1XmItI8hLJ625lEPbv57dsd5xPYII83
         lGb09mZiw3mGpfKdMGpizjeP+1IDaW4dRTOskp7oz8kQ1G5zpUP+oh27sMANu45ULorj
         OkepDjnCwEGmWUvVwRatwB701So+vEyMyQzsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Xa2emEBCzAHbGHH3WkPgZQT5s7ZRfsJhVqap+ZevHl1DNVPwfAel1T3Cju8zyCgzm6
         a9aF4UmxwB9grODGCkhMJqN+Y/mX+Cf5UEkf7rjXBP5bCcrWNqM8stdlx1VbU9kXhhnd
         +4N2XYaAWAzuoJUFA2X5goKuYClYggRJ+NT08=
Received: by 10.90.41.31 with SMTP id o31mr1369750ago.80.1261141241205;
        Fri, 18 Dec 2009 05:00:41 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 15sm970064gxk.0.2009.12.18.05.00.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 05:00:40 -0800 (PST)
Date:   Fri, 18 Dec 2009 21:30:18 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/5] MIPS: remove unused powertv ptv_memsize
Message-Id: <20091218213018.79a9fc11.yuasa@linux-mips.org>
In-Reply-To: <20091218212917.f42e8180.yuasa@linux-mips.org>
References: <20091218212917.f42e8180.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/powertv/memory.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/powertv/memory.c b/arch/mips/powertv/memory.c
index 28d0660..f49eb3d 100644
--- a/arch/mips/powertv/memory.c
+++ b/arch/mips/powertv/memory.c
@@ -42,8 +42,6 @@
 #define BOOT_MEM_SIZE		KIBIBYTE(256)	/* Memory reserved for bldr */
 #define PHYS_MEM_START		0x10000000	/* Start of physical memory */
 
-unsigned long ptv_memsize;
-
 char __initdata cmdline[COMMAND_LINE_SIZE];
 
 void __init prom_meminit(void)
@@ -87,9 +85,6 @@ void __init prom_meminit(void)
 		}
 	}
 
-	/* Store memsize for diagnostic purposes */
-	ptv_memsize = memsize;
-
 	physend = PFN_ALIGN(&_end) - 0x80000000;
 	if (memsize > LOW_MEM_MAX) {
 		low_mem = LOW_MEM_MAX;
-- 
1.6.5.7
