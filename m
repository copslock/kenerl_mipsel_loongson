Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 15:23:47 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.181]:18620 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20023236AbXFROXo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 15:23:44 +0100
Received: by py-out-1112.google.com with SMTP id f31so3271075pyh
        for <linux-mips@linux-mips.org>; Mon, 18 Jun 2007 07:22:40 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cAIW4vJhiuYJoJjcvkvt9wFjYiXHyszhQf6G77jO0doZ4LODJ7HNtQJdy8qq/RiZw5G3SBZSuQLUYigl+78pSBKdawhaJmaexFUA9UaRrm+eGdjj2q5bfi1k52aKO3A04C5HuG/epjVpbcZOZd0NP9zeIc/kVkq1wqHZjdMmLqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AZ176sbPGgJk20iv3uCGNFIqH8dKxp+sVMqsw0AZb6YGBSDILPeDge5/Lxq7MJZNF7otQ/JekDIx9WU3fTEpXHLZglYqezEr/uiwPDfdB+Wj51KoFV5h2vFexM+ZjolMNY2QftRErnka10cIM3xNmGzikHDaP53+VvBqs0t9tX8=
Received: by 10.65.211.16 with SMTP id n16mr9434249qbq.1182176559774;
        Mon, 18 Jun 2007 07:22:39 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Mon, 18 Jun 2007 07:22:39 -0700 (PDT)
Message-ID: <cda58cb80706180722n18e79a49vfa61450526e6af76@mail.gmail.com>
Date:	Mon, 18 Jun 2007 16:22:39 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH 5/5] Implement clockevents for R4000-style cp0 timer
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
In-Reply-To: <20070617000448.GA30807@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	 <11818164024053-git-send-email-fbuihuu@gmail.com>
	 <20070614.212913.82089068.nemoto@toshiba-tops.co.jp>
	 <20070617000448.GA30807@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15448
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Jun 14, 2007 at 09:29:13PM +0900, Atsushi Nemoto wrote:
>
>> I think this to_tm() cleanup should be done in separate patch.
>>
>> Maybe selecting RTC_LIB in Kconfig and replace all to_tm() calls with
>>
>> 	rtc_time_to_tm(tim, tm);
>> 	tm->tm_year += 1900;
>>
>> would be enough.
>
> Looks good to me, done.
>
>   Ralf
>
> [MIPS] Switch from to_tm to rtc_time_to_tm
>
> This replaces the MIPS-specific to_tm function with the generic
> rtc_time_to_tm function.  The big difference between the two functions is
> that rtc_time_to_tm uses epoch 70 while to_tm uses 1970, so the result of
> rtc_time_to_tm needs to be fixed up.
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>

Since very few boards are using GEN_RTC:

	$ git grep -l "GEN_RTC=y" arch/mips/configs/
	arch/mips/configs/bigsur_defconfig
	arch/mips/configs/yosemite_defconfig

Maybe it's high time to move to RTC_CLASS and let these 2
platforms fix their codes.

BTW, I thought that the following rtc function pointers:

	unsigned long (*rtc_mips_get_time)(void) = null_rtc_get_time;
	int (*rtc_mips_set_time)(unsigned long) = null_rtc_set_time;
	int (*rtc_mips_set_mmss)(unsigned long);

were an interface for _generic_ rtc only. But all the following
platforms don't seem to use the generic rtc though it initialises
these function pointers... Any idea why ?

	arch/mips/ddb5xxx/common/rtc_ds1386.c
	arch/mips/dec/time.c
	arch/mips/lasat/setup.c
	arch/mips/mips-boards/atlas/atlas_setup.c
	arch/mips/mips-boards/malta/malta_setup.c
	arch/mips/momentum/ocelot_3/setup.c
	arch/mips/momentum/ocelot_c/setup.c
	arch/mips/pmc-sierra/yosemite/setup.c
	arch/mips/sgi-ip22/ip22-time.c
	arch/mips/sgi-ip32/ip32-setup.c
	arch/mips/sibyte/swarm/setup.c
	arch/mips/sni/a20r.c
	arch/mips/sni/pcimt.c
	arch/mips/sni/pcit.c
	arch/mips/sni/rm200.c
	arch/mips/tx4938/common/rtc_rx5c348.c

