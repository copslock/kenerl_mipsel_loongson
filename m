Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2018 04:21:19 +0200 (CEST)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:43422
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeGICVMbdHXs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jul 2018 04:21:12 +0200
Received: by mail-pg1-x542.google.com with SMTP id v13-v6so935634pgr.10;
        Sun, 08 Jul 2018 19:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=65Ss1AK1RVwMQ4wi054OvHZUQUstvxv0rZcSgNaL2rI=;
        b=N1+P5twK4MvxMp8ajE/cuvKMZR/7zAPyY8zx44+Upv3ka6VNHfK7cfLOhVtqQ4zU79
         UbM9zacH45lrK/k99AUtmSk7S9Zrq1o4mzTmQxg4lLWxoW3KYD4rsGbpMCcWjweVaVi8
         4j7AmWWDrq69FoAwjzsaqYkpPq/v2Q8Y/S+M60X6k5V5aqbwBJQW79Ovli1ZhiuisZT3
         uYbV2D1aUib/NFwBN6MzQgIP9CCLZ0Fj0eCmqKvK2R9TfFm/QFcstx9sgOmF2WR8QkLj
         o9zhaNfK3zs8Wc5Y6c8KPW9RAYBTJSPoSguT42TCRer4Hy24GeIxgjEgoiKCsEKuwP2/
         jbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=65Ss1AK1RVwMQ4wi054OvHZUQUstvxv0rZcSgNaL2rI=;
        b=GBMqBDcCC0EFsgYtcJejDKWZEQ/D0YpbaT0ogoh4+0txE+iSlnDhV5LAyLHA8N/ffr
         GdPld2lD2eUH+ELa6CNbt2W7miMsA0Ywg9oVfyKsHpfiHb+ymFZqG6rp9ItR505KeZfR
         u8ZiWNjnAkeypn4GOsJJE8LM4ZqnJqA4NiBeW3maUrzeBr/+ULtcgleN1+2Cs1hsBj4o
         ijku4epkOQ0lM7aytaBTlBrDtKllLhXV2o8nk/4MTqUBh6C32tklS3ULY0mO4POHYhzd
         s3qSTy7rTjgoNCnHsZco1yVVchNzgWkgrSKaIY2HNLIJW5PIZI2rh8Tl/jU8DySlYYab
         8ekw==
X-Gm-Message-State: APt69E2LRClO6F9iNlyfjsoXWTNYt7VV7bWqAyBbi3P02fztFjS5RmmL
        W9z3OuGJ14wIpZcGB1EDs0te0v2Qtq4=
X-Google-Smtp-Source: AAOMgpdlHDeLsjpJnofVxn2k6cwO/tH+liaHq3Xi1Cz7X+URwYTLDiEIxIGRwAID83hs9qFxyL6WuA==
X-Received: by 2002:a65:5106:: with SMTP id f6-v6mr16969251pgq.72.1531102865664;
        Sun, 08 Jul 2018 19:21:05 -0700 (PDT)
Received: from software.domain.org ([104.251.228.27])
        by smtp.gmail.com with ESMTPSA id v15-v6sm27190743pfk.12.2018.07.08.19.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jul 2018 19:21:04 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Date:   Mon,  9 Jul 2018 10:26:38 +0800
Message-Id: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64711
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

After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
has SFB (Store Fill Buffer) and the weak-ordering may cause READ_ONCE()
to get an old value in a tight loop. So in smp_cond_load_acquire() we
need a __smp_rmb() before the READ_ONCE() loop.

This patch introduce a Loongson-specific smp_cond_load_acquire(). And
it should be backported to as early as linux-4.5, in which release the
smp_cond_acquire() is introduced.

There may be other cases where memory barriers is needed, we will fix
them one by one.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/barrier.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index a5eb1bb..e8c4c63 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -222,6 +222,24 @@
 #define __smp_mb__before_atomic()	__smp_mb__before_llsc()
 #define __smp_mb__after_atomic()	smp_llsc_mb()
 
+#ifdef CONFIG_CPU_LOONGSON3
+/* Loongson-3 need a __smp_rmb() before READ_ONCE() loop */
+#define smp_cond_load_acquire(ptr, cond_expr)			\
+({								\
+	typeof(ptr) __PTR = (ptr);				\
+	typeof(*ptr) VAL;					\
+	__smp_rmb();						\
+	for (;;) {						\
+		VAL = READ_ONCE(*__PTR);			\
+		if (cond_expr)					\
+			break;					\
+		cpu_relax();					\
+	}							\
+	__smp_rmb();						\
+	VAL;							\
+})
+#endif	/* CONFIG_CPU_LOONGSON3 */
+
 #include <asm-generic/barrier.h>
 
 #endif /* __ASM_BARRIER_H */
-- 
2.7.0
