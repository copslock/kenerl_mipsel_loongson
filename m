Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Dec 2014 03:32:53 +0100 (CET)
Received: from mail-pd0-f181.google.com ([209.85.192.181]:44256 "EHLO
        mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008814AbaLVCcwA01tl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Dec 2014 03:32:52 +0100
Received: by mail-pd0-f181.google.com with SMTP id v10so4901531pde.40;
        Sun, 21 Dec 2014 18:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Vu6h0WNhfIc/Sz3xfLLxreflMxYG9hVN3wFg5Lcp0cE=;
        b=zIczuzxRY5o56zByap3EeXk1CXFR660JB61S7j3Tjd1j9Q1lhHC1pMyfJ529tXzEij
         k0Yd9edvHm4V8wq3rgZLDPNZkRuJuGIixQ1RMKSX0NjK4hVXfrOGRIG1WNmdYfFRl4Id
         oM0eKqB/FvW/GrcUFtDiDB4IPd/ChfkTf0mxKc8PYj4xmvn/y0naNfOD63GIBFPl/ZKP
         yzvu31Zas6EM4XcSdybI0eWVdcXfZJHbdLzDohrnN5lm0knBBSRMxLcdC+s7e9i5zUBL
         nsMYn/5MeEKde4f5uOnhmngCMucx8GEmczAxAA4J0/N/v+msYIkDGjqrUiHwTNuH5JGm
         Ko9g==
X-Received: by 10.66.155.2 with SMTP id vs2mr30980465pab.135.1419215565818;
        Sun, 21 Dec 2014 18:32:45 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id sp6sm15735176pac.42.2014.12.21.18.32.43
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 21 Dec 2014 18:32:45 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/2] MIPS: Hibernate: flush TLB entries earlier
Date:   Mon, 22 Dec 2014 10:30:38 +0800
Message-Id: <1419215439-27900-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

We found that TLB mismatch not only happens after kernel resume, but
also happens during snapshot restore. So move it to the beginning of
swsusp_arch_suspend().

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/power/hibernate.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/power/hibernate.S b/arch/mips/power/hibernate.S
index 32a7c82..e7567c8 100644
--- a/arch/mips/power/hibernate.S
+++ b/arch/mips/power/hibernate.S
@@ -30,6 +30,8 @@ LEAF(swsusp_arch_suspend)
 END(swsusp_arch_suspend)
 
 LEAF(swsusp_arch_resume)
+	/* Avoid TLB mismatch during and after kernel resume */
+	jal local_flush_tlb_all
 	PTR_L t0, restore_pblist
 0:
 	PTR_L t1, PBE_ADDRESS(t0)   /* source */
@@ -43,7 +45,6 @@ LEAF(swsusp_arch_resume)
 	bne t1, t3, 1b
 	PTR_L t0, PBE_NEXT(t0)
 	bnez t0, 0b
-	jal local_flush_tlb_all /* Avoid TLB mismatch after kernel resume */
 	PTR_LA t0, saved_regs
 	PTR_L ra, PT_R31(t0)
 	PTR_L sp, PT_R29(t0)
-- 
1.7.7.3
