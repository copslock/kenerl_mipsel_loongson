Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2003 17:14:33 +0100 (BST)
Received: from p508B5EC1.dip.t-dialin.net ([IPv6:::ffff:80.139.94.193]:11394
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225235AbTDNQOd>; Mon, 14 Apr 2003 17:14:33 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3EGELn19111;
	Mon, 14 Apr 2003 18:14:21 +0200
Date: Mon, 14 Apr 2003 18:14:21 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: [patch] Board bus error handler clean-ups
Message-ID: <20030414181421.E9808@linux-mips.org>
References: <Pine.GSO.3.96.1030414144912.24742D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030414144912.24742D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 14, 2003 at 03:10:02PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 14, 2003 at 03:10:02PM +0200, Maciej W. Rozycki wrote:

>  Here is a patch that replaces the current temporary hack for board bus
> error handler initializers with the proper approach allowing platforms to
> install them dynamically, similarly to timer initializers.  It also
> trivially changes the names to follow other patterns. 
> 
>  As a side effect it nukes zillions of empty functions for platforms that
> don't have extra bus error functionality. 
> 
>  OK to apply?

Yes, please apply,

  Ralf
