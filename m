Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Oct 2018 03:20:54 +0200 (CEST)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:42041
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991923AbeJPBUukqYj6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Oct 2018 03:20:50 +0200
Received: by mail-pf1-x444.google.com with SMTP id f26-v6so10553840pfn.9;
        Mon, 15 Oct 2018 18:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=sNv9Y/BGAtGC/cMdkRT4mT++Ot2Su8tQPD1xHYLBQyY=;
        b=ZleZMesWl2BkdQCf6msKnYAuwpwt0AoTn78XwE5zv1h6X72rh6YYfZpf6Gv/YXswx1
         qFwkPekgZF7wl3ZkKvjC9ct8mTZsdtCPcQYrF6wIetj1Bs40niOtGDfaP2PuVdF/FgA7
         i6GG22HnkpFxNexk22wYKAbbhwRgtonmlXYiDfDp+hBT2nIoyKNANFfh9L+JhfiEgnTz
         lY2TuBoa8ruzolgFMBxwYWiRm3cUzXlEZTrRSVnRh1g5Cvoeuf/uUa47rGlsTmp0XBW1
         aJ++h/tTvy3O+oNwh8r8tJWjQ0asMmTFuPQp9Tl3b9qi3yGZN5bsCoDwq2NqVa9QIKxh
         0njA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=sNv9Y/BGAtGC/cMdkRT4mT++Ot2Su8tQPD1xHYLBQyY=;
        b=fcBuzGxxpWm4jR8wkTlIB4JJbuwtzFtXVJnXLBFycVpK20oRjpcjg5CWH5z93cC/GO
         xww4N9MJUsyy8MpbzSxAiAgHEcFO5c9SOQNSTLnLa7DwZDw44GysN/wTXY0yhWZRM8cR
         f5gnoFJHZNslHDyVwL8MqHvS06+hs2SPmXpVDLqO7RzF+XPrC/gVm1DyL3aFJ/ng/apF
         NKLggnGFP+5WzWm0lFXawrDvNUl9obrjr3g5rc8HHQadAXYW8c+hBmqF2AZjTIbhdFH0
         OroMOEg+7IlMOyXHddyXEd4HdzOI6YFXUtV/GdxzwCUCtz0Ox6G6K8Yq/SExiajQjSnD
         s2cw==
X-Gm-Message-State: ABuFfogWXy6PAgIrIwlo4x6we3e7cdlH4cm0d2zEukUxOAxvSoZVye6f
        fYCGrs2cNuLAio0n4unrWDzv1oiWw+k=
X-Google-Smtp-Source: ACcGV60CmNQqLKMcqtJlImQEL0w8oq7PMfjT6ymUMIkxfTbcRrzkzTBR4/qjP/osbENsdUEfOecqIw==
X-Received: by 2002:a62:aa17:: with SMTP id e23-v6mr20008787pff.211.1539652843772;
        Mon, 15 Oct 2018 18:20:43 -0700 (PDT)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id b3-v6sm18988867pfc.178.2018.10.15.18.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Oct 2018 18:20:42 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH] MIPS: VDSO: Reduce VDSO_RANDOMIZE_SIZE to 64MB for 64bit
Date:   Tue, 16 Oct 2018 09:20:42 +0800
Message-Id: <1539652842-26060-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66859
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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.7.0
