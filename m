Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 22:15:30 +0200 (CEST)
Received: from mail-lj1-x242.google.com ([IPv6:2a00:1450:4864:20::242]:44964
        "EHLO mail-lj1-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeGTUP0Vkv00 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2018 22:15:26 +0200
Received: by mail-lj1-x242.google.com with SMTP id q127-v6so12067743ljq.11;
        Fri, 20 Jul 2018 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=74SSK+YvwPJw8a7XuH/8OaCpBh2qG5nXP4WSsVG/Iko=;
        b=aR/MWyDnoJ93PqmpGLRZsAEgCdCOvopfPOSsPTdzVYKm8vgypRcAewRz/jhhqhBY3E
         g1qKIrIw1KFbCqHvcC+0v8ciJ3rfQvWi5XFtx+mCblGWPSUKP5AQoC4aiencCu1DkcVF
         6l2ZnoXJ5WePkFyBdDPEeeNVHuTGb4l0D+KZOwQrbROFbOKxBgvtMXg6hj/pt+ICd+a0
         xpvXGu+eCS8s/w/AkquTD0ebK/aJrwzxw3gQ/GgcO+lNyY4t3lkWg5nLLiRg+gq64YcX
         9tLKooDlnBi2isLp+N/hMUDxpOcR8t1iZZULZdsrZgrdrUyD/E8h86ciNL5j6InBfnuo
         ygJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=74SSK+YvwPJw8a7XuH/8OaCpBh2qG5nXP4WSsVG/Iko=;
        b=JFaeMosJilCb1tq0s6j8n1ursjo5QVPCTpO9xpzJwoSqIe7BZMhoJKvIkAswbl5SMe
         pU+XZootrreqdk314/x2+QIzHOWvGHOrCv0KBBOg0gFjjCKZAv4yVcEIeE5xqQ7VchmI
         0ge9MKdhCpK8iobr1XiFljf8hjkctITgg1qbX+tcns90X8zM4Un3oqE327kUMar2oc/c
         KYeh/Bpf6ItRuykWYfktT/x9qeUjvQVQvvnrAPZf78a6XRzAmtKcg99B0/91B0nUq0jJ
         aVQjWAECLVN+6cn7SsGjqwfzlkPmQgbVXa6o9RVubKosyJnmj/m/DImFTV7CHm3sKN8D
         YeZw==
X-Gm-Message-State: AOUpUlGZgB1vwhg20qI1xkUPKpQj/RkTqVWhFJncG82WAvuKqqEsTvt1
        zHOtSBrK+zNgheS+u9PQjqg=
X-Google-Smtp-Source: AAOMgpfJZMq6Dsm/5tg/UOU4LmMweNrth9oTU5NZz94wnS+f1z80x3dgxp+Ac0VCosWp3lPMGlwXrw==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr2754544lji.17.1532117720798;
        Fri, 20 Jul 2018 13:15:20 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id z5-v6sm411894lff.96.2018.07.20.13.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jul 2018 13:15:20 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     paul.burton@mips.com, jhogan@kernel.org, ralf@linux-mips.org
Cc:     hch@infradead.org, okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH] mips: mm: Discard ioremap_cacheable_cow() method
Date:   Fri, 20 Jul 2018 23:14:27 +0300
Message-Id: <20180720201427.18845-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

This macro substitution is the shortcut to map cacheable IO memory
with coherent and write-back attributes. Since it is entirely unused
by kernel, lets just remove it.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
CC: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Sergey.Semin@t-platforms.ru
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 arch/mips/include/asm/io.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index f613d1df66c0..cd170d920d55 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -300,13 +300,6 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
 #define ioremap_wc(offset, size)					\
 	__ioremap_mode((offset), (size), boot_cpu_data.writecombine)
 
-/*
- * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
- * requests a cachable mapping with CWB attribute enabled.
- */
-#define ioremap_cacheable_cow(offset, size)				\
-	__ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
-
 static inline void iounmap(const volatile void __iomem *addr)
 {
 	if (plat_iounmap(addr))
-- 
2.12.0
