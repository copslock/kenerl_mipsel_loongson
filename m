Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2018 04:21:24 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:39548
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990400AbeA0DVLUIz1B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2018 04:21:11 +0100
Received: by mail-pl0-x242.google.com with SMTP id o13so162747pli.6;
        Fri, 26 Jan 2018 19:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8EsXEVewGQUIoSM+UlPZ73/5m+s95O2C6CusK+YxF1k=;
        b=ckH4JHkjmYxhqjJTnKfc/ZqrkDAV7K02kqvIdBa+jnknu/9wfGeqdZbjyUlcfaYQA5
         BmVobSM8T1uvYV35HeRLXM24L0kQmMaTXTcYuXhvLOuRM4DPbtaScIbnKKw/MwujNCOA
         ngS2YbGBnEk0RWmKu3Ys/TgL9EMFahek682v9Z4JKB0GyQ8HxTjIokcnjwqu572IB/CM
         uNmGdc80JKwTRzGQvi7m/ir7EkUgh+ugGFwYly4ibqGZAGc54Oju4CCaeTdS1y7192sY
         yYRcfwZNJ9LJ8a6vyqsm02LFYmUMZEA6wX8Ol8OEPKkg+qdvkHzKQLijxizDJCY3Ckeo
         n6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8EsXEVewGQUIoSM+UlPZ73/5m+s95O2C6CusK+YxF1k=;
        b=btroC2wE1h5nmHBagS517k+LVKDyyuxBPRhue4SO6534n5geo/rc3Vt0jri2ebvcit
         Gz0EL/uZu12IshMVKjpYioGe116l5mxAf1L0/CE9MH4C4OfV/kg+UBCqTLnWIHCoTySW
         WJx3h0AhZaTA6zjVRG+8OexKEmx2s6W1uO375SpIx4RMu/AqZw9wcsJF6uS3wtrVG24c
         WCmXnk+/mcFtEUC+0ax1wQn/q+FIP+kUVralL278Nr2b/AXlMtrvcvjnoj9RreKVyCSI
         ag19N9bp4+M2Ek7cJT0m0Iqdl0ZFtKxMooBcTTYyHjqTI6dC6oehQ0631B6+g4etC2fB
         FRpg==
X-Gm-Message-State: AKwxyte8482db+IaWYNONngQyUC9oBNmHVGU2jo5rWehkxuTu9q0EfL1
        0DoC4QJ7WtMh+Dw4d24sZbUJcg==
X-Google-Smtp-Source: AH8x225rwbW6xBoC7wNwvNvH2M/0v9mJlwsig7HJI8nD2fZLasbNRymObgX4mb3DXXn84At1TYuTpg==
X-Received: by 2002:a17:902:b101:: with SMTP id q1-v6mr1212107plr.378.1517023265146;
        Fri, 26 Jan 2018 19:21:05 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id z19sm17949512pfh.185.2018.01.26.19.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 19:21:04 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 8+" <stable@vger.kernel.org>
Subject: [PATCH V2 06/12] MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
Date:   Sat, 27 Jan 2018 11:21:16 +0800
Message-Id: <1517023276-17527-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62349
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
