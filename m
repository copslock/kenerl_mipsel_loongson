Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2009 20:15:29 +0200 (CEST)
Received: from ey-out-1920.google.com ([74.125.78.147]:61781 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493516AbZJGSPW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2009 20:15:22 +0200
Received: by ey-out-1920.google.com with SMTP id 13so957149eye.52
        for <multiple recipients>; Wed, 07 Oct 2009 11:15:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ii8zEsFHQhopgrOb0NNHn7rnAuFjaTg46YDIhYYrwrY=;
        b=aMMtujAuN3+ferIbTZJbsa8s9FNKkqfXawKrw0t9UVWZtCSIxDEKMfWzAZ/iYrpNyn
         0i0FBo6bqGpni08EnDdXthvbIknXfYKfAF1nuby2YDFKqTATWhNj7SyG/Es5GaZmWLaH
         w8oUTm61YB4rgMEJNBw9Rfiq/txYPNfVS5X4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dJqOx5O50fAXwsYeXkVY9DbBxRAeqJ0IR5ikCmvADHenE8t3hCMtYZEltzQe3u3WIs
         EYgpzo7zx4rcQQrN0kF0xcoVbWr+lCbhplKh6o7qNCAv6UfJUM/FzgnTbk3dE+7MVS2k
         eoSPDcVBxAqjb0DLoC54fmfyOMc1td9ygTkC8=
Received: by 10.216.88.209 with SMTP id a59mr74945wef.50.1254939321310;
        Wed, 07 Oct 2009 11:15:21 -0700 (PDT)
Received: from localhost.localdomain (p5496B5E8.dip.t-dialin.net [84.150.181.232])
        by mx.google.com with ESMTPS id f13sm94596gvd.21.2009.10.07.11.15.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 11:15:20 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 2/4] Alchemy: higher priority for system timer.
Date:	Wed,  7 Oct 2009 20:15:13 +0200
Message-Id: <1254939315-8158-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.rc2
In-Reply-To: <1254939315-8158-2-git-send-email-manuel.lauss@gmail.com>
References: <1254939315-8158-1-git-send-email-manuel.lauss@gmail.com>
 <1254939315-8158-2-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Raise RTCMATCH2 interrupt priority in case it is used as the system
timer tick.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/irq.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index 81acd2a..da53a3b 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -74,7 +74,7 @@ struct au1xxx_irqmap {
 	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
 	{ AU1000_IRDA_TX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
 	{ AU1000_IRDA_RX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
 	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
@@ -108,7 +108,7 @@ struct au1xxx_irqmap {
 	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
 	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
 	{ AU1000_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_USB_HOST_INT, IRQ_TYPE_LEVEL_LOW, 0 },
@@ -140,7 +140,7 @@ struct au1xxx_irqmap {
 	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
 	{ AU1000_IRDA_TX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
 	{ AU1000_IRDA_RX_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
 	{ AU1000_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
@@ -174,7 +174,7 @@ struct au1xxx_irqmap {
 	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
 	{ AU1550_NAND_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1550_USB_DEV_REQ_INT, IRQ_TYPE_LEVEL_HIGH, 1 },
 	{ AU1550_USB_DEV_SUS_INT, IRQ_TYPE_EDGE_RISING, 0 },
@@ -202,7 +202,7 @@ struct au1xxx_irqmap {
 	{ AU1000_RTC_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH0_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1000_RTC_MATCH1_INT, IRQ_TYPE_EDGE_RISING, 0 },
-	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 0 },
+	{ AU1000_RTC_MATCH2_INT, IRQ_TYPE_EDGE_RISING, 1 },
 	{ AU1200_NAND_INT, IRQ_TYPE_EDGE_RISING, 0 },
 	{ AU1200_USB_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
 	{ AU1200_LCD_INT, IRQ_TYPE_LEVEL_HIGH, 0 },
-- 
1.6.5.rc2
