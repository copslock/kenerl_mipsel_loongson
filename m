Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 07:53:03 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:56888 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491036AbZLHGxA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 07:53:00 +0100
Received: by yxe42 with SMTP id 42so5169455yxe.22
        for <multiple recipients>; Mon, 07 Dec 2009 22:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=4DMXwcnf5DHuVLR0NDW43emnVxj4TE+CnE7lEzomZBo=;
        b=kuIx6krXo8y3FaouxSmR9NVGSmM1KSL/z12ldLkMlVG0lf56+KoXGADlirYGZ2cW1l
         VsB/gj1FsTY/L1OGKOaPT9SO5ewOzMDnSGx9QQy2BuwLFEte5tIZ6HiAaKEOvnFtSWED
         K87U0be3KGeStsyJZUw0kZBO25NYb5G4AMyxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=EfxRhkYH9GtE2DXw82g+dGfkHQqt2wrjk60EmytRA91YE1JJQ9QFh3Olil9j8UF6BI
         bkjDBDna0OZZzSJNX8r+gRXc0cEoz/ErFQruwJCs/j0FXajC3YUlgiK7cMoiM1GVOCqx
         5Cfbw1ixlgimuaW7YzH/l4YsY5eBvgyx4hBV0=
Received: by 10.90.253.16 with SMTP id a16mr12452855agi.3.1260255172769;
        Mon, 07 Dec 2009 22:52:52 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 34sm2906935yxf.65.2009.12.07.22.52.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 22:52:51 -0800 (PST)
Subject: Re: [PATCH v8 8/8] Loongson: YeeLoong: add input/hotkey driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20091207064857.GG21451@core.coreip.homeip.net>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
         <b164d5bb79963a57621d024c22e5664de0ff8662.1260082252.git.wuzhangjin@gmail.com>
         <20091207064857.GG21451@core.coreip.homeip.net>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 08 Dec 2009 14:52:11 +0800
Message-ID: <1260255131.3315.25.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Dmitry Torokhov

I plan to send another revision of this patchset, Can I get your
Acked-by: for this patch?

Thanks!
	Wu Zhangjin

On Sun, 2009-12-06 at 22:48 -0800, Dmitry Torokhov wrote:
> Hi Wu,
> 
> On Sun, Dec 06, 2009 at 03:01:48PM +0800, Wu Zhangjin wrote:
> > +
> > +#define EC_VER_LEN 64
> > +
> > +static int black_screen_handler(int status)
> > +{
> > +	char *p, ec_ver[EC_VER_LEN];
> > +
> > +	p = strstr(loongson_cmdline, "EC_VER=");
> > +	if (!p)
> > +		memset(ec_ver, 0, EC_VER_LEN);
> > +	else {
> > +		strncpy(ec_ver, p, EC_VER_LEN);
> > +		p = strstr(ec_ver, " ");
> > +		if (p)
> > +			*p = '\0';
> > +	}
> > +
> 
> Hmm, why do you copy and parse command lineinstead of using module
> param and also doing it just once?
> 
> > +	/* Seems EC(>=PQ1D26) does this job for us, we can not do it again,
> > +	 * otherwise, the brightness will not resume to the normal level! */
> > +	if (strncasecmp(ec_ver, "EC_VER=PQ1D26", 64) < 0)
> > +		yeeloong_lcd_vo_set(status);
> > +
> > +	return status;
> > +}
> 
> Thanks.
> 
