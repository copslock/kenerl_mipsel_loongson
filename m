Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2009 17:44:46 +0100 (BST)
Received: from mail-fx0-f175.google.com ([209.85.220.175]:50859 "EHLO
	mail-fx0-f175.google.com") by ftp.linux-mips.org with ESMTP
	id S20023873AbZCaQok (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Mar 2009 17:44:40 +0100
Received: by fxm23 with SMTP id 23so2669397fxm.0
        for <linux-mips@linux-mips.org>; Tue, 31 Mar 2009 09:44:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=VxL010dIDZVMVkLNAA0yodbJ2I3lur2OfBRxBHDjv6U=;
        b=rT6vVGoXvi+JsHXXW+NyTt35B3KoGrePAnGWA0l+rW3WwWuDR+RIZRUK1QgcK51+ej
         m4mDbOcw/gz5+4f6Cg9csVN8LauT1gp97OZqxBZ6VU7zgP/oDY8u1XdZElHOz712ydXh
         cvkQRLVc6zT2P30BEVuZYb20cSIN+i5gU3Su0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=dFyOcl0Qbij/cXvybVMpRFOs3Mrkr8vLTUGbsHfXGyndGw8FRUbcMqNtajFjCrlxOr
         I2x4rrM/nC28AkYdgXu7rqEIvb5KI4bZXXf3FiNm9vFBrvfyXa7avth1lIKLcJIG+Gul
         2eVqh1+y7VIta3azDOt9HE+asBrq1ajofMPGI=
Received: by 10.103.213.10 with SMTP id p10mr2357452muq.49.1238517874497;
        Tue, 31 Mar 2009 09:44:34 -0700 (PDT)
Received: from localhost.localdomain (p5496E20F.dip.t-dialin.net [84.150.226.15])
        by mx.google.com with ESMTPS id t10sm12414544muh.29.2009.03.31.09.44.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Mar 2009 09:44:34 -0700 (PDT)
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] au1xxx-ide: fix build with CONFIG_PM
Date:	Tue, 31 Mar 2009 18:44:36 +0200
Message-Id: <1238517876-4724-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

au1xxx_ide_dev_t is never defined;  get rid of all PM stuff as
well since it is not in the driver source anyway.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
Tested on DB1200.

 arch/mips/include/asm/mach-au1x00/au1xxx_ide.h |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h b/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
index 60638b8..5656c72 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
@@ -46,20 +46,6 @@
 #define CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON	0
 #endif
 
-#ifdef CONFIG_PM
-/*
- * This will enable the device to be powered up when write() or read()
- * is called. If this is not defined, the driver will return -EBUSY.
- */
-#define WAKE_ON_ACCESS 1
-
-typedef struct {
-	spinlock_t		lock;	/* Used to block on state transitions */
-	au1xxx_power_dev_t	*dev;	/* Power Managers device structure */
-	unsigned		stopped; /* Used to signal device is stopped */
-} pm_state;
-#endif
-
 typedef struct {
 	u32			tx_dev_id, rx_dev_id, target_dev_id;
 	u32			tx_chan, rx_chan;
@@ -72,9 +58,6 @@ typedef struct {
 #endif
 	int			irq;
 	u32			regbase;
-#ifdef CONFIG_PM
-	pm_state		pm;
-#endif
 } _auide_hwif;
 
 /******************************************************************************/
-- 
1.6.2
