Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2004 15:48:31 +0100 (BST)
Received: from fed1rmmtao02.cox.net ([IPv6:::ffff:68.230.241.37]:36007 "EHLO
	fed1rmmtao02.cox.net") by linux-mips.org with ESMTP
	id <S8225206AbUJUOsX>; Thu, 21 Oct 2004 15:48:23 +0100
Received: from opus ([68.107.143.141]) by fed1rmmtao02.cox.net
          (InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
          id <20041021144816.XYNI6045.fed1rmmtao02.cox.net@opus>;
          Thu, 21 Oct 2004 10:48:16 -0400
Date: Thu, 21 Oct 2004 07:48:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.9] KSEG/CKSEG fixes
Message-ID: <20041021144815.GB25441@smtp.west.cox.net>
References: <20041021001427.GA25441@smtp.west.cox.net> <20041021070921.GA2297@umax645sx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021070921.GA2297@umax645sx>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 21, 2004 at 09:09:21AM +0200, Ladislav Michl wrote:
> On Wed, Oct 20, 2004 at 05:14:27PM -0700, Tom Rini wrote:
> > The following is needed to get an SB1250 to compile & boot in 64bit
> > mode (briefly tested).
> > 
> > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> > 
> > --- linux-2.6.9.orig/arch/mips/mm/c-sb1.c
> > +++ linux-2.6.9/arch/mips/mm/c-sb1.c
> > @@ -488,7 +488,11 @@ void ld_mmu_sb1(void)
> >  	/* Special cache error handler for SB1 */
> >  	memcpy((void *)(CAC_BASE   + 0x100), &except_vec2_sb1, 0x80);
> >  	memcpy((void *)(UNCAC_BASE + 0x100), &except_vec2_sb1, 0x80);
> > +#ifdef CONFIG_MIPS64
> > +	memcpy((void *)CKSEG1ADDR(&handle_vec2_sb1), &handle_vec2_sb1, 0x80);
> > +#else
> >  	memcpy((void *)KSEG1ADDR(&handle_vec2_sb1), &handle_vec2_sb1, 0x80);
> > +#endif
> 
> I don't think this is best solution. Thomas Bogendoerfer messed with
> KSEG/CKSEG definitions recently and idea is to create board specific
> header file spaces.h

Would this include abstracting the notion of KSEG1/CKSEG1 into something
where one name would get the right var on 32 or 64 ?  If so, is this in
CVS now?  If not, wouldn't it make sense to put this in now and convert
it when the changes do go in?

-- 
Tom Rini
http://gate.crashing.org/~trini/
