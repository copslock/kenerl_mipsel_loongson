Received:  by oss.sgi.com id <S553768AbRB1M63>;
	Wed, 28 Feb 2001 04:58:29 -0800
Received: from u-155-18.karlsruhe.ipdial.viaginterkom.de ([62.180.18.155]:15108
        "EHLO u-155-18.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553690AbRB1M6S>; Wed, 28 Feb 2001 04:58:18 -0800
Received: from [193.98.169.28] ([193.98.169.28]:55936 "EHLO
	dea.waldorf-gmbh.de") by bacchus.dhis.org with ESMTP
	id <S870768AbRB1M5p>; Wed, 28 Feb 2001 04:57:45 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1SCuS705711;
	Wed, 28 Feb 2001 13:56:28 +0100
Date:	Wed, 28 Feb 2001 13:56:28 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc:	Fabrice Bellard <bellard@email.enst.fr>, linux-mips@oss.sgi.com
Subject: Re: Serious bug in uaccess.h
Message-ID: <20010228135628.C5452@bacchus.dhis.org>
References: <20010227232227.B384@email.enst.fr> <Pine.GSO.3.96.1010228130945.6646A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010228130945.6646A-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Wed, Feb 28, 2001 at 01:47:27PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Feb 28, 2001 at 01:47:27PM +0100, Maciej W. Rozycki wrote:
> Date: Wed, 28 Feb 2001 13:47:27 +0100 (MET)
> From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
> To: Fabrice Bellard <bellard@email.enst.fr>,
>         Ralf Baechle <ralf@uni-koblenz.de>
> cc: linux-mips@oss.sgi.com
> Subject: Re: Serious bug in uaccess.h
> 
> On Tue, 27 Feb 2001, Fabrice Bellard wrote:
> 
> > I mean the code in arch/mips/lib/memcpy.S. It is possible to modify
> > __copy_user so that it has exactly the same calling convention of a C
> > function. Then, no asm is necessary in uaccess.h. It costs us a
> > supplementary jump.
> 
>  You mean the supplementary return value in a2?  Hmm, it is always set to
> zero!  Also "addu $1, %2, %3" makes no sense.
> 
>  Ralf, the code is weird.  The header implies you are the author.  Could
> you please elaborate what you meant in copy_*_user()? 

I'll look at it and try to recall :-)

  Ralf
