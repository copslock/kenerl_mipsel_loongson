Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Oct 2002 16:27:12 +0200 (CEST)
Received: from p508B4F39.dip.t-dialin.net ([80.139.79.57]:60638 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123926AbSJWO1L>; Wed, 23 Oct 2002 16:27:11 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g9NEQqp30477;
	Wed, 23 Oct 2002 16:26:52 +0200
Date: Wed, 23 Oct 2002 16:26:52 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Bradley Bozarth <bbozarth@cisco.com>
Cc: linux-mips@linux-mips.org
Subject: Re: 64 bit jiffies
Message-ID: <20021023162652.A27187@linux-mips.org>
References: <Pine.LNX.4.44.0210222038460.31553-100000@bbozarth-lnx.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210222038460.31553-100000@bbozarth-lnx.cisco.com>; from bbozarth@cisco.com on Tue, Oct 22, 2002 at 08:42:35PM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 22, 2002 at 08:42:35PM -0700, Bradley Bozarth wrote:

> There was a thread on lkml in May which resulted in the 32 bit jiffies 
> value using the bottom of the jiffies_64 - this equivalence being done in 
> linker scripts.  It was stated, however, that MIPS wasn't handled because 
> it had a funky sed generated linker script for multiple endiannesses.  
> So is mips currently broken in 2.5?  Has anyone looked at this - I would 
> be willing to figure out a fix but thought I'd see if someone has ideas or 
> has already dealt with it...

This is long fixed in the 2.5 branch of CVS.

  Ralf
