Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 17:16:59 +0100 (MET)
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:16801 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S869533AbSK1QQs>; Thu, 28 Nov 2002 17:16:48 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gASGFJh18257;
	Thu, 28 Nov 2002 17:15:19 +0100
Date: Thu, 28 Nov 2002 17:15:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: a quick question regarding CONFIG_MIPS_UNCACHED..
Message-ID: <20021128171519.A18165@linux-mips.org>
References: <20021127091114.27117.qmail@webmail24.rediffmail.com> <Pine.GSO.3.96.1021128164709.8C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021128164709.8C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Nov 28, 2002 at 04:51:57PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 28, 2002 at 04:51:57PM +0100, Maciej W. Rozycki wrote:

>  You are looking at obsolete code -- unless you have specific conditions
> to use an explicit caching attribute for KSEG0, you should set it like the
> rest of the code does it, i.e.:
> 
> change_cp0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
> 
> To avoid surprises here and elsewhere, you should make sure
> CONFIG_NONCOHERENT_IO is set appropriately, too.

We've talked about this before - the specification of the ll/sc
instructions says they only work ok on cached memory.  In the real world
they seem to work also in uncached memory but I'd not bet the farm on
that, too many implementations out there, too many chances for subtle
bugs.

  Ralf
