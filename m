Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2003 18:24:50 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:46585 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225207AbTHARYs>;
	Fri, 1 Aug 2003 18:24:48 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h71HOhg11323;
	Fri, 1 Aug 2003 10:24:43 -0700
Date: Fri, 1 Aug 2003 10:24:43 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] More time fixes: do_gettimeofday() & do_settimeofday()
Message-ID: <20030801102443.E11120@mvista.com>
References: <Pine.GSO.3.96.1030801134735.3800D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1030801134735.3800D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Aug 01, 2003 at 02:04:29PM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Aug 01, 2003 at 02:04:29PM +0200, Maciej W. Rozycki wrote:
> Hello,
> 
>  Here are fixes for do_gettimeofday() and do_settimeofday() not taking the
> wall time and the value of tick properly into account.  OK to apply? 
>

That looks right to me.  I have fixed them internally, but never get around
to push into the linux-mips tree.

To be nit-picking, I might want to replace 'tick' with 'USECS_PER_JIFFY'.

Jun
