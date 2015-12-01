Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2015 00:26:11 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36801 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008027AbbLAX0J5mJny (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Dec 2015 00:26:09 +0100
Received: by pacdm15 with SMTP id dm15so19846047pac.3
        for <linux-mips@linux-mips.org>; Tue, 01 Dec 2015 15:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=osqRJp/Sxf9b/CLQ5YoPEkAQbTY4NPqMQzrVHJDZS4s=;
        b=DspiZQCweLVx9eqV7fQ9EDy1vDwkz1GTrj6B+OBEh6ANFeMkgQ2UnaLNq+VOwCCDml
         5NIxx0uzsFXM0o1yLeaPwdxrVEcInenAGp2OZ2ys7sIKuVYsFRoynsmLLvmep4cF92RA
         5bNnggTORHgArdTXxUxMgzeMY186u+23Sb45ubBe6C+R1lLVCePFJpthxd+7F2p9J94i
         Y/dHXfl/cBwT3DjsCg37yG1xIZ2bJ9XWcuV3EZVO62i22c46Ha6En6usO+GC+slw7x6o
         HtcdDpNnF3uI3/3yqabO3c8S8CUxJnCwWfa68fvMX7hfWhF3vHblnpt6qLWM902y0h9a
         RSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=osqRJp/Sxf9b/CLQ5YoPEkAQbTY4NPqMQzrVHJDZS4s=;
        b=HmYlJRV1yQ9qbV2jHGx+N0rl8C130z9MrcwVZtSuW1Qiqdl0ZHoZZi2FgKrW3bGYO8
         Q5XsP+K0+echgxjDMyCaNHuF0zqYmnoPsbNATQFI2VLFxf4atqU81pcod3buEFXdjaOY
         SLT4sCKV+On305/MIhs2k7KgJoczelt1P/lijfzsfApqXnKRWHBuVafHEbU1aHmdl3u8
         cgzuwKJjmm/QRj+HoKNNR3oWLbUIoKYd3ZpfefnLeiMnhItTAREw3k+4NZWSOML8JxDU
         BxGmWom3/4hh8Uol1KvLFmN9H34+qHFYy++ufb8tDwXK/YbMOePNcwHDqNiH/7Qszebp
         i8lA==
X-Gm-Message-State: ALoCoQkii4Tn6PW37vNGreSevb8cj81uiytKPVZ3vuitk7VbnD6/6rcwyP2orh87iG75PdYBXyfq
X-Received: by 10.98.14.26 with SMTP id w26mr109032pfi.110.1449012363756;
        Tue, 01 Dec 2015 15:26:03 -0800 (PST)
Received: from yshi-Precision-T5600.corp.ad.wrs.com (unknown-216-82.windriver.com. [147.11.216.82])
        by smtp.gmail.com with ESMTPSA id sz9sm108777pab.13.2015.12.01.15.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Dec 2015 15:26:03 -0800 (PST)
From:   Yang Shi <yang.shi@linaro.org>
To:     akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linaro-kernel@lists.linaro.org, yang.shi@linaro.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4/7] mips: mm/gup: add gup trace points
Date:   Tue,  1 Dec 2015 15:06:14 -0800
Message-Id: <1449011177-30686-5-git-send-email-yang.shi@linaro.org>
X-Mailer: git-send-email 2.0.2
In-Reply-To: <1449011177-30686-1-git-send-email-yang.shi@linaro.org>
References: <1449011177-30686-1-git-send-email-yang.shi@linaro.org>
Return-Path: <yang.shi@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@linaro.org
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

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/mips/mm/gup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/mips/mm/gup.c b/arch/mips/mm/gup.c
index 349995d..3c5b8c8 100644
--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -12,6 +12,9 @@
 #include <linux/swap.h>
 #include <linux/hugetlb.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/gup.h>
+
 #include <asm/cpu-features.h>
 #include <asm/pgtable.h>
 
@@ -211,6 +214,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 					(void __user *)start, len)))
 		return 0;
 
+	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
+
 	/*
 	 * XXX: batch / limit 'nr', to avoid large irq off latency
 	 * needs some instrumenting to determine the common sizes used by
@@ -277,6 +282,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (end < start || cpu_has_dc_aliases)
 		goto slow_irqon;
 
+	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
+
 	/* XXX: batch / limit 'nr' */
 	local_irq_disable();
 	pgdp = pgd_offset(mm, addr);
-- 
2.0.2
