Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jun 2012 08:54:08 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:43673 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903560Ab2FSGxo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jun 2012 08:53:44 +0200
Received: by dadm1 with SMTP id m1so8372743dad.36
        for <multiple recipients>; Mon, 18 Jun 2012 23:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gq/HNgkjD5zgiDgKl7jxsfw2+xEw/5VYH6PnxXrZ72c=;
        b=to6XccPjrNxP+LF5SZlhPPfAY2TtWHEgiEI0rRHVxHbv/FkNd/Wajo4qiLimphyeLy
         v/rV9m4t+do2HaoG+k0Ygd1bMDB/6RYQvYssPsNStCQD6u11L9WwgSOuViSjWF0i5QCc
         HWUqc758y8Z+Eqn08DWjm3hDuuRSM+aWHQlvlxmdL2wtANbSiYACyKMerLHcn5ia1TfP
         XuhHm6dtJkR99w3/NyQAVjiKtvGjd5h4J6MLKSNWWjuyV804H0SFu2JJ3u5T2NQPf3Qq
         ++/hVOPZ1px1MuxxLCr5edfarZAXE38bo3XOeovosdlz0kJOZ1Fj5dyrR7SunmdevdD7
         wN3g==
Received: by 10.68.190.102 with SMTP id gp6mr59214195pbc.5.1340088817705;
        Mon, 18 Jun 2012 23:53:37 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id gk3sm20156319pbc.1.2012.06.18.23.53.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2012 23:53:36 -0700 (PDT)
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: [PATCH V2 04/16] MIPS: Loongson: Make Loongson-3 to use BCD format for RTC.
Date:   Tue, 19 Jun 2012 14:50:12 +0800
Message-Id: <1340088624-25550-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
References: <1340088624-25550-1-git-send-email-chenhc@lemote.com>
X-archive-position: 33694
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
