Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 01:19:02 +0000 (GMT)
Received: from p508B6845.dip.t-dialin.net ([IPv6:::ffff:80.139.104.69]:1219
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225199AbTCMBTB>; Thu, 13 Mar 2003 01:19:01 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2D1ItA08153;
	Thu, 13 Mar 2003 02:18:55 +0100
Date: Thu, 13 Mar 2003 02:18:55 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Ranjan Parthasarathy <ranjanp@efi.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Disabling lwl and lwr instruction generation
Message-ID: <20030313021855.A7940@linux-mips.org>
References: <D9F6B9DABA4CAE4B92850252C52383AB0796823C@ex-eng-corp.efi.com> <20030313014338.C29568@linux-mips.org> <20030313005203.GH13122@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030313005203.GH13122@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Thu, Mar 13, 2003 at 01:52:03AM +0100
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 13, 2003 at 01:52:03AM +0100, Thiemo Seufer wrote:

> > On Wed, Mar 12, 2003 at 10:05:20AM -0800, Ranjan Parthasarathy wrote:
> > 
> > > Is there a way to tell gcc to not generate the lwl, lwr instructions?
> > 
> > Gcc will only ever generate these instructions when __attribute__((unaligned))
> > is used.
> 
> Which might be not that obvious, e.g. __attribute__((packed)) can cause such
> instructions, too.

Typo - I meant __attribute__((packed)).  There is no such thing as
 __attribute__((unaligned)).

  Ralf
