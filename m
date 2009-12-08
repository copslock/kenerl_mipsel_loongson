Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2009 07:51:40 +0100 (CET)
Received: from mail-yw0-f203.google.com ([209.85.211.203]:65521 "EHLO
        mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491036AbZLHGvh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2009 07:51:37 +0100
Received: by ywh41 with SMTP id 41so7394148ywh.0
        for <multiple recipients>; Mon, 07 Dec 2009 22:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=EtAEBQV8n0GY8JzHypYEVZXP+R2oo7mma7FaJgup1L4=;
        b=EOAb0iN07i/YeORR6XuxZFy9SAsb2dh6h1Sum9p0ns1ABAo8cPQsgoITS+C/VoodbN
         ryKrA7JSvVaZg2+ZzeatmfZY88kIBmk2IT7ZWJAoTiANrZlW7f/wWfz8ZTRZX/7HBhnI
         p14xiBLZXfE7A7zVzOZM4G4RST3dVI9cbFx20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=AJUjP9wk8l+WV3InT9Sq1jIkMlUA3zdhN73j/lys+IPlbdhYJJQIeu71PTGBlyVEMB
         wBSttF5g18OHlu0q49E/fuMVesQYT7dDahjy4c9Fzg0/a6oSgugouM7YY3CCPCyz3bGd
         gL1RzLyX1HgAexVC1C5dlUbfHyAO32l45lRS0=
Received: by 10.90.21.8 with SMTP id 8mr1816536agu.35.1260255088635;
        Mon, 07 Dec 2009 22:51:28 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm3985032iwn.12.2009.12.07.22.51.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 22:51:26 -0800 (PST)
Subject: Re: [PATCH v8 5/8] Loongson: YeeLoong: add hardware monitoring
 driver
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ralf Baechle <ralf@linux-mips.org>, akpm@linux-foundation.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J . Wysocki" <rjw@sisk.pl>, zhangfx@lemote.com,
        linux-laptop@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20091207094909.GD23088@elf.ucw.cz>
References: <cover.1260082252.git.wuzhangjin@gmail.com>
         <d8789fa7e97d8a170c4e2516d7ef2d2fbbe42cc6.1260082252.git.wuzhangjin@gmail.com>
         <20091206084717.GD2766@ucw.cz> <1260147298.3126.2.camel@falcon.domain.org>
         <20091207080446.GB23088@elf.ucw.cz>
         <1260178870.9092.34.camel@falcon.domain.org>
         <20091207094909.GD23088@elf.ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 08 Dec 2009 14:50:56 +0800
Message-ID: <1260255056.3315.23.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Pavel Machek

After fixing the get_battery_current(), can I get your Acked-by: for the
next revision of this patch?

Thanks!
	Wu Zhangjin

On Mon, 2009-12-07 at 10:49 +0100, Pavel Machek wrote:
> On Mon 2009-12-07 17:41:10, Wu Zhangjin wrote:
> > On Mon, 2009-12-07 at 09:04 +0100, Pavel Machek wrote:
> > > > > What is going on here? I thought the value is already in two's
> > > > > complement... Is the above equivalent of
> > > > > 
> > > > > 	      if (value < 0)
> > > > > 	      	 value = -value; 
> > > > > 
> > > > > ? If so, why? If not, can you add a comment?
> > > > 
> > > > Right, then, will use this instead:
> > > > 
> > > > static int get_battery_current(void)
> > > > { 
> > > > 	s16 value;
> > > > 
> > > > 	value = (ec_read(REG_BAT_CURRENT_HIGH) << 8) |
> > > > 		(ec_read(REG_BAT_CURRENT_LOW));
> > > > 
> > > > 	return abs(value);
> > > > }
> > > 
> > > That's certainly better. But... why not return signed value? Current
> > > flowing from the battery is certainly very different from current
> > > flowing into it...
> > 
> > You are totally right ;)
> > 
> > Just test it, when flowing from the battery, the value is negative, and
> > when flowing into the battery, the value is positive, so, no abs()
> > needed. thanks!
> 
> Make it return -value, then. I believe other code uses >0 values for
> discharge.
> 									Pavel
> 
