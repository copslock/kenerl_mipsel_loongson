Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Nov 2009 02:22:46 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:63638 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494109AbZKEBWZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Nov 2009 02:22:25 +0100
Received: by pwi11 with SMTP id 11so3665067pwi.24
        for <linux-mips@linux-mips.org>; Wed, 04 Nov 2009 17:22:18 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NPftuhRaJYz4+H8IsD9Pn3875PTOFXmVM8IhiNpvzV4=;
        b=XzAKdzLiyVdkQydOebXrxB33lHxBz72fNVZ4yQMTCCzrrT5g5SZQTIaXqbC+b7v8FR
         ARUyfKySudyLr1YNX5mG8xXkH3iseK9JPiOsMFDKPA8RZWQlaj/vEQcYopVR2hn0mCLq
         lDiULNtf44raWv0e7BfSO7kuo0njtyacEOK6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=imnv9FRvB9gLbJlebZyFvdcdgubmu8dKrUb+OzZgamy6JEKn21WNM37B693hlu5XRl
         IxGRuW8TlbQRaXI6RGGcpkJXGZEX6idv9yhvqWhwFsbZtsdeeiaRytWgAAdJWUYFdQkV
         rGjPKsnhyQSU7IZ4Ut7a3D3MYAbbU0GxnXHh0=
Received: by 10.115.85.16 with SMTP id n16mr3555691wal.123.1257384137977;
        Wed, 04 Nov 2009 17:22:17 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm902654pzk.6.2009.11.04.17.22.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 17:22:17 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Paul Gortmaker <p_gortmaker@yahoo.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Cc:	linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v1 2/3] RTC: rtc-cmos.c: enable RTC_DM_BINARY of RTC_LIB for fuloong2e and fuloong2f
Date:	Thu,  5 Nov 2009 09:22:09 +0800
Message-Id: <f05318584db5160d73af2cfb36b4e3e481a7e7a4.1257383766.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1257383766.git.wuzhangjin@gmail.com>
References: <cover.1257383766.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch enables the RTC_DM_BINARY support for RTC_LIB of fuloong2e
and fuloong2f. without it, RTC_LIB not work on those machines.

The platform RTC device driver is coming in the next patch.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 drivers/rtc/rtc-cmos.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 21e48f7..820bdad 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -757,9 +757,8 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
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
