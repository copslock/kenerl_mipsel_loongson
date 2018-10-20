Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Oct 2018 15:01:53 +0200 (CEST)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:34846
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993094AbeJTNBuJWPQf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Oct 2018 15:01:50 +0200
Received: by mail-pg1-x544.google.com with SMTP id 32-v6so5790020pgu.2;
        Sat, 20 Oct 2018 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=SCmvQuGUsWvuG8jwObhwg7Y+rrLQaWUd2QUqs7Rjibg=;
        b=jYoIP2zr/0ugNShokrQtKL5cjzH25i2YITd15vYRsExJ7IyKAwVxIJTYJkdJ9RxqrX
         8lwZctwyWo4wzgtFIKGvlXFNKQX8FjVrctjMI3dziiukkU7jq8h4wOPBQXbhKzpIFrdZ
         Eh+vdSO/jNAAyeEwEVy4urHFSHlBLLWPOpjHoB5ucXFLYy0VWVaxOBvQVDiAhh9MP33k
         wrrQMW4P3YxFwtlVtn2wTdReaCrLir89kSjHE2j4BwkDggMJ0ItQKGS15NQww3RvpHFT
         +yJCeJfnY/5H+s/OzJy6G0I3ANzZwzOu0F1rceERuiEnAPB/oicFg+4Qt1g12rv+yR3H
         kz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=SCmvQuGUsWvuG8jwObhwg7Y+rrLQaWUd2QUqs7Rjibg=;
        b=Lc0dQFWP+tPdfDxZMHk/g9nYXfklGrWx7/5uuT/xb2MIGN+WCx6a4c3Nwmn6qSwzPR
         G+8M+6+CRyuAlfHczlJ2aAi7auAeEATYCbI2v9nNwpO6RgK5APahZPJ8RQoiAUtsrp7M
         KqhBniNdznyDYI3L4CGeslHz+SxyO4jqebkfGVK+mfhmVfM+MDSvmad00Y+qhctLl2WU
         fmFfnkpoedKxe5XCak0nSIu5bZxlTeByxmVtFKHGhkvd3fL4JoEo45UE5pSsAIN8P2SX
         8MEHy4WR0evypFFfwhNm9tYENNM5e6AI5tmIEjlYJXZ5mDIF4hn8ZWzwM8XLjdXjp+ai
         Eoqg==
X-Gm-Message-State: ABuFfohMR0vUrzVgDovlCVefd0Mcir0hTMnd2fiW61z1NPK2YWcZg8+0
        Sv14gCjVrtGHzK970n+a4loYD7tkvN0=
X-Google-Smtp-Source: ACcGV60ht+sAyU/eVEu+tzx5LM59c+Zsr/Tp1SRStEtzWWSKccQyxvJ7r59cgmqGH14orjY63VjxAA==
X-Received: by 2002:a62:90db:: with SMTP id q88-v6mr37867164pfk.98.1540040503223;
        Sat, 20 Oct 2018 06:01:43 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id a64-v6sm33654941pfe.32.2018.10.20.06.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Oct 2018 06:01:42 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH V2] MIPS: VDSO: Reduce VDSO_RANDOMIZE_SIZE to 64MB for 64bit
Date:   Sat, 20 Oct 2018 21:01:31 +0800
Message-Id: <1540040491-16754-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66901
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

Commit ea7e0480a4b695d0aa6b3 ("MIPS: VDSO: Always map near top of user
memory") set VDSO_RANDOMIZE_SIZE to 256MB for 64bit kernel. But take a
look at arch/mips/mm/mmap.c we can see that MIN_GAP is 128MB, which
means the mmap_base may be at (user_address_top - 128MB). This make the
stack be surrounded by mmaped areas, then stack expanding fails and
causes a segmentation fault. Therefore, VDSO_RANDOMIZE_SIZE should be
less than MIN_GAP and this patch reduce it to 64MB.

By the way, not all VDSO_RANDOMIZE_SIZE can be used for vdso_base()
randomization because VDSO need some room to locate itself (in this
patch we reserve 64KB).

Cc: stable@vger.kernel.org
Fixes: ea7e0480a4b695d0aa ("MIPS: VDSO: Always map near top of user memory")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/processor.h | 2 +-
 arch/mips/kernel/vdso.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
index 49d6046..c373eb6 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -81,7 +81,7 @@ extern unsigned int vced_count, vcei_count;
 
 #endif
 
-#define VDSO_RANDOMIZE_SIZE	(TASK_IS_32BIT_ADDR ? SZ_1M : SZ_256M)
+#define VDSO_RANDOMIZE_SIZE	(TASK_IS_32BIT_ADDR ? SZ_1M : SZ_64M)
 
 extern unsigned long mips_stack_top(void);
 #define STACK_TOP		mips_stack_top()
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 48a9c6b..d6232d9 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -106,7 +106,7 @@ static unsigned long vdso_base(void)
 	base = STACK_TOP + PAGE_SIZE;
 
 	if (current->flags & PF_RANDOMIZE) {
-		base += get_random_int() & (VDSO_RANDOMIZE_SIZE - 1);
+		base += get_random_int() & (VDSO_RANDOMIZE_SIZE - SZ_64K - 1);
 		base = PAGE_ALIGN(base);
 	}
 
-- 
2.7.0
