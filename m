Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 09:38:21 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:33261 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492253AbZJNHiP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 14 Oct 2009 09:38:15 +0200
Received: by fxm21 with SMTP id 21so9083983fxm.33
        for <linux-mips@linux-mips.org>; Wed, 14 Oct 2009 00:38:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :organization:user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=oAVZZzWb0/CoWi0octy59QKzZY3VsEq09BQvn2xnso8=;
        b=dmShsszarxddIYNpMMLkW3bBpgzTrMHAZnjvLUxsoMnHR1cIljQ0+HLhUk83ua+tZz
         /AMrrnQWBInD/a1c0a7fxR1rjZ0583ahTcUGAhrAcAGoX91xnr2AnG697QX0M19Z9TkT
         cN2r7ZrEr/XXDQBx3dOGUDm4HJYCy/qmbOuQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:content-type:content-transfer-encoding;
        b=l/kjHbYqG3EmUDOo2Q9GupgAa4XUKTM6g8rzKivJ/ZhaZru1w8OPPyTRfHl1kCYikl
         2gz1fZsB8NZJoT+T8An9bd+6+iWEhYTSRgKBjPvnPlwpFEe6K3idiwbzfHLimLB2/UkE
         qXnZI9C9c1qh/8d+r89EW8tjy/pvfUz7cdfrc=
Received: by 10.102.236.11 with SMTP id j11mr3494475muh.3.1255505890414;
        Wed, 14 Oct 2009 00:38:10 -0700 (PDT)
Received: from ?0.0.0.0? (p5496B3DC.dip.t-dialin.net [84.150.179.220])
        by mx.google.com with ESMTPS id n7sm1541289mue.27.2009.10.14.00.38.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Oct 2009 00:38:09 -0700 (PDT)
Message-ID: <4AD57FDE.1040206@gmail.com>
Date:	Wed, 14 Oct 2009 09:38:06 +0200
From:	Manuel Lauss <manuel.lauss@googlemail.com>
Organization: Private
User-Agent: Thunderbird 2.0.0.23 (X11/20090828)
MIME-Version: 1.0
To:	linux-mmc@vger.kernel.org
CC:	Manuel Lauss <manuel.lauss@gmail.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: [PATCH] mmc: au1xmmc: allow platforms to disable host capabilities
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips


Although the hardware supports a 4/8bit SD interface and the driver
unconditionally advertises all hardware caps to the MMC core, not all
datalines may actually be wired up.  This patch introduces another
field to au1xmmc platform data allowing platforms to disable certain
advanced host controller features.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/mach-au1x00/au1100_mmc.h |    1 +
 drivers/mmc/host/au1xmmc.c                     |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-au1x00/au1100_mmc.h b/arch/mips/include/asm/mach-au1x00/au1100_mmc.h
index c35e209..a674643 100644
--- a/arch/mips/include/asm/mach-au1x00/au1100_mmc.h
+++ b/arch/mips/include/asm/mach-au1x00/au1100_mmc.h
@@ -46,6 +46,7 @@ struct au1xmmc_platform_data {
 	int(*card_readonly)(void *mmc_host);
 	void(*set_power)(void *mmc_host, int state);
 	struct led_classdev *led;
+	unsigned long mask_host_caps;
 };

 #define SD0_BASE	0xB0600000
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 7534726..e2caf5a 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1025,6 +1025,10 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	} else
 		mmc->caps |= MMC_CAP_NEEDS_POLL;

+	/* platform may not be able to use all advertised caps */
+	if (host->platdata)
+		mmc->caps &= ~(host->platdata->mask_host_caps);
+
 	tasklet_init(&host->data_task, au1xmmc_tasklet_data,
 			(unsigned long)host);

-- 
1.6.5
