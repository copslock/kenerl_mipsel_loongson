Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 10:09:27 +0200 (CEST)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:48554 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820489AbaETIJTk3oXw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2014 10:09:19 +0200
Received: by mail-pd0-f171.google.com with SMTP id y13so97292pdi.16
        for <multiple recipients>; Tue, 20 May 2014 01:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6Nphtp8aza+TtEwpIiwWupDMGbANXzDd4LeV4+N5C4I=;
        b=wFvZeFRIL+SgTnJDdIeoleXUEUdE+IDRMyYrzxvJa0oemSOjd/P6kS+tQwCH+AiYsB
         AllxgOadbgtNSxYhp/kYyImFMN6768Fxq6zxaxfXDtXdtP7Y/5zbXOdhrDAuJv3Vlha6
         wIFB7kCCceHoFaHlBlku40fP5KMK9iGhQxutbWIqwvbxOzj3hasDw8HTQwuXYAr1qR1d
         uBxWfkd3T8E//EEDb3RRWr4T5Wqh6If8qIQju8PLXMFyYYT3Krjh9ZBg4UT8+Sga9hdY
         VBpOFYw9BM43MGpDMRAkTPjv2IDQhT+3doiqhycBcWpOa+NLWma7liZCCMpCfMHpA653
         ZgOw==
X-Received: by 10.68.143.65 with SMTP id sc1mr49310478pbb.93.1400573353288;
        Tue, 20 May 2014 01:09:13 -0700 (PDT)
Received: from localhost ([1.202.252.122])
        by mx.google.com with ESMTPSA id dd5sm1708249pbc.85.2014.05.20.01.09.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 01:09:12 -0700 (PDT)
From:   Yong Zhang <yong.zhang0@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Yong Zhang <yong.zhang@windriver.com>
Subject: [PATCH] MIPS: change type of asid_cache to unsigned long
Date:   Tue, 20 May 2014 16:09:04 +0800
Message-Id: <1400573344-5035-1-git-send-email-yong.zhang0@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Return-Path: <yong.zhang0@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yong.zhang0@gmail.com
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

From: Yong Zhang <yong.zhang@windriver.com>

asid_cache must be unsigned long otherwise on 64bit system
it will become 0 if the value in get_new_mmu_context()
reaches 0xffffffff and in the end the assumption of
ASID_FIRST_VERSION is not true anymore thus leads to
more dangerous things.

Signed-off-by: Yong Zhang <yong.zhang@windriver.com>
---
 arch/mips/include/asm/cpu-info.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index f6299be..ebcc2ed 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -40,7 +40,7 @@ struct cache_desc {
 
 struct cpuinfo_mips {
 	unsigned int		udelay_val;
-	unsigned int		asid_cache;
+	unsigned long		asid_cache;
 
 	/*
 	 * Capability and feature descriptor structure for MIPS CPU
-- 
1.7.9.5
