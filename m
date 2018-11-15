Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Nov 2018 08:58:11 +0100 (CET)
Received: from mail-pl1-x643.google.com ([IPv6:2607:f8b0:4864:20::643]:33991
        "EHLO mail-pl1-x643.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990697AbeKOH4K7dC94 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Nov 2018 08:56:10 +0100
Received: by mail-pl1-x643.google.com with SMTP id f12-v6so9112549plo.1;
        Wed, 14 Nov 2018 23:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8EsXEVewGQUIoSM+UlPZ73/5m+s95O2C6CusK+YxF1k=;
        b=WJoMdZrxeyo/cI47kZp3CU8J431XbGIxIAM74UL8l3sFqnP/erJIgaDztud+LPma/q
         40IkdT4gQdyP3M7jNgLJJt65ZaE6Ilu6780+LMuzrJejpO/64P3pOie+VvrfbsKtqr7e
         8lKn1kNR380A8mwKYfwlWCr7UuzwaVZmrihm0Ammk4ZfCFSWgvCgA24LR1VMXCbJrxkw
         bJpdUSR97C42SExz8irf8zt+P2L7GM5ruQp8lkF1l7RhkHztnm/jRRxGr4opLmdAUmn3
         CaubqUyev6mTe8sq3Jrs1xkBX9i6RUagSL1GDtkTM8n5t/h3GrnYM1deg1FCg4ZzTpwf
         4lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8EsXEVewGQUIoSM+UlPZ73/5m+s95O2C6CusK+YxF1k=;
        b=q2LA68B1Op9K0+5r/LwCILARbcPTTNkeCptG/q6oJVku7f45yw2tRktddlM0a/Hdjv
         4TW1un7xuemyvMPG5X3b2n1NpC24YGTL2qBEqN3cKO4dfbEGv8Gq70miVDF2GhI3+Me0
         owDxoBK2uit+yzOZfxIOxpPXclvX+S8RPK4gXT0V6LoG0cwtIaDyY+bBYUpGCWFsEJbG
         +ge/Vd2U5InUynwetU5LBiuQL0Yux/dV325FLIMSRm3HsIPykTtRuiU/p2hzzXcX2vkc
         CzFhjFTSGMk9KTUgNSfb5NWjs0ObtRX8VswQT+O8pHvi6KmpFfsI/jyuFsVotY+pHBa3
         447g==
X-Gm-Message-State: AGRZ1gImnodwtE+Ovs4xZjwKc10QMiOrS7zetdSyRnlua14rq1qIxkii
        9NbRYuiisHJCJ3joL+F1jlTo8jClgmM=
X-Google-Smtp-Source: AJdET5fg8NpWQWrHOz6pn6jmAY7DiUrdkWhGaRh94PtGSrjAaT8vDXrYg54wMntOuZx/MAX925Pp+w==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr5047324pll.280.1542268570055;
        Wed, 14 Nov 2018 23:56:10 -0800 (PST)
Received: from software.domain.org ([222.92.8.142])
        by smtp.gmail.com with ESMTPSA id k24sm10366286pfj.13.2018.11.14.23.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 23:56:09 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 8+" <stable@vger.kernel.org>
Subject: [PATCH V5 3/8] MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
Date:   Thu, 15 Nov 2018 15:53:54 +0800
Message-Id: <1542268439-4146-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
References: <1542268439-4146-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67308
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

This patch is borrowed from ARM64 to ensure pmd_present() returns false
after pmd_mknotpresent(). This is needed for THP.

Cc: <stable@vger.kernel.org> # 3.8+
References: 5bb1cc0ff9a6 ("arm64: Ensure pmd_present() returns false after pmd_mknotpresent()")
Reviewed-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/pgtable-64.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 0036ea0..93a9dce 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -265,6 +265,11 @@ static inline int pmd_bad(pmd_t pmd)
 
 static inline int pmd_present(pmd_t pmd)
 {
+#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
+	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
+		return pmd_val(pmd) & _PAGE_PRESENT;
+#endif
+
 	return pmd_val(pmd) != (unsigned long) invalid_pte_table;
 }
 
-- 
2.7.0
