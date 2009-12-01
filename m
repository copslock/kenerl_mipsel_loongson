Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 03:06:38 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:49610 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493255AbZLACGf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Dec 2009 03:06:35 +0100
Received: by pwi15 with SMTP id 15so2317008pwi.24
        for <multiple recipients>; Mon, 30 Nov 2009 18:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=AB5R2EqdxWRT+32k17d2yUY/SQZUz2J+snYCirYyft8=;
        b=KKWPlMRTWlQU7iBajoOr/kKaWr+/1SL08XFskPpbxaD2AOsChphkX9G3Mnt4+KJjsg
         eBWFi/Q96V3GhUAAiqVEF9NWWcFQLT5ttK+JyWgMiPMaK7+WFwnFEXkZ3Vohu62dq616
         N+R1EzIm7V8KcRkNTNIoa/3vuklOIwrNzklbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=BzKToS5xjM35u5LZ8bswmbxC49mgCpA8Dy5YGCzadBDYML8xs37RoFko5/mub/dpRw
         Ii6DO/uOTGEy12WrzU+/lIPLP5eVptdqk+/U0fXPoMuNLxc4vfE1lXrixbax6G2I6vcO
         3kiz0jv+5HKiFul/Xh5b7HXGIuvj9zSpKuLe4=
Received: by 10.114.249.4 with SMTP id w4mr9369290wah.186.1259633184448;
        Mon, 30 Nov 2009 18:06:24 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 20sm3321376pzk.5.2009.11.30.18.06.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 18:06:23 -0800 (PST)
Subject: Re: [PATCH v5 5/8] Loongson: YeeLoong: add hwmon driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com,
        huhb@lemote.com, lm-sensors@lm-sensors.org
In-Reply-To: <20091201014819.GA29728@linux-mips.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <ed9926f7d6acbf2abd2eb172ec5147e578dc8fb7.1259414649.git.wuzhangjin@gmail.com>
         <1259558432.5516.8.camel@falcon.domain.org>
         <1259562294.5516.16.camel@falcon.domain.org>
         <20091201014819.GA29728@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 01 Dec 2009 10:06:03 +0800
Message-ID: <1259633163.1894.24.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2009-12-01 at 01:48 +0000, Ralf Baechle wrote:
> On Mon, Nov 30, 2009 at 02:24:54PM +0800, Wu Zhangjin wrote:
> 
> > > > +config YEELOONG_HWMON
> > > > +	tristate "Hardware Monitor Driver"
> > > > +	select HWMON
> > > 
> > > Will use depend in the next version.
> > > 
> > 
> > Sorry, This must be select, there is no other way to select this stuff.
> 
> Why that?

Hmm, sorry, my old explanation is totally Wrong, it's better to select
it for us, just as the x86 platform drivers did:

$ cat drivers/platform/x86/Kconfig | grep " HWMON"
	select HWMON
	select HWMON

Because the HWMON stuff is put in the device drivers as a menuconfig,
but our platform driver is put in its own directory. it will not be
convenient for the users to select it themselves, and also, this select
have no side effect.

Best Regards,
	Wu Zhangjin
