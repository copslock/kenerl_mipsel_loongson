Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2018 03:37:00 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:34267
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992781AbeCACga3KV48 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2018 03:36:30 +0100
Received: by mail-pf0-x243.google.com with SMTP id j20so1859916pfi.1;
        Wed, 28 Feb 2018 18:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=olT+xjNhKYaC2uJjOCMT9k0Q+/kv0Qzl5NAjKncz3LU=;
        b=FBer8WtMBLnd9V1cg3rZSed95F6dn+BiUORBzWV5428Xor34aKGhDqxK4ny8ljyD8x
         2NuDbxyWholcSFRHu35XLU0pa4zz+8C1L3lp709t4t2Cb0QVGu06D8eLW0wdIsYUz93C
         2g93dvWoHKFLMqN0griXfDg2xgmLVdYDW0YekN3bswmH8zD8pXgJhNEqTHuvejvW2luB
         YMUgBnkprY6Rhmrmamb/otYISL9ZMp/7bPGERwYS0qBSO0Jy2ieCg7Z6RO3qFHk714ei
         /KrUgT+rZDsvxv5tyLFpJ3Ud2/Xp1YuAt7oIqPTxk4xsXYT6HZoRLft2QvIp7xNiH2fo
         qXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=olT+xjNhKYaC2uJjOCMT9k0Q+/kv0Qzl5NAjKncz3LU=;
        b=c3dP8GFzoqmJ/sXLzk/y+8hJ8okJEogsq2G1WJfjv8abvUKGHKwEcdix7vWWvtAJr6
         KzRpAN1+Tsgl5tN2JZUAfOgCBNI9dpF8pbxEzF9j/MRlkKcIb6alKutjE9v6bk2WXxrF
         lvNaR92yDGIaRDtjGWq7dTH8D/FRJR2f7StrLYSiXXC7f2kmKHNRt8PimBGpzG2maZWZ
         SRmz2VpAuVweBmomqle29s/T2CqTri4QkFqSG0AZRcoLVTeXRJYV8V9eCGDx+O1y9ldU
         UvibrpdnqZEtC2uNemwKQ8p4MobtF0jr7xTqNqzkz02Bi7iotyqgWdQAKCAXEvze3Re7
         AGWw==
X-Gm-Message-State: APf1xPDipdHXRiGhorSTc+MHsXCcAv7jEGxFGYkC8aC7P30YS4gpSNLd
        caLp4ItjuLaz3a1u5kMXeYeGLg==
X-Google-Smtp-Source: AG47ELuueYnX+7ySse+WI9EIzqEU8/I6q+W8Jiee9K8CPBmnDwYuIEQe9S/tlzt4Y3Z0EKdaPYqXhg==
X-Received: by 10.99.127.65 with SMTP id p1mr260231pgn.50.1519871783838;
        Wed, 28 Feb 2018 18:36:23 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id e83sm5987745pfk.148.2018.02.28.18.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 18:36:22 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V2 2/2] MIPS: Loongson64: Select ARCH_MIGHT_HAVE_PC_SERIO
Date:   Thu,  1 Mar 2018 10:37:42 +0800
Message-Id: <1519871862-14624-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1519871862-14624-1-git-send-email-chenhc@lemote.com>
References: <1519871862-14624-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62758
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

Commit 7a407aa5e0d3e587 ("MIPS: Push ARCH_MIGHT_HAVE_PC_SERIO down to
platform level") moves the global MIPS ARCH_MIGHT_HAVE_PC_SERIO select
down to various platforms, but doesn't add it to Loongson64 platforms
which need it, so add the selects to these platforms too.

Fixes: 7a407aa5e0d3e587 ("MIPS: Push ARCH_MIGHT_HAVE_PC_SERIO down to platform level")
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/loongson64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 12812a8b..72af0c1 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -8,6 +8,7 @@ config LEMOTE_FULOONG2E
 	bool "Lemote Fuloong(2e) mini-PC"
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	select CEVT_R4K
 	select CSRC_R4K
 	select SYS_HAS_CPU_LOONGSON2E
@@ -35,6 +36,7 @@ config LEMOTE_MACH2F
 	bool "Lemote Loongson 2F family machines"
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BOARD_SCACHE
 	select BOOT_ELF32
 	select CEVT_R4K if ! MIPS_EXTERNAL_TIMER
@@ -65,6 +67,7 @@ config LOONGSON_MACH3X
 	bool "Generic Loongson 3 family machines"
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
+	select ARCH_MIGHT_HAVE_PC_SERIO
 	select GENERIC_ISA_DMA_SUPPORT_BROKEN
 	select BOOT_ELF32
 	select BOARD_SCACHE
-- 
2.7.0
