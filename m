Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2003 12:51:07 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:36267
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225206AbTEOLvE>; Thu, 15 May 2003 12:51:04 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19GHFp-001Gc1-00; Thu, 15 May 2003 13:50:33 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19GHFo-0004PX-00; Thu, 15 May 2003 13:50:32 +0200
Date: Thu, 15 May 2003 13:50:32 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030515115032.GP8833@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030514184256.GE8833@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030515133141.16026A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030515133141.16026A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 14 May 2003, Thiemo Seufer wrote:
> 
> > >  Of course the choice of the default should be configurable (for binutils
> > > it probably already is
> > 
> > It isn't, and probably will never be. Of course you could introduce
> > just another configuration, with the bfd vector of your choice as
> > default.
> 
>  Hmm, I would assume "mipsn32*-linux" defaults to n32 and "mips64*-linux" 
> -- to (n)64.  It isn't the case, indeed.

IMHO it's not particularily useful to have both of these. I assume a n64
capable system will always implement n32 also, for better performance
and less memory consumption, and the majority of applications will run
as n32. IOW, there's little need for a n64-defaulting configuration.

But IIRC we disagree about this point.


Thiemo
