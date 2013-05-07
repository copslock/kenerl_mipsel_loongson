Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 20:11:31 +0200 (CEST)
Received: from mail-da0-f45.google.com ([209.85.210.45]:38353 "EHLO
        mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827432Ab3EGSL1FeISj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 20:11:27 +0200
Received: by mail-da0-f45.google.com with SMTP id w3so476606dad.18
        for <multiple recipients>; Tue, 07 May 2013 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=yWQ3nsIJ2TCvy8sPynX4S3eI6FC/O5quUP0RSThGxxE=;
        b=gtYedt8YvVYVpWlnW4w3/qU0cIwEEptbWk/6WH/gu9WfTic4cYDDSGC2BbK5MDhiQc
         ChblKH2IGfukfgEIAjZZN5FVbrUxcjETTiWN0RsF96zX01Ny6kbiLNK71DvcxCeGBUXi
         PTQEAYlvjywj5HCJYEd5CpM2px+1pJ9BkWiHfIh03u6LT2uSB1Rg69/iuWoUdq11Bjka
         jUlc6qA3nRSgl4AIpcgQrCuOkjVqtQqTYPXTXj3QmDREx6XhgHj6rPmeBT2TjzL896CP
         SjRLlY0mAu6cBnbYxlaaNv7NOZlRLvqhVAQDyrhaHm0OaMDoxJAB/o0DCJEkO1EFVwMT
         3SBA==
X-Received: by 10.66.220.197 with SMTP id py5mr4225182pac.86.1367950280161;
        Tue, 07 May 2013 11:11:20 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ef4sm29094757pbd.38.2013.05.07.11.11.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 11:11:19 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r47IBIv9007488;
        Tue, 7 May 2013 11:11:18 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r47IBHH9007487;
        Tue, 7 May 2013 11:11:17 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Jiang Liu <liuj97@gmail.com>, eunb.song@samsung.com,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2] MIPS: Make virt_to_phys() work for all unmapped addresses.
Date:   Tue,  7 May 2013 11:11:16 -0700
Message-Id: <1367950276-7455-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

As reported:
  This problem was discovered when doing BGP traffic with the TCP MD5 option
  activated, where the following call chain caused a crash:

   * tcp_v4_rcv
   *  tcp_v4_timewait_ack
   *   tcp_v4_send_ack -> follow stack variable rep.th
   *    tcp_v4_md5_hash_hdr
   *     tcp_md5_hash_header
   *      sg_init_one
   *       sg_set_buf
   *        virt_to_page

  I noticed that tcp_v4_send_reset uses a similar stack variable and
  also calls tcp_v4_md5_hash_hdr, so it has the same problem.

The networking core can indirectly call virt_to_phys() on stack
addresses, if this is done from PID 0, the stack will usually be in
CKSEG0, so virt_to_phys() needs to work there as well

Signed-off-by: David Daney <david.daney@cavium.com>
---

This one appears to build against Linus' tree.

This could also fix problems noted by Eunbong Song with the
free_initmem_default() call.

 arch/mips/include/asm/io.h   | 2 +-
 arch/mips/include/asm/page.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 1be1372..b7e5985 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -118,7 +118,7 @@ static inline void set_io_port_base(unsigned long base)
  */
 static inline unsigned long virt_to_phys(volatile const void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
+	return __pa(address);
 }
 
 /*
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index eab99e5..ec1ca53 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -46,7 +46,6 @@
 #endif /* CONFIG_MIPS_HUGE_TLB_SUPPORT */
 
 #include <linux/pfn.h>
-#include <asm/io.h>
 
 extern void build_clear_page(void);
 extern void build_copy_page(void);
@@ -151,6 +150,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
     ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
 #endif
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
+#include <asm/io.h>
 
 /*
  * RELOC_HIDE was originally added by 6007b903dfe5f1d13e0c711ac2894bdd4a61b1ad
-- 
1.7.11.7
