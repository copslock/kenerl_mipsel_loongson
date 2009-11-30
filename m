Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 02:00:37 +0100 (CET)
Received: from mail-px0-f176.google.com ([209.85.216.176]:63675 "EHLO
        mail-px0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491034AbZK3BAd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2009 02:00:33 +0100
Received: by pxi6 with SMTP id 6so1200111pxi.0
        for <multiple recipients>; Sun, 29 Nov 2009 17:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=IkTlN27HeyXWYMDuiNS41K3d1FZ8cOBNGWfJ2fmf6Qw=;
        b=L1tKHdUA18SkK3byMJs/YYp/FAf1PRMiAJOoDRQRnLGty/sQjiNzFG0VFToJtcs1sR
         X5PyYiqNwPjQl/jDwCIn5zxPtbOKtC9lE+VX5lx7NdL2T4ElR6skMnStWlXWNdlbRdDI
         45lz6QYbqBe/UL/OvagdZldhvx9Smo2toeawA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=HThzXrPpHDueboSGrmjwxM8mhKqja8e6CcCnXoLdTWJF73kyhQZjkaJUliy/bZLJFY
         faTo3CY3GUTMiDPIsQ4w8nrYn+193Uc7TDtDDi5az0d2eFSF1U4xCm0uePIChZOdVcPF
         c0qmPTkbjVU/uNusbYlEhu2Ow0sLv838wwT5c=
Received: by 10.114.3.29 with SMTP id 29mr5914717wac.208.1259542823950;
        Sun, 29 Nov 2009 17:00:23 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm2624792pzk.2.2009.11.29.17.00.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 17:00:23 -0800 (PST)
Subject: Re: [PATCH v5 7/8] Loongson: YeeLoong: add suspend driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     "Rafael J. Wysocki" <rjw@sisk.pl>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, Pavel Machek <pavel@ucw.cz>,
        linux-pm@lists.linux-foundation.org
In-Reply-To: <200911292335.40055.rjw@sisk.pl>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <f758058af5e45ec98bdc849e7762f32d795177e1.1259414649.git.wuzhangjin@gmail.com>
         <200911292335.40055.rjw@sisk.pl>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Mon, 30 Nov 2009 08:59:59 +0800
Message-ID: <1259542799.2427.9.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-11-29 at 23:35 +0100, Rafael J. Wysocki wrote:
> On Saturday 28 November 2009, Wu Zhangjin wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > This patch adds Suspend Driver, which will suspend the YeeLoong Platform
> > specific devices.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> > ---
> >  .../loongson/lemote-2f/yeeloong_laptop/Kconfig     |    9 ++
> >  .../loongson/lemote-2f/yeeloong_laptop/Makefile    |    1 +
> >  .../loongson/lemote-2f/yeeloong_laptop/suspend.c   |  141 ++++++++++++++++++++
> >  3 files changed, 151 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/mips/loongson/lemote-2f/yeeloong_laptop/suspend.c
> > 
> > diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > index c4398ff..49d63c5 100644
> > --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop/Kconfig
> > @@ -45,4 +45,13 @@ config YEELOONG_VO
> >  	  This option adds Video Output Driver, which provides standard
> >  	  interface to turn on/off the video output of LCD, CRT.
> >  
> > +config YEELOONG_SUSPEND
> > +	tristate "Suspend Driver"
> 
> Why tristate?

Allow it to be available as a module.

There are lots of platform specific drivers for Lemote-2F family
machines, benefit from tristate, the distribution developers can compile
them as modules, and then the users can load what they want for their
own machines.

> 
> > +	depends on YEELOONG_HWMON && YEELOONG_VO
> > +	select SUSPEND
> 
> I'm not sure if that's going to work.  Please make it depend on SUSPEND rather
> than select it.

Yes, Have replaced "select" by "depend on", thanks!

> 
> > +	default y
> > +	help
> > +	  This option adds Suspend Driver, which will suspend the YeeLoong
> > +	  Platform specific devices.
> > +
> >  endif
> 
> Thanks,
> Rafael

Thanks & Regards,
	Wu Zhangjin
