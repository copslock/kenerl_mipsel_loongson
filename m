Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 22:31:51 +0100 (CET)
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:46464 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008034AbaLLVbuApc1z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 22:31:50 +0100
Received: from resomta-po-15v.sys.comcast.net ([96.114.154.239])
        by resqmta-po-05v.sys.comcast.net with comcast
        id SlXN1p0025AAYLo01lXjp0; Fri, 12 Dec 2014 21:31:43 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-po-15v.sys.comcast.net with comcast
        id SlXh1p00G0gJalY01lXiLB; Fri, 12 Dec 2014 21:31:43 +0000
Message-ID: <548B5EAC.9030403@gentoo.org>
Date:   Fri, 12 Dec 2014 16:31:24 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: CEVT: Make R4K's clockevent_device name more meaningful
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1418419903;
        bh=z/FqiiB1B7QMXIGr+lJcmpRt7hKry6Df+Wu86awgmTc=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=rwNP64fJpGh5aUm3AGDIG3SrXh4AWEdhWMMXkL+a8P1tX862kOC8JV70Xfss0Dt4J
         PlNOPUuToGYtqxsjddquacBjSieIAyMmOva3Q973Cly4eWTZR8eNbdwNo//Kzs3wTA
         2VfLoblTCsZSn4lRBRkOwLdT5uqyTXtDBpOgo0TRPuGQPnOA2femFIneMCV6tjlPvt
         E/xQ/ulzu6xMrF2ekMlvh4h7k5o2tR56yKmd1ADpTtu4i2dUPf9CRSji4txCYST+7G
         3BlzAjpoGsblHrCBjqZbb5kYd3vSIyEDlJ2wKDpTQ+EFjFDj4C/vSu6ErHSMWLznRu
         xd1jY4JrypfgA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

Change the R4K clockevent device's name from "MIPS" to something a bit more
meaningful, "CEVT-R4K".

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/kernel/cevt-r4k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index bc127e2..f531cac 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -178,7 +178,7 @@ int r4k_clockevent_init(void)
 
 	cd = &per_cpu(mips_clockevent_device, cpu);
 
-	cd->name		= "MIPS";
+	cd->name		= "CEVT-R4K";
 	cd->features		= CLOCK_EVT_FEAT_ONESHOT |
 				  CLOCK_EVT_FEAT_C3STOP |
 				  CLOCK_EVT_FEAT_PERCPU;
