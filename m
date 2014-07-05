Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Jul 2014 01:24:14 +0200 (CEST)
Received: from mail-lb0-f178.google.com ([209.85.217.178]:53793 "EHLO
        mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860003AbaGEXYK0HIlP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Jul 2014 01:24:10 +0200
Received: by mail-lb0-f178.google.com with SMTP id 10so1902557lbg.23
        for <multiple recipients>; Sat, 05 Jul 2014 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4bg4cgRldCg/PRsrrvodfEtCBqKfd5fKapx38TmIM0Q=;
        b=SdzseA9Xdnu0RKdZC+XVnV3qBB931LAk63QcPb0u38GbWOsV764UmesbN2fh78SRmX
         lEeJMvIIMetQsOOwZmvZtQABtESl6Bu9YMoEpUuQnLNpZR/LkqQsv4ZTWiOT0t8horbf
         65/ZN/LwOjD1nkevNLR4IzPNiJP8/PfyqkVY1EoQOSpf9C0LzIfiw4k7BXundsa4cR61
         74+vCU6GiIJsXc3oT1n8T24pYIjDPVodNz+Z/R7JjXHir+m5EI9vAbLAxN/Tmc7vKw+U
         CO9/ScZovjs59z+W3nqdE/Ezrwm2wL4gNqktXTW5dM5Xa+j+GuNcEBTudv8MngYUFrzX
         vd0Q==
X-Received: by 10.152.45.99 with SMTP id l3mr15300774lam.5.1404602644661;
        Sat, 05 Jul 2014 16:24:04 -0700 (PDT)
Received: from lianli.example.org (c193-14-6-78.cust.tele2.se. [193.14.6.78])
        by mx.google.com with ESMTPSA id i10sm16929994laa.46.2014.07.05.16.24.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jul 2014 16:24:04 -0700 (PDT)
From:   Emil Goode <emilgoode@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Gorski <jogo@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>
Subject: [PATCH] MIPS: Remove incorrect NULL check in local_flush_tlb_page()
Date:   Sun,  6 Jul 2014 01:23:58 +0200
Message-Id: <1404602638-16447-1-git-send-email-emilgoode@gmail.com>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <emilgoode@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41054
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
dereference it a few lines below. The intent was to make sure vma is
not NULL but this is not necessary since the bug pre-dates GIT history
and seem to never have caused a problem. The tlb-4k and tlb-8k versions
of local_flush_tlb_page() don't bother checking if vma is NULL, also
vma is dereferenced before being passed to local_flush_tlb_page(),
thus it is safe to remove this NULL check.

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 arch/mips/mm/tlb-r3k.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlb-r3k.c b/arch/mips/mm/tlb-r3k.c
index d657493..4094bbd 100644
--- a/arch/mips/mm/tlb-r3k.c
+++ b/arch/mips/mm/tlb-r3k.c
@@ -158,7 +158,7 @@ void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
 {
 	int cpu = smp_processor_id();
 
-	if (!vma || cpu_context(cpu, vma->vm_mm) != 0) {
+	if (cpu_context(cpu, vma->vm_mm) != 0) {
 		unsigned long flags;
 		int oldpid, newpid, idx;
 
-- 
1.7.10.4
