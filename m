Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Dec 2017 05:22:12 +0100 (CET)
Received: from forward100o.mail.yandex.net ([37.140.190.180]:50016 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990408AbdLZEWFwDYSE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Dec 2017 05:22:05 +0100
Received: from mxback14j.mail.yandex.net (mxback14j.mail.yandex.net [IPv6:2a02:6b8:0:1619::90])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 9BEA22A22AEE;
        Tue, 26 Dec 2017 07:21:57 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback14j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id iHkMyDZUHA-Lv44KFhh;
        Tue, 26 Dec 2017 07:21:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514262117;
        bh=mWsamBy/M+bD66Z2nOkcDtwdp+6ymDpMCLTySLpx15w=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=VxlC5c1/7ZyMxmtHAvuwO4kGLk0Ywh+SspEvBEL9YG/kNjtmJyjpeWoUAVtrpuguY
         zsL6mJAeh28h6XFktsdeWh6bsQP91hPBOAnmnaiyLK/c0SdWEZXuaudIMfdr4/HUF8
         v5HVJ0LzmEkZD+jhLjkPRiKY+jsX79Phr2/SSR9s=
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id UmMYrqi78G-Lq4mB0bn;
        Tue, 26 Dec 2017 07:21:55 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514262115;
        bh=mWsamBy/M+bD66Z2nOkcDtwdp+6ymDpMCLTySLpx15w=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=N32uhH9O9gmmR6EF4xfxbhRRsxbiLP6Ns3wkJPYlqjIcxo+PyZOIUpoyGDqahudLD
         EEF0yD1w8ZjZ2unFbyuk8uv+LfL/rcwu722rKDAu7G/KDPBNxLSRHGzDLoRsBk1WK6
         ZJ/zw9WVAiQDgDnmOmuLqzhV4yD4fs3sVz1AHpBA=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] MIPS: Loongson64: Drop 32-bit support for Loongson 2E/2F devices
Date:   Tue, 26 Dec 2017 12:21:38 +0800
Message-Id: <20171226042138.13227-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

Make loongson64 a pure 64-bit mach.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/loongson64/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 0d249fc3cfe9..a7d9a9241ac4 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -17,7 +17,6 @@ config LEMOTE_FULOONG2E
 	select I8259
 	select ISA
 	select IRQ_MIPS_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_HIGHMEM
@@ -49,7 +48,6 @@ config LEMOTE_MACH2F
 	select ISA
 	select SYS_HAS_CPU_LOONGSON2F
 	select SYS_HAS_EARLY_PRINTK
-	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL
 	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_LITTLE_ENDIAN
-- 
2.15.1
