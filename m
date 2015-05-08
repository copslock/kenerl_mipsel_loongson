Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 May 2015 00:10:23 +0200 (CEST)
Received: from mail-oi0-f74.google.com ([209.85.218.74]:33535 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026600AbbEHWKPEQGfK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 May 2015 00:10:15 +0200
Received: by oiax69 with SMTP id x69so5217903oia.0
        for <linux-mips@linux-mips.org>; Fri, 08 May 2015 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:message-id:date;
        bh=8wwc4C7UdudtkbeLQyBosIQIQbabIDJw9O7+3BYc1ps=;
        b=O6LJbvmEB/Rm34hfCJ9+ZoKASNV2BlswaK5AH47gtIYcCFy7RG8wofRVZVQDfS94CG
         tx2xTsgzXPGDtSGRK7pNJhqPXW4fudH9lRpCSWQ1FlB70VerpLevlm3PTgp196uwPOB5
         UJRjXEQwuowLgxAlonASa+Tilr7GYP9E9p12s9BhSlrkc57Q1ddqfGDeItnd/NBQPw1o
         xKJnA7TUcWGWG+ktBiWzyuGxxmLkLhoaZsw/e9mA9TTl3x6Y2gkgZlnJtHhlCVh6PxFI
         OVSSbvwwoamn5AuV8ape6hp2yIEfr1dDFUAfPATHyxHKkzL46FVM3wwgHxn+aKN7ZoRP
         gIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:message-id:date;
        bh=8wwc4C7UdudtkbeLQyBosIQIQbabIDJw9O7+3BYc1ps=;
        b=O2Dn4efLFNj/nGjeXGJtoC+jceNeYzQFLSfoAXuFDk2zsD6mVvwJy5+Tig7H9pErkH
         SeOZMag/5CuxuGcS9trs457o3IxlqIQdPD2MhsmDOLSjuph8lfA/zsHvG5drRmqK2sOw
         knWdIMtBCU+hY3HEZLkchQyErpo6fN0+bJhmj4Hu01nAM9rtHMnZzRM6KOLIp17wtnKB
         Pzj+WdVZ2T4+sjP4yjbva0XfoRc8P53liyGlCEkTCNfJgtD/seUuLkzLT3j3J5p6RKLm
         FcepqpluXoW03vqoYAeGI/zSk4iSl8IHxhpoOtIzSghlPVEDTwhjk/RzQUcQqYiutro5
         XhMw==
X-Gm-Message-State: ALoCoQmIWXtGbFHS8RcojLbI4MxgjSJ50wS9vbsYfPJmuz4qDlEZN6+nUY15cFPeGwjTR9xdHGik
X-Received: by 10.182.236.197 with SMTP id uw5mr315486obc.32.1431123011250;
        Fri, 08 May 2015 15:10:11 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id i27si335813yha.6.2015.05.08.15.10.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2015 15:10:11 -0700 (PDT)
Received: from puck.mtv.corp.google.com ([172.27.88.166])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id FhSWpQ4j.1; Fri, 08 May 2015 15:10:11 -0700
Received: by puck.mtv.corp.google.com (Postfix, from userid 68020)
        id 92804220495; Fri,  8 May 2015 15:10:10 -0700 (PDT)
From:   Petri Gynther <pgynther@google.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 2/2] MIPS: traps: print Exception Code in __show_regs()
Message-Id: <20150508221010.92804220495@puck.mtv.corp.google.com>
Date:   Fri,  8 May 2015 15:10:10 -0700 (PDT)
Return-Path: <pgynther@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pgynther@google.com
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

Print Exception Code when printing the Cause register.

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 arch/mips/kernel/traps.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index d2d1c19..1d6dd12 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -236,6 +236,7 @@ static void __show_regs(const struct pt_regs *regs)
 {
 	const int field = 2 * sizeof(unsigned long);
 	unsigned int cause = regs->cp0_cause;
+	unsigned int exccode;
 	int i;
 
 	show_regs_print_info(KERN_DEFAULT);
@@ -317,10 +318,10 @@ static void __show_regs(const struct pt_regs *regs)
 	}
 	printk("\n");
 
-	printk("Cause : %08x\n", cause);
+	exccode = (cause & CAUSEF_EXCCODE) >> CAUSEB_EXCCODE;
+	printk("Cause : %08x (ExcCode %02x)\n", cause, exccode);
 
-	cause = (cause & CAUSEF_EXCCODE) >> CAUSEB_EXCCODE;
-	if (1 <= cause && cause <= 5)
+	if (1 <= exccode && exccode <= 5)
 		printk("BadVA : %0*lx\n", field, regs->cp0_badvaddr);
 
 	printk("PrId  : %08x (%s)\n", read_c0_prid(),
-- 
2.2.0.rc0.207.ga3a616c
