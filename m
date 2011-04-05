Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2011 16:29:27 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:36580 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491768Ab1DEO3Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 5 Apr 2011 16:29:24 +0200
Received: by ewy3 with SMTP id 3so136988ewy.36
        for <multiple recipients>; Tue, 05 Apr 2011 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:reply-to:to:cc:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=XykkLfmIU2yUBfwPEX0XastlRZqvYOwUwDPpRCnKKws=;
        b=PjnmjHjG+zc+VwPZJohbALnQgwIanJp+44R7SJpwFFVPUX9v+abwmf6z44fz4ox3Mq
         yWKAGIC68JpZpAFdKQ9FMEiFDATu52ZqwqUwEpV2lGQa3YXGL+IU9GXSdSB8iZpFExPu
         GdXjqOuERPc54GSmGzpaPQblZHzkcMr0iAfSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=cnuqJzggZGHVmJie1UsHOGum3lTLRA7SQJwsx/DDYOzlX3kF8FYsGuIcaZFwue2aEg
         M3o7KlHVNlCdH3DlvAtEV530hdysLE9OYWsxFU0J2SpT/1BL7+qb4kTtGMVL5+UoqB6r
         KToAn+0bitWCjGTltHnp8gOojE0u4+N984UuU=
Received: by 10.213.34.207 with SMTP id m15mr2243098ebd.89.1302013758495;
        Tue, 05 Apr 2011 07:29:18 -0700 (PDT)
Received: from ?IPv6:::1? (shutemov.name [188.40.19.243])
        by mx.google.com with ESMTPS id y7sm4023261eeh.21.2011.04.05.07.29.16
        (version=SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 07:29:17 -0700 (PDT)
Subject: Re: [PATCH V8] MIPS: lantiq: add NOR flash support
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mtd@lists.infradead.org,
        Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>,
        David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1302013192-8854-1-git-send-email-blogic@openwrt.org>
References: <1302013192-8854-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Tue, 05 Apr 2011 17:26:38 +0300
Message-ID: <1302013598.2760.140.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 (2.32.2-1.fc14) 
Content-Transfer-Encoding: 8bit
Return-Path: <dedekind1@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, 2011-04-05 at 16:19 +0200, John Crispin wrote:

> +/* 
> + * The NOR flash is connected to the same external bus unit (EBU) as PCI.
> + * To make PCI work we need to enable the endianess swapping for the address
> + * written to the EBU. This endianess swapping works for PCI correctly but
> + * fails for attached NOR devices. To workaround this we need to use a complex
> + * map. The workaround involves swapping all addresses whilste probing the chip.
> + * Once probing is complete we stop swapping the addresses but swizzle the
> + * unlock addresses to ensure that access to the NOR device works correctly.
> + */
> +
> +enum ltq_nor_state {
> +	LTQ_NOR_PROBING,
> +	LTQ_NOR_NORMAL
> +};

You do not have to re-send because of this, just a note that in this
case it makes more sense to use anonymous enum. Indeed, you do not need
this 'ltq_nor_state' name at all, and C enums are not proper types
anyway (no real type-checking), so it is just a tiny bit nicer to do:

enum {
	LTQ_NOR_PROBING,
	LTQ_NOR_NORMAL
};

But this is not important at all, just a side note :-)

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
