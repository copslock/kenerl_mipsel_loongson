Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Sep 2018 11:34:00 +0200 (CEST)
Received: from mail-pf1-x443.google.com ([IPv6:2607:f8b0:4864:20::443]:41462
        "EHLO mail-pf1-x443.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994612AbeIEJdvhuxFC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Sep 2018 11:33:51 +0200
Received: by mail-pf1-x443.google.com with SMTP id h79-v6so3175450pfk.8;
        Wed, 05 Sep 2018 02:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8EsXEVewGQUIoSM+UlPZ73/5m+s95O2C6CusK+YxF1k=;
        b=Airgplmj06lPXz/o9BzJPLgXhjyuub966wLAGIhhi+e4M44Hjfaq7YjOBiQRJgE6IU
         5Qxlik+m5bAkssyqnwyor3tb1dKRplHHnrSdFzLkEaabU3VXzeoQHuSFOR8r+1Uz1lRT
         Na9t/JYc0d8XfDtgoT5GigUQ+XihBqErZaPbjvd/lbcvXBQP/ghJJIpiwZEclchW/ckj
         sIn98t7nG4LX4/kZulmVXGUhAtg1h3YAOr6S9RyE8gEz6dol0ymdW6UseYa2eZ6giU5y
         EwOUJkiPrvLtX/7bpKLfAnxh2vyTbgiK6wCNv3UMt0Va4bymA0TLhQj/ivyP8dyDtLNo
         zqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8EsXEVewGQUIoSM+UlPZ73/5m+s95O2C6CusK+YxF1k=;
        b=j7WwSfAEPoOYQAsdwBhbGvYBm0uxha/4tyj07PBjBwKXTLUranTnlRz7SGfh/xasUC
         3HbpRe/Fo9vuvssummfRx7Fc/UbjtHu3IMdBDNMCInNkF+OP3+H7scy38quYpbSIsliN
         kMhMW45PCWj2Q6pNitj99KAnDP8rCg6S1TjNum1FT4maZU4EvSgXz0ORpJut5O6tsJpZ
         PZguGb3zvUyJjxcYJ7Keyr79iit9BP+W4yycEr0ikSLh6uOxrvhGsS2NwLIQU8D/QA2Q
         hRVb2FYCReucfhsai5Gl7hYirrK2pQYFIZuozT3QFWTQ5Wanusp9haoTGIpUYXUMkE1j
         HkqA==
X-Gm-Message-State: APzg51BPpIa8XirzrAtbP5ScNtP52TMSAzoMHLm3kfRxiotWIY2qjC9S
        hpUjAJXXjfC3gDliKv7u7e+Gopda3kg=
X-Google-Smtp-Source: ANB0VdaMh4dXC9D7JGjKPtaUXCRtho2B5JeZx4ubohVXbVwOGAkvOv/5Di8ZpeAya8ddVsP1De5yGQ==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr39485241pfb.29.1536140024959;
        Wed, 05 Sep 2018 02:33:44 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id y4-v6sm2008744pfm.137.2018.09.05.02.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Sep 2018 02:33:44 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 8+" <stable@vger.kernel.org>
Subject: [PATCH V4 03/10] MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
Date:   Wed,  5 Sep 2018 17:33:03 +0800
Message-Id: <1536139990-11665-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
References: <1536139990-11665-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65941
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
