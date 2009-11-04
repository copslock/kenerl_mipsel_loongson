Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 16:49:41 +0100 (CET)
Received: from ey-out-1920.google.com ([74.125.78.146]:30678 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492428AbZKDPtf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Nov 2009 16:49:35 +0100
Received: by ey-out-1920.google.com with SMTP id 3so1034361eyh.0
        for <multiple recipients>; Wed, 04 Nov 2009 07:49:33 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HOQSeZ/FNM3eCDt4OL6hUbwqaeP9eZ6tUZEzVq+EmhQ=;
        b=BqIQVdCmsSbWbL9OgA81mmA90hzaZA9mK8FxWhFlE/K469RmCTMY3ZnqQVqqDFUou+
         xsJm7bRoU9HRkbLLCIZRNccLJNUkYDcxdb29akOVM22aQ1Htyc9Tv9lMyY+hJXZ8WNSL
         4GKF7jNUL3m+3YB8hbkUGUtFq+AEugzgGCIo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=eUkVqZ0eIDiNFDeCAYijh/iqAxRAf7mJHuLT3HhDy/FB5MfzFuKHMGzQw91vdiSOG0
         y6GPbQilcZuQu/6PzCHY7x1iWHEQe3nf9QcTDMnXflDZvhtxpMNNApRTfqRno0tCUBiD
         xgGiBdzfam04NJcvjPPLnykNW2lPMkw68jWss=
Received: by 10.216.93.68 with SMTP id k46mr494926wef.161.1257349773065;
        Wed, 04 Nov 2009 07:49:33 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id q9sm3529060gve.0.2009.11.04.07.49.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 07:49:32 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	rtc-linux@googlegroups.com
Subject: [PATCH 1/2] RTC: enable RTC_LIB for fuloong2e and fuloong2f
Date:	Wed,  4 Nov 2009 23:49:22 +0800
Message-Id: <1257349762-21407-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch fixes the following warning with RTC_LIB on MIPS:

drivers/rtc/rtc-cmos.c:697:2: warning: #warning Assuming 128 bytes of
RTC+NVRAM address space, not 64 bytes.

and also, enables the RTC_DM_BINARY support. without this support,
RTC_LIB of fuloong2e and fuloong2f does not work.

The platform RTC device driver is coming in the next patch.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/rtc/rtc-cmos.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index f7a4701..820bdad 100644
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
@@ -756,9 +757,8 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	/* FIXME teach the alarm code how to handle binary mode;
 	 * <asm-generic/rtc.h> doesn't know 12-hour mode either.
 	 */
-	if (is_valid_irq(rtc_irq) &&
-	    (!(rtc_control & RTC_24H) || (rtc_control & (RTC_DM_BINARY)))) {
-		dev_dbg(dev, "only 24-hr BCD mode supported\n");
+	if (is_valid_irq(rtc_irq) && !(rtc_control & RTC_24H)) {
+		dev_dbg(dev, "only 24-hr supported\n");
 		retval = -ENXIO;
 		goto cleanup1;
 	}
-- 
1.6.2.1
