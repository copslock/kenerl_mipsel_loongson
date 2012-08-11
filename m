Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Aug 2012 11:34:54 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64558 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903568Ab2HKJdR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Aug 2012 11:33:17 +0200
Received: by mail-pb0-f49.google.com with SMTP id rq8so2856154pbb.36
        for <multiple recipients>; Sat, 11 Aug 2012 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gq/HNgkjD5zgiDgKl7jxsfw2+xEw/5VYH6PnxXrZ72c=;
        b=sbudlX0Con/suBRqi+BtCmbcQT615qSfo3V+cjPjQb31lsMLFJtyEkvfTizSk+UmXY
         MIsOqyap89my3GOXLaf+zlE+TkML2WEWmhBn6N2fug3T2eCEp6R82W86WxzY9L0A+C/K
         mZFuJwMLEUgLQvI+pksia/QEjAYoquwsICS34xfpbcsVav+HGeKb0HIv1h3LqKsx72Ca
         tNpXVGUAaAqWP5k2o8NnvDXg9ezmUQISBPxp5eUO6uFnnnY8VokH6JvhqfZnwbLX4J6C
         95LO6rX15OkeCUA8A5AWXDqEWNv3RyMso4HMIRd8AHTD+S40GENrv3CIAu6C1vFktVPR
         37nQ==
Received: by 10.68.189.104 with SMTP id gh8mr18937646pbc.152.1344677596729;
        Sat, 11 Aug 2012 02:33:16 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id nu5sm1079954pbb.53.2012.08.11.02.33.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Aug 2012 02:33:15 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V5 04/18] MIPS: Loongson: Make Loongson-3 to use BCD format for RTC.
Date:   Sat, 11 Aug 2012 17:32:09 +0800
Message-Id: <1344677543-22591-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com>
X-archive-position: 34097
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
