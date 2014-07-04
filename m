Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 19:07:29 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:57503 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834666AbaGDRH0DwXNG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jul 2014 19:07:26 +0200
Received: by mail-la0-f54.google.com with SMTP id mc6so1317962lab.41
        for <multiple recipients>; Fri, 04 Jul 2014 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jFy1Is1fY2z7iuDqB/G0sSpKeqqCoo2DJQvGyw8jYPA=;
        b=k0QW4Bmt7CCIu62+7ktsyp/s1i6rz9OeySVuHbGurDO3nJqSCfYJxnS8xrtyFwwMkI
         fTFZgR67ZO+h6A9O4UewojsWxiilfhx4mYUjZpjItsWaWG/qPZoQIpP1b6jZ60y5j7Pr
         TCEeAV7F9ojxhRbphrgoHOmEPv1IaFR2nomQp8ClL0HvELJIbQQjuqsrQLZQg4PzMGr1
         MyhXUqGwNBtGy2oRs4p5A16GBwT0IDPIP/8d2vVaGe+QIzVrM9IAMhgI0x8vjUnYpNWj
         CZTRZMjPRd+hE/5Ecr/tL9m031akPta5J5eD0EtKWmPALZC/VQ7PT2XgxOMRR8mVkXTb
         V2RA==
X-Received: by 10.112.148.10 with SMTP id to10mr2190719lbb.77.1404493640434;
        Fri, 04 Jul 2014 10:07:20 -0700 (PDT)
Received: from lianli.example.org (c193-14-6-78.cust.tele2.se. [193.14.6.78])
        by mx.google.com with ESMTPSA id i1sm40702586lbj.43.2014.07.04.10.07.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jul 2014 10:07:19 -0700 (PDT)
From:   Emil Goode <emilgoode@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>
Subject: [PATCH] MIPS: Fix incorrect NULL check in local_flush_tlb_page()
Date:   Fri,  4 Jul 2014 19:07:03 +0200
Message-Id: <1404493623-22705-1-git-send-email-emilgoode@gmail.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <emilgoode@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41028
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

We check that the struct vm_area_struct pointer vma is NULL and
then dereference it. The intent must have been to check that
vma is not NULL before we dereference it in the next condition.

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
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
