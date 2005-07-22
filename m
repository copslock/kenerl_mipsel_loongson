Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 15:16:43 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:5813 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8225313AbVGVOQ1>;
	Fri, 22 Jul 2005 15:16:27 +0100
Received: from port-195-158-170-19.dynamic.qsc.de ([195.158.170.19] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DvyM6-0003QR-00; Fri, 22 Jul 2005 16:18:26 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DvyM6-00067m-8x; Fri, 22 Jul 2005 16:18:26 +0200
Date:	Fri, 22 Jul 2005 16:18:26 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050722141826.GG1692@hattusa.textio>
References: <20050721153359Z8225218-3678+3745@linux-mips.org> <20050722043057.GA3803@linux-mips.org> <20050722121030.GD1692@hattusa.textio> <20050722130655.GD3803@linux-mips.org> <Pine.LNX.4.61L.0507221417340.7324@blysk.ds.pg.gda.pl> <20050722140045.GA30896@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050722140045.GA30896@linux-mips.org>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Fri, Jul 22, 2005 at 02:24:48PM +0100, Maciej W. Rozycki wrote:
> 
> > > >  - the in-kernel use seems to be limited to the ELF binary object
> > > >    loader and probably third party modules loaders
> > > > I found moving to a consistent definition to be more useful than
> > > > keeping the old inconsistent one.
> > > 
> > > I think you're confusing binutils's internal definitions with the use
> > > everywhere else.
> > 
> >  In particular when in doubt please refer to ELF standards which state 
> > "EF_" is the prefix for processor-specific flags in "e_flags" in the ELF 
> > file header; similarly with "EM_" for "e_machine" and "ET_" for "e_type" 
> > -- you should see the pattern.  There is no mention of the "E_" prefix in 
> > the standards.
> 
> Which makes me wonder why glibc has the E_ definitions.  Other operating
> systems that I looked up don't.

The MIPS ELF ABI supplement mandates those bits to be zero (for MIPS I),
consequentially it doesn't need to specify names for them.


Thiemo
