Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 12:01:43 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:55022 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493547AbZLGLBk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2009 12:01:40 +0100
Received: by pzk35 with SMTP id 35so3841743pzk.22
        for <multiple recipients>; Mon, 07 Dec 2009 03:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=jtnOkXIMgedGirpDhioY0DU/ZUSkz9YUkSjMrlGwo40=;
        b=wWHfUGz+WiVZepbH+uMIo9yYC0H7hkwGuN0yqRKNgMlT2WDQaTQlTDYdTdePiRSsdN
         D7w9Qp7kvmSuTD/E2pipcQ/LCeHMZ5rh94MC19IunrNmMZmZCv1yipze1xOz2lvwWBIE
         Emac1OrClpnH6aDQ4sxuY7oQ0V3Fm5o6jejcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=ClHG3AMu540gHA4ezSe3pFIw6t8Ua1AX179dvii5mtWT41/xGttlHGBeOVTl+OPqN5
         /Kx5/ripjFQD4f90rWpwzGQ2O1AzyzVyKvvZNRUGHqLnxWz4hiqCOAtlNqS2AKzO1riW
         W9b+2rB8zV57ey5ZAE3/XzN9Y0yX0Y4Vdc5V8=
Received: by 10.114.6.28 with SMTP id 28mr11339181waf.115.1260183691857;
        Mon, 07 Dec 2009 03:01:31 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm5073985pzk.6.2009.12.07.03.01.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Dec 2009 03:01:31 -0800 (PST)
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
Date:   Mon, 07 Dec 2009 19:01:03 +0800
Message-ID: <1260183663.9092.51.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

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
> 	

Done, but any document/standard about it?

Regards,
	Wu Zhangjin
