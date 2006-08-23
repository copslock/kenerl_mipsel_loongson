Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2006 16:15:59 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.229]:57571 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037579AbWHWPP4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Aug 2006 16:15:56 +0100
Received: by wx-out-0506.google.com with SMTP id h30so155924wxd
        for <linux-mips@linux-mips.org>; Wed, 23 Aug 2006 08:15:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type;
        b=p+mDl69esesKxvfS4CFU9Sjxpt9vRfum2DrsAsEvYpvoUfVeRdVYxeffeF/ebRO4JhKTgNcaNu+5mrca7vr97yvtxIrwaRGwmZLT/h2jOOYKAeOA2xgvKArCECg0z464V2BfmLtAaRVgt8x7k8+HaLYCaaDNIUTfx0B/rI1FMMA=
Received: by 10.70.100.14 with SMTP id x14mr712048wxb;
        Wed, 23 Aug 2006 08:15:53 -0700 (PDT)
Received: from ?10.0.1.104? ( [71.243.124.123])
        by mx.gmail.com with ESMTP id i11sm476765wxd.2006.08.23.08.15.51;
        Wed, 23 Aug 2006 08:15:52 -0700 (PDT)
Message-ID: <44EC7125.7000000@gmail.com>
Date:	Wed, 23 Aug 2006 11:15:49 -0400
From:	Peter Watkins <treestem@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] 64K page size
Content-Type: multipart/mixed;
 boundary="------------060403010101060409080303"
Return-Path: <treestem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treestem@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060403010101060409080303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

There are a number of changes required to support larger page sizes, but 
this one I thought worth sending up right away.

The code in pgtable-64.h assumes TASK_SIZE is always bigger than a first 
level PGDIR_SIZE. This is not the case for 64K pages, where task size is 
40 bits (1TB) and a pgd entry can map 42 bits. This leads to 
USER_PTRS_PER_PGD being zero for 64K pages.

If there is interest in other changes for 64K pages, I can send more.

Signed-off-by: Peter Watkins <treestem@gmail.com>


--------------060403010101060409080303
Content-Type: text/plain;
 name="patch-userptrs-2.6.18-rc1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-userptrs-2.6.18-rc1.txt"

diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
index e3db932..9ce72bd 100644
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -93,8 +93,12 @@ #define PTRS_PER_PGD	((PAGE_SIZE << PGD_
 #define PTRS_PER_PMD	((PAGE_SIZE << PMD_ORDER) / sizeof(pmd_t))
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
+#if PGDIR_SIZE >= TASK_SIZE
+#define USER_PTRS_PER_PGD       (1)
+#else
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
-#define FIRST_USER_ADDRESS	0
+#endif
+#define FIRST_USER_ADDRESS	0UL
 
 #define VMALLOC_START		MAP_BASE
 #define VMALLOC_END	\

--------------060403010101060409080303--
