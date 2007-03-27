Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 09:02:21 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.175]:18890 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021590AbXC0ICT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Mar 2007 09:02:19 +0100
Received: by ug-out-1314.google.com with SMTP id 40so2022516uga
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2007 01:01:19 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PsfNGRiRoIFL5RjMAaW76AwRu9AeeyIwwtoqloOGPKlMKb+3LVE1IkyQXY9VlrVNlwuasIbb5x0cZk5ayxM/IRZ7lk8Q9KXJixbvTi7FzLPAp4AJUMNDKOx/yeg11qNYVKSLtoFLWVS42R88l+Ct2u6AGsfGHY6hCpB4rTCKr7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M7grxJReSRR7mWby7GtHhMKBfZOTky4VW6IW6lHDkuXbbcqnYl+nybGSs5oGht+ltTMg+gzDChOqUvxewhx9h2EYaiZUa7llaBnhUTcm787gCjmSAF7b4S9Fvvj0I5y1IIaZJfhEDtoyoO8TFSRB1mwUULkaenF79DGxiJYGmhc=
Received: by 10.115.74.1 with SMTP id b1mr3049956wal.1174982478006;
        Tue, 27 Mar 2007 01:01:18 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Tue, 27 Mar 2007 01:01:17 -0700 (PDT)
Message-ID: <cda58cb80703270101p1641cfctdef455e55f275dec@mail.gmail.com>
Date:	Tue, 27 Mar 2007 10:01:17 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Cc:	ralf@linux-mips.org, kumba@gentoo.org, linux-mips@linux-mips.org,
	ths@networkno.de
In-Reply-To: <20070327.121232.71086507.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80703260831t576ff7c5wef1e34e3367e7c45@mail.gmail.com>
	 <20070327.004511.31449250.anemo@mba.ocn.ne.jp>
	 <cda58cb80703260907g6f349298xf85b2e2954a7b6a7@mail.gmail.com>
	 <20070327.121232.71086507.nemoto@toshiba-tops.co.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/27/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Mon, 26 Mar 2007 18:07:21 +0200, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > ok, I suppose a warning is fine. What about this patch on top of the patchset ?
> >
> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index 3ec0c12..b886945 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -627,7 +627,12 @@ ifdef CONFIG_64BIT
> >    endif
> >
> >    ifeq ($(KBUILD_SYM32), y)
> > -    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
> > +    ifeq ($(call cc-option-yn,-msym32), y)
> > +      cflags-y += -msym32 -DKBUILD_64BIT_SYM32
> > +    else
> > +      $(warning '-msym32' option is not supported by your compiler. \
> > +               You should use a new one to get best result)
> > +    endif
> >    endif
> >  endif
>
> Well, I feel even a warning is intrusive, while it is not necessary
> optimization.
>

OK, I'll remove it.

thanks
-- 
               Franck
