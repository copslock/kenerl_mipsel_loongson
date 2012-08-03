Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2012 09:08:23 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:34067 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903526Ab2HCHG5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Aug 2012 09:06:57 +0200
Received: by mail-yx0-f177.google.com with SMTP id r9so506866yen.36
        for <multiple recipients>; Fri, 03 Aug 2012 00:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gq/HNgkjD5zgiDgKl7jxsfw2+xEw/5VYH6PnxXrZ72c=;
        b=nLVjaGi7krAhCjwopf/hGIFY4fpVZoOYqGymr8WjNYIQOVpr1qKSeeJ7X9tAxQ5apK
         9nndyDOjvdB6KK0dzYHqfxA0xzf5k2XZTcaWNJD7iaYJ7j3ph/E5Y0wCeRgVMXZO2MMV
         oZB/wj647pqWsid0lN+o698Jg9b8Mqs2tf8QC4a206y0si/xw9KoxPjHQXVQ5zU4GjQu
         sM9W6jYhJnCkQ+TFXm49BUsyvL0ohGp3p5/RS5j5Mw0I/UCoS5hxUP92pjAqO8axbWW4
         A+sumqYsAoUD+NcYwTlzLmaGPXtvnEaPln60ySQl+P/TApf8H1KPhGAar9EcfTwzU4wy
         znag==
Received: by 10.42.18.130 with SMTP id x2mr1286405ica.5.1343977616219;
        Fri, 03 Aug 2012 00:06:56 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id z3sm20852677igc.7.2012.08.03.00.06.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 00:06:55 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V4 04/16] MIPS: Loongson: Make Loongson-3 to use BCD format for RTC.
Date:   Fri,  3 Aug 2012 15:05:59 +0800
Message-Id: <1343977571-2292-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
References: <1343977571-2292-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Hongliang Tao <taohl@lemote.com>
Signed-off-by: Hua Yan <yanh@lemote.com>
---
 arch/mips/include/asm/mach-loongson/mc146818rtc.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson/mc146818rtc.h b/arch/mips/include/asm/mach-loongson/mc146818rtc.h
index ed7fe97..6b10159 100644
--- a/arch/mips/include/asm/mach-loongson/mc146818rtc.h
+++ b/arch/mips/include/asm/mach-loongson/mc146818rtc.h
@@ -27,7 +27,11 @@ static inline void CMOS_WRITE(unsigned char data, unsigned long addr)
 	outb_p(data, RTC_PORT(1));
 }
 
+#ifdef CONFIG_CPU_LOONGSON3
+#define RTC_ALWAYS_BCD	1
+#else
 #define RTC_ALWAYS_BCD	0
+#endif
 
 #ifndef mc146818_decode_year
 #define mc146818_decode_year(year) ((year) < 70 ? (year) + 2000 : (year) + 1970)
-- 
1.7.7.3
