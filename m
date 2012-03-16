Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Mar 2012 10:58:25 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46766 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901172Ab2CPJ6V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Mar 2012 10:58:21 +0100
Received: by wibhj13 with SMTP id hj13so473857wib.6
        for <linux-mips@linux-mips.org>; Fri, 16 Mar 2012 02:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=SR1ZhDh5cDeefmLR/+bnTWNWKHslMgRtjhFMJKW0Lkk=;
        b=imAe3mgBQyGvkM7AcCfrmPi8MEOfknHlzPLxrHxMg+YbMNwhBMCwBzhEBpNEvkM5nH
         p/i/orWSdqFzyKFf1pVJsQzcEfMfzqMsw5saxL5bLXau1iYzkOlw3EwEuI1rTVcB5jk7
         KFvf4fDgi1VIH5+JdpFerpx/NVhYiMVFQTWiSFJNAxWui1OcbvOau3OLxdMOfH8ZkUJy
         GcTzJpJuXbo1zYefaxmqzkxvBHxHHSxOo5JpjTV7gnKXFMn5a0WF+6B3CLLRdxEusnoB
         M/Tq3v1AhgrmqD1L5CSh9c7T0utl3LHo32vaXI7U3ZiSW+UXWGlVBOy+8MVEGPrW5voY
         TpPA==
Received: by 10.180.107.162 with SMTP id hd2mr33884117wib.8.1331891895207;
        Fri, 16 Mar 2012 02:58:15 -0700 (PDT)
Received: from localhost.localdomain (fidelio.qi-hardware.com. [213.239.211.82])
        by mx.google.com with ESMTPS id e6sm12445536wix.8.2012.03.16.02.57.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 02:58:14 -0700 (PDT)
From:   Xiangfu <xiangfu@openmobilefree.net>
To:     lars@metafoo.de
Cc:     linux-mips@linux-mips.org, discussion@lists.en.qi-hardware.com,
        Xiangfu <xiangfu@openmobilefree.net>
Subject: [PATCH] rtc: jz4740 fix hwclock give time out
Date:   Fri, 16 Mar 2012 17:55:12 +0800
Message-Id: <1331891712-25269-1-git-send-email-xiangfu@openmobilefree.net>
X-Mailer: git-send-email 1.7.5.4
X-Gm-Message-State: ALoCoQkVw4e+XNRagQG9xNfC1esp9Vo0jCWCI+KZ0NrrV5JiWuQUCnWRF7LxrSlNf9HSb9zYk2HW
X-archive-position: 32726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiangfu@openmobilefree.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

---
Hi Lars

This patch fix the hwclock give time out error. I am not sure is this patch good
please review. give some feedback. thanks

More info:
 http://www.linux-mips.org/archives/linux-mips/2011-12/msg00191.html

Xiangfu

 drivers/rtc/rtc-jz4740.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index b647363..50c5df0 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -280,6 +280,8 @@ static int __devinit jz4740_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
+	jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_1HZ_IRQ, 1);
+
 	return 0;
 
 err_free_irq:
-- 
1.7.5.4
