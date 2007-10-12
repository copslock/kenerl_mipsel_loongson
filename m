Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 07:44:32 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.191]:48924 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20023434AbXJLGoY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 07:44:24 +0100
Received: by nf-out-0910.google.com with SMTP id c10so687607nfd
        for <linux-mips@linux-mips.org>; Thu, 11 Oct 2007 23:44:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=QyfWubqm/JHlV8uzTRfAYgwSZKgdrVm16XI76DUEzIE=;
        b=TBxitdK5OJ0h4tAdpmB7Nvo1dieFnde78e7bH96jKK+zj7+RYd2Vvfw0zBxoRvaMhf5WPvSLoNG/8o9VLD2kxN2Tv0QieJ74Nwa6BBeW5QMfouQfIjiAkmQOtTwWGEu362qX1JaIBuGaCpbFrC5RYd/VKRoTMOWFEyBFlLVVwFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=acQ15gZVZ6saEmU+4+6Z3TjPwVEbgbDWdwjQcUzacjbsJJ5aCcIQceW3OQyO5boPhcGN+LGSUg4OgjDqQqtXc/Po/3/Ij0OQDLzqEuKGdBjQFZkGVFLQjSHNjWe4rqedLvRxZfuhF6TLbSoBuHxY8H4pasYMJCIsFLpS9B35NFk=
Received: by 10.86.79.19 with SMTP id c19mr2110501fgb.1192171461827;
        Thu, 11 Oct 2007 23:44:21 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id 28sm616876fkx.2007.10.11.23.44.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Oct 2007 23:44:19 -0700 (PDT)
Message-ID: <470F17A5.7080905@gmail.com>
Date:	Fri, 12 Oct 2007 08:43:49 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 4/4] tlbex.c: use __cacheline_aligned instead of __tlb_handler_align
 attribute
References: <470F16B9.7030406@gmail.com>
In-Reply-To: <470F16B9.7030406@gmail.com>
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16982
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
index 4775e4c..f8b21b3 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1371,18 +1371,15 @@ static void __init build_r4000_tlb_refill_handler(void)
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
