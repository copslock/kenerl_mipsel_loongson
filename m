Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 10:12:22 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:50514 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903386Ab2FOILe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 10:11:34 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq13so5186436pbb.36
        for <multiple recipients>; Fri, 15 Jun 2012 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gq/HNgkjD5zgiDgKl7jxsfw2+xEw/5VYH6PnxXrZ72c=;
        b=MdvSIVqhHxbZklPqPKtuAVEAZ20v5ieRYxP5KcUS1qMXkRZv2GWyoBk1SW7xzOwYAc
         dTgEBZQGz9uikOLpdMItmQx3XWPuoV0vK5bovjEnQ5rQ4ClXM/Ye8SP4gSIHAfe0sBn4
         ujqxYtnQtvrZBDxZ4WMlq7YcE9mAYk8pyBRhcvV7wiazJtRuVm8uqZdVfyRmjgEuY882
         OHckqefBv/ES+UCWJF55CerT0OjaPv0hviYXla+fgIKLQbopltxgR2V2STSjJTrO/5aH
         ruCpPyaXr9MFWxTE9HSXN5xOpzdwzzWiKpXX4omH/RAMqdBtfS1q3gGVb6fLZV9kucNg
         7yWw==
Received: by 10.68.200.197 with SMTP id ju5mr17547605pbc.19.1339747892886;
        Fri, 15 Jun 2012 01:11:32 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nh8sm12437247pbc.60.2012.06.15.01.11.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 01:11:31 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH 03/14] MIPS: Loongson: Make Loongson 3 to use BCD format for RTC.
Date:   Fri, 15 Jun 2012 16:09:50 +0800
Message-Id: <1339747801-28691-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33641
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
