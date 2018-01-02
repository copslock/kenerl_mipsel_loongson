Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 16:39:53 +0100 (CET)
Received: from forward103p.mail.yandex.net ([77.88.28.106]:34636 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992692AbeABPjqs3Pe1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 16:39:46 +0100
Received: from mxback11j.mail.yandex.net (mxback11j.mail.yandex.net [IPv6:2a02:6b8:0:1619::84])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 31B6321829D1;
        Tue,  2 Jan 2018 18:39:37 +0300 (MSK)
Received: from smtp4o.mail.yandex.net (smtp4o.mail.yandex.net [2a02:6b8:0:1a2d::28])
        by mxback11j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id CZD2mY2KI3-dZuGA3J0;
        Tue, 02 Jan 2018 18:39:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514907577;
        bh=I4/8rFy4IjB4J0UDNuif7iXV7PP16Y8S/s52ntzcEaQ=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=Pun+eqfGf6AmlNpF96VNOmROsxCPQj7oJI/vQcXpx7e76U1707dYEngGORPyBp6wq
         XmyeGG9WcYueOJt++OV8QWg27AXwSATD31J/re/1uyAjeT+MIZ1H3NvcaKJCQosYsc
         Sxs00KlyJ3wG15zTGrT+rKAI7D/rqite7d8tJ9p0=
Received: by smtp4o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 3G1MmcJZtH-dVjCfgFs;
        Tue, 02 Jan 2018 18:39:34 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1514907574;
        bh=I4/8rFy4IjB4J0UDNuif7iXV7PP16Y8S/s52ntzcEaQ=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=kaBtV+P55sLxK0b2c+mMp876Dp/7nuJYrkO5iUlYyTXmQzqaDpYiRWTIzj6phZzgo
         p9o9rv8Qp7P5O+U/M8q/X0nBsGVOcNuWnRew0sVbhs1HdfD3SuhFqkzOYJ3cKRvGWu
         hvSd0HanE0xarXHFLYZKY93Kz0Dux2B/ro4xr93o=
Authentication-Results: smtp4o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     James Hogan <james.hogan@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2] MIPS: Loongson64: Drop 32-bit support for Loongson 2E/2F devices
Date:   Tue,  2 Jan 2018 23:39:17 +0800
Message-Id: <20180102153917.4563-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.15.1
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61844
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

The 32-bit support was broken at runtime, it doesn't boot anymore,
witch is hard to debug because even early printk isn't working, also
there are some build warnings. Some newer bootloader may not support
32-bit ELF. So we decide to drop 32-bit support.

Make loongson64 a pure 64-bit arch.

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
