Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 15:53:08 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:56518 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492632AbZLAOxD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 15:53:03 +0100
Received: by pwi15 with SMTP id 15so2711701pwi.24
        for <multiple recipients>; Tue, 01 Dec 2009 06:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=m7qcq7ehYhOGlYUTFTEXz1mHDzNsLvgX4Wf1P+r3qzM=;
        b=PTQNGsG5VF/+gvj6bWYdiSOss0iRf8Ui4F5J3R1g44GxnUBLyiMcrB3Mlkmx6HD/n8
         6tzINzZMloKh0lZGnovKOAJHp25GUjAYm1cIj6HH0Huf5/eHow8FcstgORZNpIj5ZFfj
         veetMZSFIR7gJsI7SZlivxi79IWoSov7b56dE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wuZr0+dA62glghYAN+ycxbO5+EAsPM2asWbE5Taz3e1blxEPXUv/dKOAxSIiddYdRI
         IE/B867trcw7U0vy/WIuPEl/KJeYLvwMVDd2kW1aqwG3puP8xRlmLxQWsPTI0VUdm671
         OPh4YuJmKMVqznlW7RDY5/ah5yv8nHnUdsh4Q=
Received: by 10.114.45.10 with SMTP id s10mr3449864was.76.1259679174146;
        Tue, 01 Dec 2009 06:52:54 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm306664pxi.14.2009.12.01.06.52.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 06:52:53 -0800 (PST)
Subject: Re: [PATCH v6 3/8] Loongson: YeeLoong: add backlight driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Richard Purdie <rpurdie@rpsys.net>
In-Reply-To: <20091201140643.GC14064@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
         <4328ee6b15dce3cb600dddf4e7151532ddc77f17.1259664573.git.wuzhangjin@gmail.com>
         <20091201140643.GC14064@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 01 Dec 2009 22:52:17 +0800
Message-ID: <1259679137.12571.4.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-12-01 at 14:06 +0000, Ralf Baechle wrote:
> On Tue, Dec 01, 2009 at 07:08:42PM +0800, Wu Zhangin wrote:
> 
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch adds YeeLoong Backlight Driver, which provides standard
> > interface for user-space applications to control the brightness of the
> > backlight.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> You split old, big driver into several individual drivers - good.
> 
> Now we can actually move things to their rightf place and for a backlight
> drivers that should be drivers/video/backlight/.  Convert it to a platform
> driver.

Okay, but for these drivers need the ec_kb3310b.h, so, we also need to
move it from arch/mips/loongson/lemote-2f/yeeloong_laptop/ec_kb3310b.h
to arch/mips/include/asm/mach-loongson/ec_kb3310b.h.

and seems some subsystem have no maintainer, such as the hwmon driver:

HARDWARE MONITORING
L:      lm-sensors@lm-sensors.org
W:      http://www.lm-sensors.org/
S:      Orphan
F:      drivers/hwmon/

So, who should I send this patch to?

Best Regards,
	Wu Zhangjin
