Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 04:35:03 +0100 (CET)
Received: from p508B7E19.dip.t-dialin.net ([80.139.126.25]:59545 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225261AbSLEDfD>; Thu, 5 Dec 2002 04:35:03 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB53Yio30091;
	Thu, 5 Dec 2002 04:34:44 +0100
Date: Thu, 5 Dec 2002 04:34:44 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Carsten Langgaard <carstenl@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021205043444.B29939@linux-mips.org>
References: <3DEDBDFC.D87C1B84@mips.com> <005701c29b74$f1f76870$10eca8c0@grendel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <005701c29b74$f1f76870$10eca8c0@grendel>; from kevink@mips.com on Wed, Dec 04, 2002 at 10:09:54AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 04, 2002 at 10:09:54AM +0100, Kevin D. Kissell wrote:

> For those on the list who don't understand Carsten's sense
> of humour, I think that was missing a smiley!  ;-)
> I mean, sure, we'd like to move more people toward SDE, 
> but "force" is putting it a bit strongly!  And if those directives
> are really being used unconditionally, I worry that the code
> being generated is likewise emitting MIPS32 instructions
> that won't work on the "ghost fleet" of abandoned workstations
> now running Linux on R4K/R5K CPUs.

A fix is now in CVS.  With this fix only compiling a kernel for MIPS32
and MIPS64 CPUs will require a the new tools.

Everybody satisfied?

I was quite amazed how much email in just like 2 days this change was
producing, even people binutils 2.8 started yelling ...

  Ralf
