Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jun 2005 08:26:38 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:60422 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225944AbVFNH0X>; Tue, 14 Jun 2005 08:26:23 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j5E7NeAT005394;
	Tue, 14 Jun 2005 08:23:40 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j5E7NdFo005393;
	Tue, 14 Jun 2005 08:23:39 +0100
Date:	Tue, 14 Jun 2005 08:23:39 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix fallback atomic operations
Message-ID: <20050614072339.GA5183@linux-mips.org>
References: <Pine.LNX.4.61L.0506132131030.1725@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506132131030.1725@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 13, 2005 at 09:40:20PM +0100, Maciej W. Rozycki wrote:

>  You may argue it's best to define a private copy of "cpu_has_llsc"  
> expanding to a constant for selecting the right set of atomic operations 
> at the compilation time and I would agree, but AFAIK the whole idea behind 
> our current implementation is to provide a snail-speed fallback or perhaps 
> to support more generic configurations at one point (e.g. one kernel for 
> all DECstations).
> 
>  For most processor settings the current setup already works, as they 
> provide ll/sc anyway, but not for MIPS I ones, like the R3k.  Here's a 
> patch that makes the affected code work for such processors as well.
> 
>  OK to apply?

Go ahead.

Al had a bunch of other complaints which I'll try to take care of asap.

  Ralf
