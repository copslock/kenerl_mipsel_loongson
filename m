Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 02:22:21 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:54482 "EHLO
	mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494105AbZKEBWO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2009 02:22:14 +0100
Received: by pxi6 with SMTP id 6so295117pxi.0
        for <linux-mips@linux-mips.org>; Wed, 04 Nov 2009 17:22:04 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=sJ+iOluJCQ6sc76Zjx2FFM67odmKGDgVhE1XhWkBvgA=;
        b=l8znhImNDpd7gfSazP6MxmuAif61OnhCG+bTSbunKCmbYmayA28zCWsquKd52LaWxT
         8PXBP/Pb80qazJI+rzqi7mYLh0cqpUsjt+4SUQYYSY/b9UHCzuD0E8OcQWr1w772UcJU
         1dMYTmY5k2cP19dtFInTHqB1CW8IC1f8Dz5l4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Pjx4kUkkHiOCuSO9RQ38ejcsMU6+/F7FszrbBW1b1EQgbmPxKJxF5eNNKmGK2a4MmV
         oSBbjMd0fR+S++51leKOzGEFiaTOIhGt4ZDEcyCOiIdD7D+T0CSBIB9wbRHVeOavQE22
         zNL8lCxjlqc2/2NYAIEWnNG9QT3O0YvJcd/Gk=
Received: by 10.114.164.20 with SMTP id m20mr3479872wae.216.1257384124740;
        Wed, 04 Nov 2009 17:22:04 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm125816pxi.13.2009.11.04.17.22.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 17:22:04 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Paul Gortmaker <p_gortmaker@yahoo.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc:	linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 1/3] RTC: rtc-cmos.c: fix warning for MIPS
Date:	Thu,  5 Nov 2009 09:21:54 +0800
Message-Id: <a91e34bf2595157830d599cb66becd52247b1819.1257383766.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257383766.git.wuzhangjin@gmail.com>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch fixes the following warning with RTC_LIB on MIPS:

drivers/rtc/rtc-cmos.c:697:2: warning: #warning Assuming 128 bytes of
RTC+NVRAM address space, not 64 bytes.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/rtc/rtc-cmos.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index f7a4701..21e48f7 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -691,7 +691,8 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	 */
 #if	defined(CONFIG_ATARI)
 	address_space = 64;
-#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) || defined(__sparc__)
+#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__) \
+			|| defined(__sparc__) || defined(__mips__)
 	address_space = 128;
 #else
 #warning Assuming 128 bytes of RTC+NVRAM address space, not 64 bytes.
-- 
1.6.2.1