And maybe once every platforms will use RTC_CLASS, then we could
implement read_persistent_clock like this:

unsigned long read_persistent_clock(void)
{
	struct rtc_device *rtc = rtc_class_open(CONFIG_RTC_HCTOSYS_DEVICE);
	struct rtc_time tm;
	unsigned long time;

	if (rtc == NULL)
		return 0;

	rtc_read_time(rtc, &tm);
	rtc_tm_to_time(&tm, &time);

	return time;
}


Here's a patch which simply kills the generic RTC support in MIPS.
---

diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index 7def1ff..0fcc0e5 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -44,29 +44,6 @@

 #define TICK_SIZE	(tick_nsec / 1000)

-/*
- * forward reference
- */
-DEFINE_SPINLOCK(rtc_lock);
-
-/*
- * By default we provide the null RTC ops
- */
-static unsigned long null_rtc_get_time(void)
-{
-	return mktime(2000, 1, 1, 0, 0, 0);
-}
-
-static int null_rtc_set_time(unsigned long sec)
-{
-	return 0;
-}
-
-unsigned long (*rtc_mips_get_time)(void) = null_rtc_get_time;
-int (*rtc_mips_set_time)(unsigned long) = null_rtc_set_time;
-int (*rtc_mips_set_mmss)(unsigned long);
-
-
 /* how many counter cycles in a jiffy */
 static unsigned long cycles_per_jiffy __read_mostly;

diff --git a/include/asm-mips/rtc.h b/include/asm-mips/rtc.h
deleted file mode 100644
index 82ad401..0000000
--- a/include/asm-mips/rtc.h
+++ /dev/null
@@ -1,73 +0,0 @@
-/*
- * include/asm-mips/rtc.h
- *
- * (Really an interface for drivers/char/genrtc.c)
- *
- * Copyright (C) 2004 MontaVista Software Inc.
- * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
- *
- * Please read the COPYING file for all license details.
- */
-
-#ifndef _MIPS_RTC_H
-#define _MIPS_RTC_H
-
-#ifdef __KERNEL__
-
-#include <linux/rtc.h>
-#include <asm/time.h>
-
-#define RTC_PIE 0x40            /* periodic interrupt enable */
-#define RTC_AIE 0x20            /* alarm interrupt enable */
-#define RTC_UIE 0x10            /* update-finished interrupt enable */
-
-/* some dummy definitions */
-#define RTC_BATT_BAD 0x100      /* battery bad */
-#define RTC_SQWE 0x08           /* enable square-wave output */
-#define RTC_DM_BINARY 0x04      /* all time/date values are BCD if clear */
-#define RTC_24H 0x02            /* 24 hour mode - else hours bit 7 means pm */
-#define RTC_DST_EN 0x01         /* auto switch DST - works f. USA only */
-
-static inline unsigned int get_rtc_time(struct rtc_time *time)
-{
-	unsigned long nowtime;
-
-	nowtime = rtc_mips_get_time();
-	to_tm(nowtime, time);
-	time->tm_year -= 1900;
-
-	return RTC_24H;
-}
-
-static inline int set_rtc_time(struct rtc_time *time)
-{
-	unsigned long nowtime;
-	int ret;
-
-	nowtime = mktime(time->tm_year+1900, time->tm_mon+1,
-			time->tm_mday, time->tm_hour, time->tm_min,
-			time->tm_sec);
-	ret = rtc_mips_set_time(nowtime);
-
-	return ret;
-}
-
-static inline unsigned int get_rtc_ss(void)
-{
-	struct rtc_time h;
-
-	get_rtc_time(&h);
-	return h.tm_sec;
-}
-
-static inline int get_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-
-static inline int set_rtc_pll(struct rtc_pll_info *pll)
-{
-	return -EINVAL;
-}
-#endif
-#endif
