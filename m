Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 09:50:01 +0200 (CEST)
Received: from wr-out-0506.google.com ([64.233.184.225]:51422 "EHLO
	wr-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S8133469AbWEZHty convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 May 2006 09:49:54 +0200
Received: by wr-out-0506.google.com with SMTP id 69so10051wra
        for <linux-mips@linux-mips.org>; Fri, 26 May 2006 00:49:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RjD3o4iu6EJiykMAkpceS/9nZkWgLFNEUlCsrTMoL694o9ImX/9WMkr3R92QThToQn4bWWtOHaCeCVcvQWtEe3M84gc21MD2JXALoq5otWy+FmKyaoTfUn1dHUB2c1cVNJW85ZCAlQoOe3ziIGayl5NPjZ5RoMFsLd3EFJJ69Fc=
Received: by 10.54.114.4 with SMTP id m4mr244281wrc;
        Fri, 26 May 2006 00:49:52 -0700 (PDT)
Received: by 10.54.156.9 with HTTP; Fri, 26 May 2006 00:49:52 -0700 (PDT)
Message-ID: <5800c1cc0605260049q248c92b2k61b4727b1a782d96@mail.gmail.com>
Date:	Fri, 26 May 2006 15:49:52 +0800
From:	"Bin Chen" <binary.chen@gmail.com>
To:	"Herbert Valerio Riedel" <hvr@gnu.org>
Subject: Re: how does these two instruction mean?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1148628040.2150.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <5800c1cc0605252319l1fe2954amcd649fd4798259a2@mail.gmail.com>
	 <1148628040.2150.5.camel@localhost.localdomain>
Return-Path: <binary.chen@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: binary.chen@gmail.com
Precedence: bulk
X-list: linux-mips

What is dumb-mode?

On 5/26/06, Herbert Valerio Riedel <hvr@gnu.org> wrote:
> On Fri, 2006-05-26 at 14:19 +0800, Bin Chen wrote:
> > In my program the gcc produce two lines of binary code:
> >
> > 100020e0:       ffc20000        sd      v0,0(s8)
> > 100020e4:       dfc20000        ld      v0,0(s8)
> >
> > first store v0->[s8], then load from [s8]->v0, why?
>
> without knowing the source-code that got compiled it's guessing...
>
> and I'd guess that [s8] might have been marked as a volatile location
> (assuming the compiler isn't set to dumb-mode wrt to optimization ;-)
>
> e.g. a code like the following
>
> extern int cb(void);
>
> int set(volatile int *p)
> {
>   return *p = cb();
> }
>
> will lead to something similar to the fragment below (with s0 being the
> pointer p):
>
> [..]
>   38:   ae020000        sw      v0,0(s0)
>   3c:   8e020000        lw      v0,0(s0)
> [..]
>
> regards,
> hvr
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2.2 (GNU/Linux)
>
> iD8DBQBEdqxHSYHgZIg/QUIRAmLNAJ9aYiVRSnr9F4A+LhZOVB8pSCYL1ACeIq48
> Q+6zs8VJ6u0iNAVUEsVBupE=
> =iTAC
> -----END PGP SIGNATURE-----
>
>
>
