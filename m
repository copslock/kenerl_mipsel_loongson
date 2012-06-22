Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jun 2012 05:04:07 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:51575 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903511Ab2FVDDi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jun 2012 05:03:38 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq13so3157333pbb.36
        for <multiple recipients>; Thu, 21 Jun 2012 20:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gq/HNgkjD5zgiDgKl7jxsfw2+xEw/5VYH6PnxXrZ72c=;
        b=SN+fHs8JEe9Sg2QOzm4i0a31ZF9P5tVIcEyPw0BX9ZnnYHb12bge5InowtDbZBDeRh
         5nh27M+d/jpsqc7v4lz5Y6kjwYit4LEQleuxpo0Y2jp5S2/qR0xdCBq7gIWBa64seVP1
         T5oHCjadMHp2epaCE7GSYHVMIRA2T5jjZyCl0YWkI8peZsTbvsaLrQ9quTfPv9EMcUFD
         zTu3eX8fzyK3xdYcIiPvf79wUt6RD0FcBZMyh/zW8mzgHfgDwwT7LYDyuAyBm/JTG9p2
         SWlyH91iWmGLyGOHGxjYNzFlkiDYpQ0WfL2MOIS+kUfTc/UfiHPiu47xdYtoRhGCrCZm
         f6lw==
Received: by 10.68.221.227 with SMTP id qh3mr4827605pbc.115.1340334217146;
        Thu, 21 Jun 2012 20:03:37 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id wk3sm37516519pbc.21.2012.06.21.20.03.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2012 20:03:36 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V3 04/16] MIPS: Loongson: Make Loongson-3 to use BCD format for RTC.
Date:   Fri, 22 Jun 2012 11:01:01 +0800
Message-Id: <1340334073-17804-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
References: <1340334073-17804-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33761
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
