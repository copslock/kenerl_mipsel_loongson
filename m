Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 15:57:10 +0200 (CEST)
Received: from mail-lj1-x243.google.com ([IPv6:2a00:1450:4864:20::243]:46712
        "EHLO mail-lj1-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993097AbeGIN4s5et-C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jul 2018 15:56:48 +0200
Received: by mail-lj1-x243.google.com with SMTP id 203-v6so3136843ljj.13;
        Mon, 09 Jul 2018 06:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Lz9n33k6zDjpf5y3OZAwtxvxwQxZJ33mT7WTAFWVG+w=;
        b=WtgzlADw9ZDPfND1dVhKV1NHGmzErrduPLYcPqnqN5hqxKrb4av7X33RbUwC+92T22
         pr/29Hg9fvVzkKD8Om7EdihtR8ifvsxYDd7BDShhhHBJ/MFSL6mJTqthtWVviDZ0h/Kt
         5oy/V5j7R3DuwV53PaRoXcpjopSiYyMBqoWmvmOved7XSFoAJ0XnBOyvlKtSV6A51nX2
         29s12SEDgec3Bji2Tw8d6m1USiH4QFElniHY2EeySkuMZYw1XiTceB7OKKGHs7AobdCW
         XNoy+zh9VmWoQgLaP0yeIm8XrRNaYg9Ep0Nsrp2JjI146fY8zW+ZYO9zv1HRhqkOWr7Y
         dlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lz9n33k6zDjpf5y3OZAwtxvxwQxZJ33mT7WTAFWVG+w=;
        b=nQFBAYHi3DIZkNfttQlyh5PoB4zDWlEi6GlFIc6ARY2pj1wkbvWSTS4HcJnE5nKy5r
         X8geMQHOBcl3CcyyMwuk8obAhriy/Ys09xmbq1OX10T9M2txZoBvdxl1aPl6AQBuiNYi
         CMnSUl8vDK423nzmVLthbq3nIeAuVWW2AeFn2ypABtkBkHWw50NuGgGNv+T5OjjH5IPI
         AweFUoGITJUk64jwuSdLX0UzWAUSvTQn8eAFliGupz7wzhutlUqEbVIZFLtRV1+Tixke
         1A2KNiCyQEeLKfiDHJ4AXt1VFTe7CjP7uYCpmkmCm0LDaPhvkb+vWbDE2NtZlWpne/0k
         MMYw==
X-Gm-Message-State: APt69E2f6JlNyMZzHUdWyRAl+X3uf8r5nwsxVRAWfRWoZvKZGeLxwISB
        HnttpUA1C6ON9NOxUjNFURasxmaf
X-Google-Smtp-Source: AAOMgpfWY6L3kH6IZ/Ncy4sqTzfSx22QBrwZP4kQPox+1ONxHIXvN+mcyJ6umwp7EHnzuYMmveIn4A==
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr5205532ljj.139.1531144603232;
        Mon, 09 Jul 2018 06:56:43 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id g12-v6sm4076662lfe.1.2018.07.09.06.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 06:56:42 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] mips: mm: Discard ioremap_uncached_accelerated() method
Date:   Mon,  9 Jul 2018 16:57:13 +0300
Message-Id: <20180709135713.8083-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180709135713.8083-1-fancer.lancer@gmail.com>
References: <20180709135713.8083-1-fancer.lancer@gmail.com>
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64713
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

Adaptive ioremap_wc() method is now available (see "mips: mm:
Create UCA-based ioremap_wc() method" commit). We can use it for
UCA-featured MMIO transactions in the kernel, so we don't need
it platform clone ioremap_uncached_accelerated() being declard.
Seeing it is also unused anywhere in the kernel code, lets remove
it from io.h arch-specific header then.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Singed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
---
 arch/mips/include/asm/io.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index babe5155a..360b7ddeb 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -301,15 +301,11 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
 	__ioremap_mode((offset), (size), boot_cpu_data.writecombine)
 
 /*
- * These two are MIPS specific ioremap variant.	 ioremap_cacheable_cow
- * requests a cachable mapping, ioremap_uncached_accelerated requests a
- * mapping using the uncached accelerated mode which isn't supported on
- * all processors.
+ * This is a MIPS specific ioremap variant. ioremap_cacheable_cow
+ * requests a cachable mapping with CWB attribute enabled.
  */
 #define ioremap_cacheable_cow(offset, size)				\
 	__ioremap_mode((offset), (size), _CACHE_CACHABLE_COW)
-#define ioremap_uncached_accelerated(offset, size)			\
-	__ioremap_mode((offset), (size), _CACHE_UNCACHED_ACCELERATED)
 
 static inline void iounmap(const volatile void __iomem *addr)
 {
-- 
2.12.0
