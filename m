Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 01:13:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:18592 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S28597311AbYITANs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 20 Sep 2008 01:13:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m8K0DkRO002903;
	Sat, 20 Sep 2008 02:13:46 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m8K0DiOj002901;
	Sat, 20 Sep 2008 02:13:44 +0200
Date:	Sat, 20 Sep 2008 02:13:44 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, u1@terran.org,
	linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
Message-ID: <20080920001344.GC31314@linux-mips.org>
References: <20080917.222350.41199051.anemo@mba.ocn.ne.jp> <BD7F24AB-4B0C-4FA4-ADB3-5A86E7A4624F@terran.org> <20080919.011704.59652451.anemo@mba.ocn.ne.jp> <20080920.004319.93205397.anemo@mba.ocn.ne.jp> <Pine.LNX.4.55.0809191656030.29711@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0809191656030.29711@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 19, 2008 at 05:09:17PM +0100, Maciej W. Rozycki wrote:

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
> suitable oddity (which I haven't checked).  You want something like:
> 
> 	dsll32	t1, t1, 0
> 	dsrl32	t1, t1, 0
> 
> instead.

For a one's complement checksum it doesn't matter in which of the 4
halfwords the data ends is loaded.  So the easiest solution is:

	/* Still a full word to go  */
	ulw     t1, (src)
#ifdef USE_DOUBLE
	dsll	t1, t1, 32		/* clear lower 32bit */
#endif
	PTR_ADDIU       src, 4
	ADDC(sum, t1)

  Ralf
