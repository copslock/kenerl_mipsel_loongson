Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Nov 2008 14:12:13 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:11512 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S23815914AbYKUOMG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Nov 2008 14:12:06 +0000
Received: from localhost (p6091-ipad313funabasi.chiba.ocn.ne.jp [123.217.232.91])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 376FFAB51; Fri, 21 Nov 2008 23:12:00 +0900 (JST)
Date:	Fri, 21 Nov 2008 23:12:06 +0900 (JST)
Message-Id: <20081121.231206.96686926.anemo@mba.ocn.ne.jp>
To:	alessandro.zummo@towertech.it
Cc:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [rtc-linux] [PATCH 3/4] rtc: Add rtc-tx4939 driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20081120164533.73ba1f7f@i1501.lan.towertech.it>
References: <1227194815-16200-1-git-send-email-anemo@mba.ocn.ne.jp>
	<20081120164533.73ba1f7f@i1501.lan.towertech.it>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 20 Nov 2008 16:45:33 +0100, Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
>  AIE_ON an OFF are mapped to alarm_irq_enable, please see the latest patches
>  on the rtc mailing list or here http://patchwork.ozlabs.org/patch/9676/

This patch cause deadlock on RTC UIE emulation (again).

Please fold this fix into the rtc-add-alarm-update-irq-interfaces patch.

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 6195f7a..6c39915 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -333,9 +333,8 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 
 #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
 	if (enabled == 0 && rtc->uie_irq_active) {
-		err = rtc_dev_update_irq_enable_emul(rtc, enabled);
 		mutex_unlock(&rtc->ops_lock);
-		return err;
+		return rtc_dev_update_irq_enable_emul(rtc, enabled);
 	}
 #endif
 
@@ -353,8 +352,10 @@ int rtc_update_irq_enable(struct rtc_device *rtc, unsigned int enabled)
 	 * -EINVAL to signal that it has been configured without
 	 * interrupts or that are not available at the moment.
 	 */
-	if (err == -EINVAL)
-		err = rtc_dev_update_irq_enable_emul(rtc, enabled);
+	if (err == -EINVAL) {
+		mutex_unlock(&rtc->ops_lock);
+		return rtc_dev_update_irq_enable_emul(rtc, enabled);
+	}
 #endif
 
 	mutex_unlock(&rtc->ops_lock);
