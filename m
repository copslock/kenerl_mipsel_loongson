Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2007 18:10:39 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:27295 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037877AbXBUSKh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Feb 2007 18:10:37 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1LIAcuC005652;
	Wed, 21 Feb 2007 18:10:38 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1LIAbLi005651;
	Wed, 21 Feb 2007 18:10:37 GMT
Date:	Wed, 21 Feb 2007 18:10:37 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix mmiowb() for MIPS I
Message-ID: <20070221181037.GB4157@linux-mips.org>
References: <20070222.021014.85684636.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0702211727530.29504@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0702211727530.29504@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 21, 2007 at 05:46:18PM +0000, Maciej W. Rozycki wrote:

> > diff --git a/include/asm-mips/io.h b/include/asm-mips/io.h
> > index 92ec261..855c304 100644
> > --- a/include/asm-mips/io.h
> > +++ b/include/asm-mips/io.h
> > @@ -502,8 +502,7 @@ BUILDSTRING(q, u64)
> >  #endif
> >  
> >  
> > -/* Depends on MIPS II instruction set */
> > -#define mmiowb() asm volatile ("sync" ::: "memory")
> > +#define mmiowb() __sync()
> >  
> >  static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
> >  {
> 
>  That's still not correct -- it should probably be defined like mb() 
> currently is as the write-back buffer may defeat strong ordering (IIRC, 
> the R2020 can do byte merging).  Also the semantics of mmiowb() does not 
> seem to be well specified -- I gather a sequence of:
> 
> 	writeb(mmioreg, val);
> 	mmiowb();
> 	readb(mmioreg);
> 
> should guarantee "val" has reached the register (mmiowb() replacing 
> incorrect mb() used in many places like this), but with either definition 
> of mmiowb() and a MIPS-I-style external write-back buffer it will not 
> work.

Does a read from the same device suffice to provide the necessary flushing
the same way as it does on PCI?

I'm not opposed to allowing platform specific definitions for operations
like mmiowbb() but I think we really should get rid of the special MIPS
iob() operation.

  Ralf
