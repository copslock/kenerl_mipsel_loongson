Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2004 17:52:24 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:22008 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225234AbUBMRwY>;
	Fri, 13 Feb 2004 17:52:24 +0000
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i1DHpftS016862;
	Fri, 13 Feb 2004 09:51:41 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i1DHpfwQ016860;
	Fri, 13 Feb 2004 09:51:41 -0800
Date: Fri, 13 Feb 2004 09:51:41 -0800
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
Message-ID: <20040213175141.GB16718@mvista.com>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl> <20040213145316.GA23810@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213145316.GA23810@linux-mips.org>
User-Agent: Mutt/1.4i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, Feb 13, 2004 at 03:53:16PM +0100, Ralf Baechle wrote:
> On Fri, Feb 13, 2004 at 03:20:27PM +0100, Maciej W. Rozycki wrote:
> 
> > 2. It changes inline-assembly function prologues to be embedded within the
> > functions, which makes them a bit safer as they can now explicitly refer
> > to the "regs" struct and assures the code won't be removed or reordered.
> 
> It is possible that gcc changes one of the registers before save_static
> and I can't imagine there's a reliable way to fix this in the inline
> version.
> 

Yes.  I still remember this bug vividly.  It took me quite a few days
to track it down.

I really wish there is a more reliable and systematic way to do this, 
even at some expense of a few more instructions ...

Jun
