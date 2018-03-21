Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2018 15:53:55 +0100 (CET)
Received: from forward100p.mail.yandex.net ([IPv6:2a02:6b8:0:1472:2741:0:8b7:100]:41800
        "EHLO forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993070AbeCUOxhARqyx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Mar 2018 15:53:37 +0100
Received: from mxback14g.mail.yandex.net (mxback14g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:93])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 5B62651065AD;
        Wed, 21 Mar 2018 17:53:31 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback14g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1ycua7co6J-rUouaZTe;
        Wed, 21 Mar 2018 17:53:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521644011;
        bh=eRqHaUPDA0lsPGqOL+/+SNN84e1P/qhrYZXAeHjUDpk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=LZfEM0xdmkcXQjxc87i6/sfhUbkbpZt2xbmPq7wpf5oho6JQC9kYxhS47H+25t++N
         W6SAmtXuYjk6e6ZOPVsq3ERC5C+yUnIuRi1h5wdJjaRUN80TQACXx+X3Y8V/m3H0DW
         VU+UNVX95wLdgu4suQM0R50zTSumfGfTtBfrH8gg=
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id Tlo5VWq6Rp-rPi4f9UL;
        Wed, 21 Mar 2018 17:53:28 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1521644009;
        bh=eRqHaUPDA0lsPGqOL+/+SNN84e1P/qhrYZXAeHjUDpk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=RGh6hQwcGhc7Lskn/XtQ8ZnY2vKKx6nLUj5cIPo/se+avTg8bgTyYXdAIg0JzOz3o
         ZCXJl/7MEO7porj8vefjr5LIwZMvpjlXtRhiNllWlm8Ms5CGc065xY1RzpbtIcbwGA
         fKdPVqmiBiWommqtbgB+0xX5STg1/EybIf3phG2A=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@flygoat.com
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     jhogan@kernel.org
Cc:     chenhc@lemote.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/2] MIPS: Loongson64: Define has_cpu_mips64r2_user for Loongson-3
Date:   Wed, 21 Mar 2018 22:53:04 +0800
Message-Id: <20180321145304.4639-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
References: <20180321145304.4639-1-jiaxun.yang@flygoat.com>
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63090
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

All loongson-3 processors support mips64r2 usermode instructions.
However 3A1000 3B1000 3B1500 should be treated as mips64r1 in kernel.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
index 581915ce231c..71c893249374 100644
--- a/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h
@@ -49,6 +49,7 @@
 #define cpu_has_wsbh		1
 #define cpu_has_ic_fills_f_dc	1
 #define cpu_hwrena_impl_bits	0xc0000000
+#define cpu_has_mips64r2_user  1
 #endif
 
 #endif /* __ASM_MACH_LOONGSON64_CPU_FEATURE_OVERRIDES_H */
-- 
2.16.2
