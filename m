Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2005 14:31:46 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:32747 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133437AbVI2Nba (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Sep 2005 14:31:30 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1EKyVR-0001s8-D1; Thu, 29 Sep 2005 09:31:25 -0400
Date:	Thu, 29 Sep 2005 09:31:25 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Nigel Stephens <nigel@mips.com>
Cc:	Matej Kupljen <matej.kupljen@ultra.si>,
	Ulrich Eckhardt <Eckhardt@satorlaser.com>,
	linux-mips@linux-mips.org
Subject: Re: Floating point performance
Message-ID: <20050929133124.GA7135@nevyn.them.org>
References: <6EC3F44BE5E6B742BE3EBC3465525944096814@emea-exchange3.emea.dps.local> <1127992600.10179.19.camel@localhost.localdomain> <433BD1AA.9060404@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433BD1AA.9060404@mips.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 29, 2005 at 12:36:10PM +0100, Nigel Stephens wrote:
> 
> 
> Matej Kupljen wrote:
> 
> >I thought that SF *should* be relatively fast, because I have
> >experience with it on ARM, where Nicolas Pitre wrote amazing 
> >SF support for the glibc.
> >How can we speed-up SF on MIPS? 
> >Does anybody have some suggestions?
> > 
> >
> 
> Maybe someone should volunteer to port Nicolas's "amazing SF support" 
> from ARM to MIPS. Hint hint.

Unless you've got a spare ASE lying around with conditional execution
and a barrel shifter, I don't think this is in the cards.

Which isn't to say that someone couldn't write a good MIPS-specific
implementation, if they were a sufficiently good FP guru.  But
my feeling is that ARM is more prone than MIPS to clever tricks that
are hard for a compiler to generate.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
