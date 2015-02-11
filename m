Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Feb 2015 22:27:38 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:44783 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013268AbbBKV1g59wBt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Feb 2015 22:27:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Message-Id:Date:Subject:Cc:To:From; bh=rQ99RwjxhyILYcuRhYNWdql3lqXU5a5wRtbsKrMMDxE=;
        b=O2lONelcX1ob4Qxxlz/Tq1XBT9YXd0bKCcljrPntTkavQPKL19Fq/7UiQo5fdF2XYb4YPPOdXKTQfmB2QOseIAn+3DSsbxC0zCUJoHT3saETrUmPIy4YY8mMotDxN/J4a5fNeLj8YM8ItlONJiQTW/ZGwzPJFx4L8pI0YfjjZiY=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YLeol-0031E8-9n
        for linux-mips@linux-mips.org; Wed, 11 Feb 2015 21:27:31 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55255 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YLeod-00319G-Uk; Wed, 11 Feb 2015 21:27:24 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] mips: Remove prototype for copy_user_page
Date:   Wed, 11 Feb 2015 13:27:19 -0800
Message-Id: <1423690039-24749-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.1.0
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020204.54DBC943.0105,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 2
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

MIPS architecture code does not provide copy_user_page,
so it should not provide a prototype for it either.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
If we don't want to support copy_user_page, as sugegsted elsewhere,
we should at least remove its prototype.

 arch/mips/include/asm/page.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 154b70a..89dd7fe 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -105,8 +105,6 @@ static inline void clear_user_page(void *addr, unsigned long vaddr,
 		flush_data_cache_page((unsigned long)addr);
 }
 
-extern void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
-	struct page *to);
 struct vm_area_struct;
 extern void copy_user_highpage(struct page *to, struct page *from,
 	unsigned long vaddr, struct vm_area_struct *vma);
-- 
2.1.0
