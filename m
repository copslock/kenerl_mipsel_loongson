Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 15:56:56 +0200 (CEST)
Received: from mail-lj1-x244.google.com ([IPv6:2a00:1450:4864:20::244]:35835
        "EHLO mail-lj1-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992747AbeGIN4pYwcuC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jul 2018 15:56:45 +0200
Received: by mail-lj1-x244.google.com with SMTP id p10-v6so8757103ljg.2;
        Mon, 09 Jul 2018 06:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HH5lNU/xQ4ewQdE7lfMKkvdCC1oLo1y6fg3RnXQ/fAA=;
        b=g0m68q8aLdAOzq/D/l7+L0XagH5AmUrW40B6TxsU2YU9yWomfeClOnn4W5TBfH51ni
         CN+P7Nlkwbp1zJT/cZHfv8LTEfQ/4aFjepceZhz24KSn4uHrvBB9lyijs94T4F4WDbpc
         6q1rk3q56TVEVTwF1+ydCSV48JICzg+RsOT1i78dRlo0JSH0Vd+R2LGsHpAoTAF2h73r
         /ED7ZdfNHjIemFmEy7ekCkCtM94eizypCa5RnDSqR25Xocz3ekzmR/YvnoSMUlG4KaYI
         Aj/2EhnT3xG3uDqx3bNnFe6mpYyIJhRIwB9cD8dVUmO152pqggrZcwlYPsJnJZ3AL5tk
         VLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HH5lNU/xQ4ewQdE7lfMKkvdCC1oLo1y6fg3RnXQ/fAA=;
        b=KZAKUjCGEr9b0s3MBVDQ+6hN8pARk8pJtcMZQ8n+GXkfjWKoKs7SdLSp+I6gtSW6Kj
         y48dvGcP5VJIgYbiT+V3yyswarFx6h0OrEUpPRJzpsldeXc+n2j8tS5lsGNMz0wZr7PN
         X0UV+ypjRc2foKidQTqM9xMQL+hSs11L5rOlvGnDNLu0bW/NKkqPxjQQGrWK36LWLdIE
         WGI3Gs1kVOx3uKPTCBlnu/0ARCeQMbUw1FLRV+Qe9ZZx2sutSQymShcAwptvhz1EJSGv
         khZgv9ZobuiwlV0ik96L7rfgbZf0OOENPlxnAydXU/lhFD0ma1k/1x7GlMerAYMjzAmA
         sLuQ==
X-Gm-Message-State: APt69E3Q2RuXKSlSVwFM3izmfOcmGY+duvNjqCOjm7SkMEtgycWpBxv4
        djQODVuJmXRPa4zlmXXUtQ68cg==
X-Google-Smtp-Source: AAOMgpetad43bj3BJOe0lsfAKdcV14mdAiyE/0OdXR0mI3jeBdPqCFVyU2iybJVtnIxmJLescl2pjA==
X-Received: by 2002:a2e:1b03:: with SMTP id b3-v6mr13470576ljb.24.1531144599357;
        Mon, 09 Jul 2018 06:56:39 -0700 (PDT)
Received: from linux.local ([5.166.218.73])
        by smtp.gmail.com with ESMTPSA id g12-v6sm4076662lfe.1.2018.07.09.06.56.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 06:56:38 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     okaya@codeaurora.org, chenhc@lemote.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] mips: mm: Create UCA-based ioremap_wc() method
Date:   Mon,  9 Jul 2018 16:57:12 +0300
Message-Id: <20180709135713.8083-1-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64712
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

Modern MIPS cores (like P5600/6600, M5150/6520, end so on) which
got L2-cache on chip also can enable a special type Cache-Coherency
attribute (CCA) named UnCached Accelerated attribute (UCA). In this
way uncached accelerated accesses are treated the same way as
non-accelerated uncached accesses, but uncached stores are gathered
together for more efficient bus utilization. So to speak this CCA
enables uncached transactions to better utilize bus bandwidth via
burst transactions.

This is exactly why ioremap_wc() method has been introduced in linux.
Alas MIPS-platform code hasn't implemented it so far, instead default
one has been used which was an alias to ioremap_nocache. In order to
fix this we added MIPS-specific ioremap_wc() macro substituted by
generic __ioremap_mode() method call with writecombine CPU-info
field passed. It shall create real ioremap_wc() method if CPU-cache
supports UCA feature and fall-back to _CACHE_UNCACHED attribute
if one doesn't. Additionally platform-specific io.h shall declare
ARCH_HAS_IOREMAP_WC macro as indication of architectural definition
of ioremap_wc() (similar to x86/powerpc).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Singed-off-by: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
---
 arch/mips/include/asm/io.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 4d709b61d..d4f8cdc58 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -12,6 +12,8 @@
 #ifndef _ASM_IO_H
 #define _ASM_IO_H
 
+#define ARCH_HAS_IOREMAP_WC
+
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -278,6 +280,27 @@ static inline void __iomem * __ioremap_mode(phys_addr_t offset, unsigned long si
 #define ioremap_cache ioremap_cachable
 
 /*
+ * ioremap_wc     -   map bus memory into CPU space
+ * @offset:    bus address of the memory
+ * @size:      size of the resource to map
+ *
+ * ioremap_wc performs a platform specific sequence of operations to
+ * make bus memory CPU accessible via the readb/readw/readl/writeb/
+ * writew/writel functions and the other mmio helpers. The returned
+ * address is not guaranteed to be usable directly as a virtual
+ * address.
+ *
+ * This version of ioremap ensures that the memory is marked uncachable
+ * but accelerated by means of write-combining feature. It is specifically
+ * useful for PCIe prefetchable windows, which may vastly improve a
+ * communications performance. If it was determined on boot stage, what
+ * CPU CCA doesn't support UCA, the method shall fall-back to the
+ * _CACHE_UNCACHED option (see cpu_probe() method).
+ */
+#define ioremap_wc(offset, size)					\
+	__ioremap_mode((offset), (size), boot_cpu_data.writecombine)
+
+/*
  * These two are MIPS specific ioremap variant.	 ioremap_cacheable_cow
  * requests a cachable mapping, ioremap_uncached_accelerated requests a
  * mapping using the uncached accelerated mode which isn't supported on
-- 
2.12.0
