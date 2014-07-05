Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jul 2014 20:27:06 +0200 (CEST)
Received: from mail-lb0-f175.google.com ([209.85.217.175]:49751 "EHLO
        mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817664AbaGES1Dr-TVI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jul 2014 20:27:03 +0200
Received: by mail-lb0-f175.google.com with SMTP id n15so1859810lbi.34
        for <multiple recipients>; Sat, 05 Jul 2014 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YeC0bqhexSFpGbTMgdAeQKRXlxpQe0YTODsuU0rGXIo=;
        b=ZxanQpILjTI0/OC3YL9xCRTz7en9I3ZJvNBjQywRZBLcUxDotKBiv8Bk1MoIsG8tYv
         zQ7ZDxC/3F2QiCxO0wnyN1/WF+aOulkw0enPNUnOo2jDmRkVW7oD5ko5F3l8OTV/4o0w
         90sEfhKQSp8uIP4/J+Qaj6nmY6pl9C5cpt9lgnBHuzAuuMT1c5SLHp43bc4m8HI2AEFm
         b22uOYZVGheA9Eyx8XS8Ra+FSyVsAHa6sFJ49ga7W15dfO6eJmqjH/3FU1nM/4s4hi7k
         YsdkUpWArrb2dugSwBGiln+MboQRz7wxm3unZzuHhZZrTiPUG8FIXG3Of+0jGkWjn7jQ
         s1Nw==
X-Received: by 10.112.155.129 with SMTP id vw1mr13583019lbb.7.1404584818128;
        Sat, 05 Jul 2014 11:26:58 -0700 (PDT)
Received: from lianli.example.org (c193-14-6-78.cust.tele2.se. [193.14.6.78])
        by mx.google.com with ESMTPSA id js1sm6615398lab.7.2014.07.05.11.26.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jul 2014 11:26:57 -0700 (PDT)
From:   Emil Goode <emilgoode@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>
Subject: [PATCH v2] MIPS: Fix incorrect NULL check in local_flush_tlb_page()
Date:   Sat,  5 Jul 2014 20:26:52 +0200
Message-Id: <1404584812-12377-1-git-send-email-emilgoode@gmail.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <emilgoode@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: emilgoode@gmail.com
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

We check that the struct vm_area_struct pointer vma is NULL and then
dereference it a few lines below. The intent must have been to make sure
that vma is not NULL and then to check the value from cpu_context() for
the condition to be true.

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---

v2: Updated the commit message with a better explanation.

 arch/mips/mm/tlb-r3k.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index d657493..6546758 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -158,7 +158,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 {
 	int cpu = smp_processor_id();
 
-	if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
+	if (vma && cpu_context(cpu, vma->vm_mm) != 0) {
 		unsigned long flags;
 		int oldpid, newpid, idx;
 
-- 
1.7.10.4
