Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 14:59:03 +0100 (BST)
Received: from [IPv6:::ffff:216.208.38.107] ([IPv6:::ffff:216.208.38.107]:5763
	"EHLO OTTLS.pngxnet.com") by linux-mips.org with ESMTP
	id <S8225307AbVGVN6s>; Fri, 22 Jul 2005 14:58:48 +0100
Received: from bacchus.net.dhis.org ([10.255.255.134])
	by OTTLS.pngxnet.com (8.12.4/8.12.4) with ESMTP id j6ME0kBM001682;
	Fri, 22 Jul 2005 10:00:46 -0400
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j6ME0kGd030935;
	Fri, 22 Jul 2005 10:00:46 -0400
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j6ME0k1K030934;
	Fri, 22 Jul 2005 10:00:46 -0400
Date:	Fri, 22 Jul 2005 10:00:45 -0400
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050722140045.GA30896@linux-mips.org>
References: <20050721153359Z8225218-3678+3745@linux-mips.org> <20050722043057.GA3803@linux-mips.org> <20050722121030.GD1692@hattusa.textio> <20050722130655.GD3803@linux-mips.org> <Pine.LNX.4.61L.0507221417340.7324@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0507221417340.7324@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 22, 2005 at 02:24:48PM +0100, Maciej W. Rozycki wrote:

> > >  - the in-kernel use seems to be limited to the ELF binary object
> > >    loader and probably third party modules loaders
> > > I found moving to a consistent definition to be more useful than
> > > keeping the old inconsistent one.
> > 
> > I think you're confusing binutils's internal definitions with the use
> > everywhere else.
> 
>  In particular when in doubt please refer to ELF standards which state 
> "EF_" is the prefix for processor-specific flags in "e_flags" in the ELF 
> file header; similarly with "EM_" for "e_machine" and "ET_" for "e_type" 
> -- you should see the pattern.  There is no mention of the "E_" prefix in 
> the standards.

Which makes me wonder why glibc has the E_ definitions.  Other operating
systems that I looked up don't.

  Ralf
