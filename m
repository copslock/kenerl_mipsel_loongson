Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 15:36:04 +0100 (BST)
Received: from p508B74BA.dip.t-dialin.net ([IPv6:::ffff:80.139.116.186]:61590
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225264AbTDOOgD>; Tue, 15 Apr 2003 15:36:03 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3FEZwg09071;
	Tue, 15 Apr 2003 16:35:58 +0200
Date: Tue, 15 Apr 2003 16:35:58 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] cp0.config access macros
Message-ID: <20030415163558.B8778@linux-mips.org>
References: <Pine.GSO.3.96.1030415155224.13254F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030415155224.13254F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Tue, Apr 15, 2003 at 04:07:18PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 15, 2003 at 04:07:18PM +0200, Maciej W. Rozycki wrote:

>  Cryptic cp0.config accesses using hardcoded numbers are scattered through
> the sources.  I propose adding a few definitions to improve readability
> and ease grepping the sources.  This is for solely for cp0.config now -- I
> fixed all references I had docs handy for.  The next step should probably
> be cp0.config1.
> 
>  Beside that, the following patch fixes cache size units to be kilobytes
> instead of kilobits and fixes the R4000SC erratum #5 trigger. 
> 
>  OK?

Yep.

(I'm not sure if in case of the IC, IB, DC and DB bits this is not adding
some confusion - the same bits with slightly different meaning or position
exist in various processors so we may want some distinguishable names
eventually)

  Ralf
