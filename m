Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jan 2015 20:15:29 +0100 (CET)
Received: from mail-we0-f182.google.com ([74.125.82.182]:51565 "EHLO
        mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009687AbbAATP1Xk7X8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jan 2015 20:15:27 +0100
Received: by mail-we0-f182.google.com with SMTP id w62so3690080wes.41
        for <linux-mips@linux-mips.org>; Thu, 01 Jan 2015 11:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H+IidVuIKki2Dk+GBkxWEXVqS9MHld2PPF+RPgCEHPQ=;
        b=BAwHxzmlulsL029SDECq5swiyHo6MZVRr5One361JeoVCY7t0hGiWCjGswV2OOrS1O
         2DdsB2gTDx+g5HdM5lzYX+AP2sduKBGm7JbZOfvBwTfBy1CGMf5OZKNo46ioLgorcBbQ
         CFcnFv0u0TJo81Fqaq4ObuJ4k5BmlbhcFmCn39+ATcd1JGvNg93zm105yjehsooYjNwh
         O0lu/F8it34XUNJoNnQnrtXmhO16aeiOwXdqcfx96hdV2GqoDg352pYpwC93ivMQQr8d
         3V3FhluoyS5gUPXUOLaUcbWz9bPDIOgWceM47jqGZJZrmmq5ysPaBlZNMFafJnpjIiKs
         uZgQ==
X-Gm-Message-State: ALoCoQkjKWDcpohpolMjuM3uUvrbnHUu06Lgk95m2M9FXLNf7CUCwkSuFwBaNyEFuzUukvSuWklm
X-Received: by 10.194.87.100 with SMTP id w4mr144212566wjz.65.1420139721633;
        Thu, 01 Jan 2015 11:15:21 -0800 (PST)
Received: from localhost.localdomain (h-246-111.a218.priv.bahnhof.se. [85.24.246.111])
        by mx.google.com with ESMTPSA id h8sm51608217wiy.17.2015.01.01.11.15.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jan 2015 11:15:21 -0800 (PST)
From:   Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
        John Crispin <blogic@openwrt.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch: mips: mm: page:  Remove unused function
Date:   Thu,  1 Jan 2015 20:18:22 +0100
Message-Id: <1420139902-3776-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <rickard.strandqvist@spctrm.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rickard_strandqvist@spectrumdigital.se
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

Remove the function sb1_dma_init() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/mips/mm/page.c |   15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/mips/mm/page.c b/arch/mips/mm/page.c
index b611102..aa43df2 100644
--- a/arch/mips/mm/page.c
+++ b/arch/mips/mm/page.c
@@ -592,21 +592,6 @@ struct dmadscr {
 	u64 pad_b;
 } ____cacheline_aligned_in_smp page_descr[DM_NUM_CHANNELS];
 
-void sb1_dma_init(void)
-{
-	int i;
-
-	for (i = 0; i < DM_NUM_CHANNELS; i++) {
-		const u64 base_val = CPHYSADDR((unsigned long)&page_descr[i]) |
-				     V_DM_DSCR_BASE_RINGSZ(1);
-		void *base_reg = IOADDR(A_DM_REGISTER(i, R_DM_DSCR_BASE));
-
-		__raw_writeq(base_val, base_reg);
-		__raw_writeq(base_val | M_DM_DSCR_BASE_RESET, base_reg);
-		__raw_writeq(base_val | M_DM_DSCR_BASE_ENABL, base_reg);
-	}
-}
-
 void clear_page(void *page)
 {
 	u64 to_phys = CPHYSADDR((unsigned long)page);
-- 
1.7.10.4
