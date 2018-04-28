Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2018 05:22:32 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:44386
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbeD1DW0NEfhZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2018 05:22:26 +0200
Received: by mail-pf0-x244.google.com with SMTP id q22so2803774pff.11;
        Fri, 27 Apr 2018 20:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8EsXEVewGQUIoSM+UlPZ73/5m+s95O2C6CusK+YxF1k=;
        b=Ky04Tyn3SqCYfiMLIhqBeMJXPEq+59aMW/Y9QJ6fyYg4kSlizEMj/V4OrUqJuwGyOW
         ob4xJKQP/YES8sDsoAvcBYDu7hPdgzdpjrfPF8cNlxBsq0ZIujJg101cwj9dh1d1678f
         TS90Z1a58eu6vMpOWC2y26bsMxg0BUDWp94H3Olz6s5XTuVOsUn0mA8hfNh6fDtJ/Sj1
         LgnpY9TRpZEZ2BzxQtSHa4lO0m0+1KklGKqUKXbLxPLtI8tFYHoUalm4v36xQKfaFvqu
         BlajuqBSQbdbrYAYvViIl1TTNB5O0DecdERWmXTd0WFn1HLtv286bgdddihHTQsP9uuh
         zyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=8EsXEVewGQUIoSM+UlPZ73/5m+s95O2C6CusK+YxF1k=;
        b=qcW60UYF2Paox8TsqBYfcySwS4KQX3WSRbwakb69o/2+Ub2YuHuRZzmQayCLy4h8CJ
         I7k9uBxP+yrWmJJTeCHUG2mvutWbEU3Zjcpfi8CzdBKWEfJrDCoyRYIjRlAb2zb0Gsxs
         415tdS9OowsJHheO48ht427njYECo7Q9kyaAqLW2aHvbsq0tJysnBVyCCeJxWeuiC7+g
         Fn5DNVl4Z0I0D5coPc9RNLtejQarsccIb7LgszephalIrO5e2jpelTD+wvql5u/jbf/7
         vY6j+lgh1y+6NMvUrmWbPXLjnyhSwUk48toL9tueIaCKHSMQw7fzxelP2kQw+aoesXAY
         mrdQ==
X-Gm-Message-State: ALQs6tCC2vgODFbeen1tIVouJ/ZprE7KZTUOLZFUb3zWtJtrNeJAm9To
        OfEL7kj1KyVrtROu8EI6HYMw3A==
X-Google-Smtp-Source: AB8JxZrOPaMHC0dmmCHqlXMnhHC2c9xOt6D6R3EIjILucS5IcoBQbn4JYHNFY2ZSzXtoVZdOjWN2kQ==
X-Received: by 2002:a17:902:20eb:: with SMTP id v40-v6mr4504982plg.277.1524885739910;
        Fri, 27 Apr 2018 20:22:19 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id g72sm7148114pfg.60.2018.04.27.20.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Apr 2018 20:22:19 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        "# 3 . 8+" <stable@vger.kernel.org>
Subject: [PATCH V3 05/10] MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
Date:   Sat, 28 Apr 2018 11:21:29 +0800
Message-Id: <1524885694-18132-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
References: <1524885694-18132-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63823
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
