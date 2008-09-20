Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Sep 2008 14:45:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:56264 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S30634769AbYITNpQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 20 Sep 2008 14:45:16 +0100
Received: from localhost (p4081-ipad310funabasi.chiba.ocn.ne.jp [123.217.206.81])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 3B3A9AA6D; Sat, 20 Sep 2008 22:45:09 +0900 (JST)
Date:	Sat, 20 Sep 2008 22:45:30 +0900 (JST)
Message-Id: <20080920.224530.25909560.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, u1@terran.org, linux-mips@linux-mips.org
Subject: Re: MIPS checksum bug
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080920001344.GC31314@linux-mips.org>
References: <20080920.004319.93205397.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.55.0809191656030.29711@cliff.in.clinika.pl>
	<20080920001344.GC31314@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 20 Sep 2008 02:13:44 +0200, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > +#ifdef USE_DOUBLE
> > > +	add	t1, zero	/* clear upper 32bit */
> > > +#endif
> > >  	PTR_ADDIU	src, 4
> > >  	ADDC(sum, t1)
> > >  
> > 
> >  Unfortunately you can't zero-extend with a single instruction (you can
> > use a single sll(v) to sign-extend), unless the R2 ISA provides some
> > suitable oddity (which I haven't checked).  You want something like:
> > 
> > 	dsll32	t1, t1, 0
> > 	dsrl32	t1, t1, 0
> > 
> > instead.
> 
> For a one's complement checksum it doesn't matter in which of the 4
> halfwords the data ends is loaded.  So the easiest solution is:
> 
> 	/* Still a full word to go  */
> 	ulw     t1, (src)
> #ifdef USE_DOUBLE
> 	dsll	t1, t1, 32		/* clear lower 32bit */
> #endif
> 	PTR_ADDIU       src, 4
> 	ADDC(sum, t1)

Oops, my fault.  Thank you all.

---
Atsushi Nemoto
