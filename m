Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Dec 2014 15:28:11 +0100 (CET)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:52332 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008725AbaLSO2FyBxbZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Dec 2014 15:28:05 +0100
Received: by mail-pa0-f47.google.com with SMTP id kq14so1296491pab.6;
        Fri, 19 Dec 2014 06:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Vu6h0WNhfIc/Sz3xfLLxreflMxYG9hVN3wFg5Lcp0cE=;
        b=F9Qloy5ZcD1LJ9qg0m3HKvTGzv1LiU6DeKmTPv/9ODH+n/ar7xfqCsoMHEESAS7dwl
         krbuAAOO6EMbudgUxGLr1MZfWQ+PbuD5yHpljS/bpV4/+6IgaN1u6gM4sdv28k749PjC
         4RbIORNwYhUsgZjoCLUVzcSjSyUomxHGktB/yQyOsDBBBgx9hrQj15bspgnT1QFUhVym
         9v6na1luQ0W+MnrbRXhDoUBrRFVau/Z6BswOxUFeIBHRIj1Ja/DWAqTCeC/+O+QU31aq
         ufgfdbRd5JP2Gk0PY4iiTMqRGp1iqDwa1Gh3wVjLpHtnGRd4EMVxAvdf95HGHbqnNyac
         VkHQ==
X-Received: by 10.70.91.142 with SMTP id ce14mr13023876pdb.138.1418999279799;
        Fri, 19 Dec 2014 06:27:59 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id m7sm9796968pdj.47.2014.12.19.06.27.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 19 Dec 2014 06:27:59 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Hibernate: flush TLB entries earlier
Date:   Fri, 19 Dec 2014 22:26:24 +0800
Message-Id: <1418999184-10216-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44846
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
