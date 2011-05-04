Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 May 2011 17:04:18 +0200 (CEST)
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35979 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491040Ab1EDPEP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 May 2011 17:04:15 +0200
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 549738EE11E;
        Wed,  4 May 2011 08:04:07 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 73FMpYj8FZQo; Wed,  4 May 2011 08:04:07 -0700 (PDT)
Received: from [192.168.2.10] (dagonet.hansenpartnership.com [76.243.235.53])
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 988D58EE0BE;
        Wed,  4 May 2011 08:04:05 -0700 (PDT)
Subject: Re: [PATCH] atomic: add *_dec_not_zero
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Mike Frysinger <vapier.adi@gmail.com>
Cc:     Sven Eckelmann <sven@narfation.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Chris Metcalf <cmetcalf@tilera.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <BANLkTiminpyJ_opxhqG0E0gBOrF490b+tQ@mail.gmail.com>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
         <BANLkTiminpyJ_opxhqG0E0gBOrF490b+tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 04 May 2011 10:04:04 -0500
Message-ID: <1304521444.2810.23.camel@mulgrave.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.1 
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
Precedence: bulk
X-list: linux-mips

On Wed, 2011-05-04 at 00:44 -0400, Mike Frysinger wrote:
> On Tue, May 3, 2011 at 17:30, Sven Eckelmann wrote:
> > Introduce an *_dec_not_zero operation.  Make this a special case of
> > *_add_unless because batman-adv uses atomic_dec_not_zero in different
> > places like re-broadcast queue or aggregation queue management. There
> > are other non-final patches which may also want to use this macro.
> >
> > Cc: uclinux-dist-devel@blackfin.uclinux.org
> >
> > --- a/arch/blackfin/include/asm/atomic.h
> > +++ b/arch/blackfin/include/asm/atomic.h
> > @@ -103,6 +103,7 @@ static inline int atomic_test_mask(int mask, atomic_t *v)
> >        c != (u);                                               \
> >  })
> >  #define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
> > +#define atomic_dec_not_zero(v) atomic_add_unless((v), -1, 0)
> >
> >  /*
> >  * atomic_inc_and_test - increment and test
> 
> no opinion on the actual idea, but for the Blackfin pieces:
> Acked-by: Mike Frysinger <vapier@gentoo.org>

This goes for parisc as well.

Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>

James
