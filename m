Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 10:54:12 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:18102 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20038876AbXBAKyF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 1 Feb 2007 10:54:05 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1HCZWn-00028p-00; Thu, 01 Feb 2007 11:50:53 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id C40A6C2E08; Thu,  1 Feb 2007 11:36:18 +0100 (CET)
Date:	Thu, 1 Feb 2007 11:36:18 +0100
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org, sam@catalyst.net.nz
Subject: Re: Kernel issues on R4000/R4000 SC and MC
Message-ID: <20070201103618.GA25843@alpha.franken.de>
References: <20070131130926.GA29562@linux-mips.org> <20070201.190717.55145997.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070201.190717.55145997.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.9i
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Feb 01, 2007 at 07:07:17PM +0900, Atsushi Nemoto wrote:
> On Wed, 31 Jan 2007 13:09:26 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Anyway, the issue boiled up again last week and was supposedly fixed for
> > linux-2.6.17-rc7 which I've just merged.   I'd like to ask somebody with
> > one of the affected CPUs to test this.  Below Nick Piggin's test program.
> 
> What is the expected output of the test program?

I can confirm, that it kills R4400SC/MC machines. I saw some
"detected softlock" messages. With just one zero page (CPU without VCE)
everything is fine

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
