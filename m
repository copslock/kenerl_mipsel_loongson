Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 19:24:01 +0200 (CEST)
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61897 "EHLO
        mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825888Ab3EGRX76pFCs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 19:23:59 +0200
Received: by mail-pb0-f46.google.com with SMTP id rq8so562333pbb.19
        for <multiple recipients>; Tue, 07 May 2013 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=jpDdZEG6TFdeiRn0dHbtVHZYrf8PtSz9DDUkKm3dP4Q=;
        b=NDc0rcn9g0yAyRnlYqGt+7Uf/1g8Xm29B0hoFTfTP77B2aXf7MwoNXR030BeCUXrg4
         2/3NxFngM4isfJSMWzL8YZR2BaMvU6Oo8jPY/bHLNf4sdW6eomPzRXwLCSPbcc66LW4o
         878v4kFno2yzUtM1r9hqc1UNEqa+W0TmnPKD4YVnyKFKg0Yt15P3iIjcdPcOalAgJEJc
         F974A1lUSFNXr2NwXHmwAItXuROEgl1inZT1j8fXhByIiM1NERMjCMzeRVsavJav6cgi
         aSFJoNXtppUWx580be2eZjHhEyS7DG/RqtCyE4KN9JseSZDkvyGDf7M0jZSSzLNmt7HP
         Q/lg==
X-Received: by 10.66.19.201 with SMTP id h9mr3908288pae.188.1367947432725;
        Tue, 07 May 2013 10:23:52 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id qi1sm31101601pac.21.2013.05.07.10.23.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 10:23:51 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r47HNoGl021682;
        Tue, 7 May 2013 10:23:50 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r47HNnwj021681;
        Tue, 7 May 2013 10:23:49 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Jiang Liu <liuj97@gmail.com>, eunb.song@samsung.com,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Make virt_to_phys() work for all unmapped addresses.
Date:   Tue,  7 May 2013 10:23:47 -0700
Message-Id: <1367947427-21649-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36347
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

Not tested against kernel.org kernel, but it may still apply

This could also fix problems noted by Eunbong Song with the
free_initmem_default() call.

 arch/mips/include/asm/io.h   | 2 +-
 arch/mips/include/asm/page.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index a58f229..37fa957 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -116,7 +116,7 @@ static inline void set_io_port_base(unsigned long base)
  */
 static inline unsigned long virt_to_phys(volatile const void *address)
 {
-	return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
+	return __pa(address);
 }
 
 /*
diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index cee3893..e09bff9 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -48,7 +48,6 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/pfn.h>
-#include <asm/io.h>
 
 extern void build_clear_page(void);
 extern void build_copy_page(void);
@@ -139,7 +138,6 @@ typedef struct { unsigned long pgprot; } pgprot_t;
  */
 #define ptep_buddy(x)	((pte_t *)((unsigned long)(x) ^ sizeof(pte_t)))
 
-#endif /* !__ASSEMBLY__ */
 
 /*
  * __pa()/__va() should be used only during mem init.
@@ -156,6 +154,9 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #endif
 #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
 
+#include <asm/io.h>
+#endif /* !__ASSEMBLY__ */
+
 /*
  * RELOC_HIDE was originally added by 6007b903dfe5f1d13e0c711ac2894bdd4a61b1ad
  * (lmo) rsp. 8431fd094d625b94d364fe393076ccef88e6ce18 (kernel.org).  The
-- 
1.7.11.7
