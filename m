Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 17:35:54 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:39332 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S28664092AbYISQfr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 17:35:47 +0100
Received: from lagash (p549AFB0C.dip.t-dialin.net [84.154.251.12])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01.mx.bawue.net (Postfix) with ESMTP id 325FF48916;
	Fri, 19 Sep 2008 18:35:44 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.69)
	(envelope-from <ths@networkno.de>)
	id 1KgixG-0007yY-Nd; Fri, 19 Sep 2008 18:35:38 +0200
Date:	Fri, 19 Sep 2008 18:35:38 +0200
From:	Thiemo Seufer <ths@networkno.de>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, u1@terran.org,
	linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
Message-ID: <20080919163538.GA22497@networkno.de>
References: <20080917.222350.41199051.anemo@mba.ocn.ne.jp> <BD7F24AB-4B0C-4FA4-ADB3-5A86E7A4624F@terran.org> <20080919.011704.59652451.anemo@mba.ocn.ne.jp> <20080920.004319.93205397.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809191656030.29711@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0809191656030.29711@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Sat, 20 Sep 2008, Atsushi Nemoto wrote:
> 
> > @@ -229,6 +239,9 @@ LEAF(csum_partial)
> >  
> >  	/* Still a full word to go  */
> >  	ulw	t1, (src)
> > +#ifdef USE_DOUBLE
> > +	add	t1, zero	/* clear upper 32bit */
> > +#endif
> >  	PTR_ADDIU	src, 4
> >  	ADDC(sum, t1)
> >  
> 
>  Unfortunately you can't zero-extend with a single instruction (you can
> use a single sll(v) to sign-extend), unless the R2 ISA provides some
> suitable oddity (which I haven't checked).

AFAIR dext can do this for MIPS64 R2.


Thiemo
