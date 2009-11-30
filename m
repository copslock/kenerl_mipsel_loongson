Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 07:44:01 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:61333 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491072AbZK3Gn6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 07:43:58 +0100
Received: by pzk35 with SMTP id 35so2347608pzk.22
        for <multiple recipients>; Sun, 29 Nov 2009 22:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=YW7vTOBTD203xef5aGmtMPpPr8uejDZcS/miutpaaxE=;
        b=qL0sxyntM7QfvHGmq8F679yO7zxxoI0qcfB+9+DMkum638UaL8Vc5JJ987vC1/BGAr
         gf84i+HdtkIkddzymdn3UDVw026FyG+1XclO6NvRED3DMbKxJ91cnMHCjn/2M8QoUsf1
         CYzEi6CO03bghSTrQ14W8gMCoeIfkfw708Nlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=UtjspL5InJXqOh09/lfNZqW//JfCKsasQywqD3Zz4bIEWrqfCAglDJ+Np6KIVGKskU
         iTKoDuG7sicONubGdxAGaPA17imTrkqLqGfmC9srtD2ks9ZfLp+lvGeriDtPoLNsp9RA
         Xn8FTO97MseBaFbqqxb7Bns0OkMg85VpVCfUc=
Received: by 10.114.249.4 with SMTP id w4mr6604038wah.186.1259563430761;
        Sun, 29 Nov 2009 22:43:50 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm2785129pzk.5.2009.11.29.22.43.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 22:43:50 -0800 (PST)
Subject: Re: [PATCH v5 6/8] Loongson: YeeLoong: add video output driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, luming.yu@intel.com
In-Reply-To: <1259558346.5516.6.camel@falcon.domain.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <dc116705b7d610d48b7d77ebd6365c5f05ad8ab7.1259414649.git.wuzhangjin@gmail.com>
         <1259558346.5516.6.camel@falcon.domain.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 30 Nov 2009 14:43:28 +0800
Message-ID: <1259563408.5516.19.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25207
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-11-30 at 13:19 +0800, Wu Zhangjin wrote:
> On Sat, 2009-11-28 at 21:41 +0800, Wu Zhangjin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch adds Video Output Driver, which provides standard interface
> > to turn on/off the video output of LCD, CRT.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > ---
> >  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    8 +
> >  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
> >  .../lemote-2f/yeeloong_laptop/ec_kb3310b.h         |    3 +
> >  .../lemote-2f/yeeloong_laptop/video_output.c       |  164 ++++++++++++++++++++
> >  4 files changed, 176 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/video_output.c
> > 
> > diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > index 56cb584..c4398ff 100644
> > --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > @@ -37,4 +37,12 @@ config YEELOONG_HWMON
> >  	  interface for lm-sensors to monitor the temperatures of CPU and
> >  	  battery, the PWM of fan, the current, voltage of battery.
> >  
> > +config YEELOONG_VO
> > +	tristate "Video Output Driver"
> > +	select VIDEO_OUTPUT_CONTROL
> 
> Will use "depend" instead in the next version.
> 

Sorry to disturb you, this also must be "select", and the same to
BACKLIGHT_CLASS_DEVICE.

> Regards,
> 	Wu Zhangjin
