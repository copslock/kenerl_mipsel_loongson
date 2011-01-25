Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 18:52:04 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:60589 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491766Ab1AYRwB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 18:52:01 +0100
Received: by fxm19 with SMTP id 19so41642fxm.36
        for <multiple recipients>; Tue, 25 Jan 2011 09:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=4Go7zjPfpVwCIoZUhK+mVhoJNjJReuwqUzxmzgk13GY=;
        b=gcIqqFbRmYH0fcFPTu9pDP8pk6cn+n70WGaFbP2hAP39P1C24E4F5VKMcOz58jJs42
         vLpsN988DQ4n4SUscYdhxhQSthYQYudy/gkXRjro1t0dLfzlOgQRb5m/ahJR2xFanRd5
         ODleWri/xc3e+rfu7QjolNPovP3laPws1WEO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=pr5ZosMf8wH202amML3UrYge8IecAxXytlGgiKJZSDMh+xciqNBz5zjkNhRWFFweEu
         mebgyckTUGDmL4WO6V4+Gy+k+eK9zECP/GKGnjjmJv1jQrqlpvb1cL0mlP0Ay1GKivfN
         lOjgSFsU8LM1Uxpz6h7+7eTp5+EwXaqW7gPdk=
Received: by 10.223.78.135 with SMTP id l7mr6017759fak.116.1295977915556;
        Tue, 25 Jan 2011 09:51:55 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id n7sm5164396fam.11.2011.01.25.09.51.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 09:51:54 -0800 (PST)
Subject: [PATCH v1 1/6] set up MSP VPE1 timer.
From:   Anoop P A <anoop.pa@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
In-Reply-To: <1295943561-20000-1-git-send-email-anoop.pa@gmail.com>
References: <1295943561-20000-1-git-send-email-anoop.pa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 25 Jan 2011 23:38:16 +0530
Message-ID: <1295978896.27661.567.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

Changes since original:
Corrected repeated word in comment
---
VPE1 timer will be required for MIPS_MT modes ( VSMP / SMTC ).
This patch will setup VPE1 timer irq.This has been tested with
both SMTC and VSMP

Signed-off-by: Anoop P A <anoop.pa@gmail.com>
---
 arch/mips/pmc-sierra/msp71xx/msp_time.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_time.c
b/arch/mips/pmc-sierra/msp71xx/msp_time.c
index 01df84c..b6c2d33 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_time.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_time.c
@@ -36,6 +36,13 @@
 #include <msp_int.h>
 #include <msp_regs.h>
 
+#define get_current_vpe()   \
+	((read_c0_tcbind() >> TCBIND_CURVPE_SHIFT) & TCBIND_CURVPE)
+
+extern struct irqaction c0_compare_irqaction;
+static struct irqaction timer_vpe1;
+static int tim_installed;
+
 void __init plat_time_init(void)
 {
 	char    *endp, *s;
@@ -83,5 +90,11 @@ void __init plat_time_init(void)
 
 unsigned int __cpuinit get_c0_compare_int(void)
 {
-	return MSP_INT_VPE0_TIMER;
+	/* MIPS_MT modes may want timer for second VPE */
+	if ((get_current_vpe()) && !tim_installed) {
+		memcpy(&timer_vpe1, &c0_compare_irqaction, sizeof(timer_vpe1));
+		setup_irq(MSP_INT_VPE1_TIMER, &timer_vpe1);
+		tim_installed++;
+	}
+	return (get_current_vpe() ? MSP_INT_VPE1_TIMER : MSP_INT_VPE0_TIMER);
 }
-- 
1.7.0.4
