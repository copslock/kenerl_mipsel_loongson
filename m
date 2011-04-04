Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Apr 2011 16:10:06 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:50304 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491137Ab1DDOKD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Apr 2011 16:10:03 +0200
Received: by wwb17 with SMTP id 17so5625259wwb.24
        for <multiple recipients>; Mon, 04 Apr 2011 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=kCmM27D4tp2kTmrFuEyuhe399TUQzmE8LNR3lwtlzeQ=;
        b=N9YU73bt5YVcww1RlhLCa/4gaqnZp7lR1i1AIrQcerYIJCbDv+vCH89KEWYLCWTar2
         Twixj9yqVfvAaiTY+ijkUxwplCiz2OOX37sRpey+WJZicpXF86S1eu4ILGBJsgL62Q08
         qm/5nIGDzm/+1Rw/j+bNgX9DIcd/VircF9Pkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=xLgssEPxubnIEStvKJklxbD8HjyUEUFKe1x+pYn/FJGI/14EsX7UeORIvGdKjP/bMK
         vwOiyk/wm0oJ5/JJ+nxEqEX+VumkCIq0F8jhyh3L92/3NK8Y8yP4uGatZn1TSFKqCbyJ
         QNAVFZ3VDMXA8V5jyhU7lGnco+b/wZjphOdp0=
Received: by 10.227.140.67 with SMTP id h3mr7039708wbu.80.1301926197527;
        Mon, 04 Apr 2011 07:09:57 -0700 (PDT)
Received: from ?IPv6:::1? (shutemov.name [188.40.19.243])
        by mx.google.com with ESMTPS id w25sm2938479wbd.56.2011.04.04.07.09.55
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 07:09:56 -0700 (PDT)
Subject: Re: [PATCH V5 06/10] MIPS: lantiq: add NOR flash support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <4D99C974.5060800@openwrt.org>
References: <1301470076-17279-1-git-send-email-blogic@openwrt.org>
         <1301470076-17279-7-git-send-email-blogic@openwrt.org>
         <1301661832.2789.56.camel@localhost>  <4D99C974.5060800@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 04 Apr 2011 17:07:25 +0300
Message-ID: <1301926045.2760.86.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Content-Transfer-Encoding: 8bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, 2011-04-04 at 15:36 +0200, John Crispin wrote:
> >> +ltq_copy_from(struct map_info *map, void *to,
> >> +	unsigned long from, ssize_t len)
> >> +{
> >> +	unsigned char *f = (unsigned char *) (map->virt + from);
> >> +	unsigned char *t = (unsigned char *) to;
> >> +	unsigned long flags;
> >> +
> >> +	spin_lock_irqsave(&ebu_lock, flags);
> >> +	while (len--)
> >> +		*t++ = *f++;
> >> +	spin_unlock_irqrestore(&ebu_lock, flags);
> >>     
> > Can you use memcpy here instead?
> >
> >   
> as we are copying to/from iomem, we cannot use memcpy as the
> pre-fetching breaks the copy process. the normal alternative is to use
> memcpy_to/fromio, however on MIPS this breaks down to a normal memcpy.

Would be nice to have this comment in the code to make life of those who
reads it a bit easier.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
