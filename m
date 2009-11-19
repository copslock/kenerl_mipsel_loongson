Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 19:03:12 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:54019 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493547AbZKSSDG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 19:03:06 +0100
Received: by pwi15 with SMTP id 15so1610622pwi.24
        for <multiple recipients>; Thu, 19 Nov 2009 10:02:58 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=OjnTnMigwbTVLsSm/yShqLSdTeTz1CKVGb5rj/4WxEk=;
        b=mh9cdlSrUvhTf0xsehyc9zUqDWPtc7Bda9S9bnYWSi+30apvPRkxPVZWTviHP6HgRe
         sTvSLbF0dn8QXdy1L9oD9GOS6lkLwlfdCylUmOJkNx1trQtOQbFPRarvbDG7qXsVk2am
         xYXMkUWDQ2HSz4r4Wq6xdi9hxz1NrYPutFNO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=BUKDLHykoQ3W119/rit032ttimnOZ3MehSkiuK6whZEbctbJmogeDELDMe0a92L6aC
         +GNKjkOK1fdfUHFq82RugpUxzOUV6fxvlKDXXN6QJqQ5qyzZMN8vb5Glu4kOOgpdoOJk
         3MPrwiztA575G9Z4YKuRjXGKp7bbzLStofY6U=
Received: by 10.115.66.28 with SMTP id t28mr277635wak.177.1258653778645;
        Thu, 19 Nov 2009 10:02:58 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm472782pzk.2.2009.11.19.10.02.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 10:02:57 -0800 (PST)
Subject: Re: [PATCH 5/5] [loongson] yeeloong2f: add platform specific
 support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
	huhb@lemote.com, Richard Purdie <rpurdie@rpsys.net>,
	lm-sensors@lm-sensors.org, Jamey Hicks <jamey@crl.dec.com>
In-Reply-To: <08cd92bb27734174fd53df79cc926e76400d586d.1258651050.git.wuzhangjin@gmail.com>
References: <cover.1258651050.git.wuzhangjin@gmail.com>
	 <08cd92bb27734174fd53df79cc926e76400d586d.1258651050.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Fri, 20 Nov 2009 02:02:46 +0800
Message-ID: <1258653766.14308.13.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Sorry, This patch can not be compiled without CONFIG_PM, this patch is
needed to fix it:

We need to wrap the source code relative to CONFIG_PM, otherwise, it
will fail in compiling.

This patch is needed to "[PATCH 5/5] [loongson] yeeloong2f: add platform
specific support".

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/lemote-2f/yeeloong_laptop.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
b/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
index ff74f7f..46c3847 100644
--- a/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
+++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
@@ -1025,9 +1025,10 @@ static int yeeloong_hotkey_init(struct device
*dev)
 	/* update the current status of lid */
 	yeeloong_lid_update_status(BIT_LID_DETECT_ON);
 
+#ifdef CONFIG_SUSPEND
 	/* install the real yeeloong_report_lid_status for pm.c */
 	yeeloong_report_lid_status = yeeloong_lid_update_status;
-
+#endif
 	/* install event handler */
 	yeeloong_install_sci_handler(EVENT_CAMERA, camera_set);
 
@@ -1039,9 +1040,10 @@ static void yeeloong_hotkey_exit(void)
 	/* free irq */
 	remove_irq(SCI_IRQ_NUM, &sci_irqaction);
 
+#ifdef CONFIG_SUSPEND
 	/* uninstall the real yeeloong_report_lid_status for pm.c */
 	yeeloong_report_lid_status = NULL;
-
+#endif
 	/* uninstall event handler */
 	yeeloong_uninstall_sci_handler(EVENT_CAMERA, camera_set);
 
@@ -1083,7 +1085,8 @@ static void get_fixed_battery_info(void)
 
 #define APM_CRITICAL		5
 
-static void yeeloong_apm_get_power_status(struct apm_power_info *info)
+static void __maybe_unused yeeloong_apm_get_power_status(struct
apm_power_info
+		*info)
 {
 	unsigned char bat_status;
 
@@ -1144,8 +1147,9 @@ static int yeeloong_apm_init(void)
 	/* print fixed information of battery */
 	get_fixed_battery_info();
 
+#ifdef APM_EMULATION
 	apm_get_power_status = yeeloong_apm_get_power_status;
-
+#endif
 	return 0;
 }
 
-- 
1.6.2.1
