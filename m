Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Mar 2011 08:54:53 +0200 (CEST)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:45492 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490992Ab1C2Gyt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Mar 2011 08:54:49 +0200
Received: by iyb39 with SMTP id 39so4461361iyb.36
        for <multiple recipients>; Mon, 28 Mar 2011 23:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=9m71wicQRXwaArG4OD+AdRZXXGNQhjg/h6JgEuK0KYY=;
        b=aLXO7XmNGcRvkifzVCNjF3pEin+BESmqTD/RiLX0KhqPc6eSE+WNxrBd7NyWToaKWE
         SdEQmHBRs9/gIBusi2gdFogb9NCRBPliwO4K2ojkTH6np3/QoRYBHqfAPn6ySYZETfjL
         TYJGv/OsxqZVRTx5APvWTtlhIiqMFLK4U7J5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=po4chl+ne5bp75McIvWhVyN+MGqKUJBYSGTFgKOt0kChfj2Z97xvSgkv0DRZG3juwy
         W2GfC9XfZTwT//34iubq69736PXnlbHOsMVPU4EzXQxsHh5KIq033+vwigAVWQiTgOKR
         /7FVp982vMrNLZ8TAprj7pGTCPky0UjbyIGY0=
Received: by 10.43.70.20 with SMTP id ye20mr656865icb.156.1301381682815;
        Mon, 28 Mar 2011 23:54:42 -0700 (PDT)
Received: from stratos (sannin29007.nirai.ne.jp [203.160.29.7])
        by mx.google.com with ESMTPS id s1sm3454916iba.41.2011.03.28.23.54.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 23:54:41 -0700 (PDT)
Date:   Tue, 29 Mar 2011 15:52:23 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/2] MIPS: msp71xx: fix msp_time build error
Message-Id: <20110329155223.08fbef97.yuasa@linux-mips.org>
X-Mailer: Sylpheed 3.1.0 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yyuasa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

In file included from arch/mips/pmc-sierra/msp71xx/msp_time.c:32:0:
/home/yuasa/src/linux/kernel/git/mips/arch/mips/include/asm/cevt-r4k.h:21:56: error: 'enum clock_event_mode' declared inside parameter list
/home/yuasa/src/linux/kernel/git/mips/arch/mips/include/asm/cevt-r4k.h:21:56: error: its scope is only this definition or declaration, which is probably not what you want
/home/yuasa/src/linux/kernel/git/mips/arch/mips/include/asm/cevt-r4k.h: In function 'handle_perf_irq':
/home/yuasa/src/linux/kernel/git/mips/arch/mips/include/asm/cevt-r4k.h:42:3: error: implicit declaration of function 'perf_irq'
In file included from arch/mips/pmc-sierra/msp71xx/msp_time.c:34:0:
/home/yuasa/src/linux/kernel/git/mips/arch/mips/include/asm/time.h: At top level:
/home/yuasa/src/linux/kernel/git/mips/arch/mips/include/asm/time.h:48:14: error: 'perf_irq' redeclared as different kind of symbol
/home/yuasa/src/linux/kernel/git/mips/arch/mips/include/asm/cevt-r4k.h:42:3: note: previous implicit declaration of 'perf_irq' was here
make[2]: *** [arch/mips/pmc-sierra/msp71xx/msp_time.o] Error 1

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/pmc-sierra/msp71xx/msp_time.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c b/arch/mips/pmc-sierra/msp71xx/msp_time.c
index 8b42f30..9e58c3d 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -28,10 +28,11 @@
 #include <linux/spinlock.h>
 #include <linux/module.h>
 #include <linux/ptrace.h>
+#include <linux/clockchips.h>
 
+#include <asm/time.h>
 #include <asm/cevt-r4k.h>
 #include <asm/mipsregs.h>
-#include <asm/time.h>
 
 #include <msp_prom.h>
 #include <msp_int.h>
-- 
1.7.3.4
