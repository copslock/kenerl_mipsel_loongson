Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Sep 2015 08:36:50 +0200 (CEST)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38695 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007225AbbICGgnmwCB2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Sep 2015 08:36:43 +0200
Received: by wiclp12 with SMTP id lp12so40618214wic.1;
        Wed, 02 Sep 2015 23:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=Q8FX4Bm76zGrFiLHCd3xZKEV4evac0ftFdsKUI5b5mE=;
        b=CkzZBaCY/Sy8V++okb2uBquggjuFaYALhBbtd2Ibh/F7qATKroZqkCmIq384JRjHJT
         bGKJvEl5sICu96lTIlaiKPu+kYgeRCmGakcEHOf7AtGUlmrjeoJUn5CJbKfOX8vsn/9i
         D1RysYw453EIO55rxt6rUojC8MU33yrRVXPdu0w07LzqBLrNIgz3VSEBnYfo9LXh+3rW
         4ZcbJA8gDWxDbf3K0+m584OH6Z3J2iKzagY0m4wbt80h12vWFO4xpNhm6PyzvotQj2Od
         sIGSinqaEwLngj0/9Qisbfb5xuTnR3qaU1i1Y5KqEu9qnTV5EgLT8ANrt5NRwOg8LGYP
         ftdQ==
X-Received: by 10.180.76.231 with SMTP id n7mr11265610wiw.65.1441262198464;
        Wed, 02 Sep 2015 23:36:38 -0700 (PDT)
Received: from [172.28.172.4] ([46.188.253.53])
        by smtp.googlemail.com with ESMTPSA id c11sm7260768wib.1.2015.09.02.23.36.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2015 23:36:37 -0700 (PDT)
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Joe Perches <joe@perches.com>, Huacai Chen <chenhc@lemote.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Tony Wu <tung7970@gmail.com>, stable@vger.kernel.org
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH] MIPS: bootmem: Fix mapstart calculation for contiguous maps
Message-ID: <55E7EA73.9070707@gmail.com>
Date:   Thu, 3 Sep 2015 08:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <alexander.sverdlin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexander.sverdlin@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Commit a6335fa1 fixed the case with gap between initrd and next usable PFN zone,
but broken the case when initrd is combined with usable memory into one region
(in add_memory_region()). Restore the fixup initially brought in by f9a7febd.

---- error message ----
Unpacking initramfs...
Initramfs unpacking failed: junk in compressed archive
BUG: Bad page state in process swapper  pfn:00261
page:81004c20 count:0 mapcount:-127 mapping:  (null) index:0x2
flags: 0x0()
page dumped because: nonzero mapcount
CPU: 0 PID: 1 Comm: swapper Not tainted 4.2.0+ #1782
-----------------------

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Reported-by: Tony Wu <tung7970@gmail.com>
Tested-by: Tony Wu <tung7970@gmail.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Joe Perches <joe@perches.com>
Cc: Steven J. Hill <Steven.Hill@imgtec.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: stable@vger.kernel.org
---
 arch/mips/kernel/setup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 008b337..4ceac5c 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -338,7 +338,7 @@ static void __init bootmem_init(void)
 		if (end <= reserved_end)
 			continue;
 #ifdef CONFIG_BLK_DEV_INITRD
-		/* mapstart should be after initrd_end */
+		/* Skip zones before initrd and initrd itself */
 		if (initrd_end && end <= (unsigned long)PFN_UP(__pa(initrd_end)))
 			continue;
 #endif
@@ -371,6 +371,14 @@ static void __init bootmem_init(void)
 		max_low_pfn = PFN_DOWN(HIGHMEM_START);
 	}

+#ifdef CONFIG_BLK_DEV_INITRD
+	/*
+	 * mapstart should be after initrd_end
+	 */
+	if (initrd_end)
+		mapstart = max(mapstart, (unsigned long)PFN_UP(__pa(initrd_end)));
+#endif
+
 	/*
 	 * Initialize the boot-time allocator with low memory only.
 	 */
