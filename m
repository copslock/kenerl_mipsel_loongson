Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 08:14:03 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.171]:64646 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20025789AbXJRHNA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 08:13:00 +0100
Received: by ug-out-1314.google.com with SMTP id u2so429780uge
        for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 00:12:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EWu2MbxRa1YJhWXPRmaEOO7VRfMfpi32ApW1tKI4hkM=;
        b=EG4wbNqHpNoqjNvVi5CenSdPM1UCGZUOHUqhZwrrYUgh6/aR7WOgscqJKaq1HZjJRHOoQdGOEx4Soio3KyrC/QnxYbWQibfpI2si5B6rmMGZff4EafRuzBfLPEZ6IqJ9VDBpZmpwt+K5EOunaV//1hD3wzM7LaanMxxsBOwgi08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=T7OvZeWbK8xdu5hKKxZnatDK2EoQoZYYdhlng7I/9WjgNT3uRBJunKAGzCHE4V29ZWhnQh7abBhrE3TtEGc2KOoyA3SK1zKHD3Ep5yEorBu/uPyilHr2xzZmSGfP8wEl0kMdcY/42jXKtPhLEvy1mESOxPpeHAC7nCOYMS4mrqQ=
Received: by 10.66.184.17 with SMTP id h17mr1524818ugf.1192691562775;
        Thu, 18 Oct 2007 00:12:42 -0700 (PDT)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id g1sm1089443muf.2007.10.18.00.12.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2007 00:12:41 -0700 (PDT)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	ralf@linux-mips.org
Cc:	anemo@mba.ocn.ne.jp, ths@networkno.de, linux-mips@linux-mips.org
Subject: [PATCH 3/4] tlbex.c: use __cacheline_aligned instead of __tlb_handler_align attribute
Date:	Thu, 18 Oct 2007 09:11:16 +0200
Message-Id: <1192691477-4675-4-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1192691477-4675-1-git-send-email-fbuihuu@gmail.com>
References: <1192691477-4675-1-git-send-email-fbuihuu@gmail.com>
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---
 arch/mips/mm/tlbex.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index aa14343..b6ef4b0 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1372,18 +1372,15 @@ static void __init build_r4000_tlb_refill_handler(void)
 extern void tlb_do_page_fault_0(void);
 extern void tlb_do_page_fault_1(void);
 
-#define __tlb_handler_align \
-	__attribute__((__aligned__(1 << CONFIG_MIPS_L1_CACHE_SHIFT)))
-
 /*
  * 128 instructions for the fastpath handler is generous and should
  * never be exceeded.
  */
 #define FASTPATH_SIZE 128
 
-u32 __tlb_handler_align handle_tlbl[FASTPATH_SIZE];
-u32 __tlb_handler_align handle_tlbs[FASTPATH_SIZE];
-u32 __tlb_handler_align handle_tlbm[FASTPATH_SIZE];
+u32 handle_tlbl[FASTPATH_SIZE] __cacheline_aligned;
+u32 handle_tlbs[FASTPATH_SIZE] __cacheline_aligned;
+u32 handle_tlbm[FASTPATH_SIZE] __cacheline_aligned;
 
 static void __init
 iPTE_LW(u32 **p, struct label **l, unsigned int pte, unsigned int ptr)
-- 
1.5.3.4
