Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 12:27:34 +0100 (BST)
Received: from p508B4F3A.dip.t-dialin.net ([IPv6:::ffff:80.139.79.58]:60825
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225277AbTFEL1c>; Thu, 5 Jun 2003 12:27:32 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h55BRRbY009150;
	Thu, 5 Jun 2003 04:27:28 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h55BRMMM009149;
	Thu, 5 Jun 2003 13:27:22 +0200
Date: Thu, 5 Jun 2003 13:27:22 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Ashish anand <ashish.anand@inspiretech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: low ram as source of good parity data..?
Message-ID: <20030605112722.GA9001@linux-mips.org>
References: <200306051027.h55ARnI9031919@smtp.inspirtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306051027.h55ARnI9031919@smtp.inspirtek.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 05, 2003 at 03:16:41PM +0530, Ashish anand wrote:

> I have seen it a common practice to assume low RAM as source 
> of good parity data and use it to fill the caches with good parity 
> data in firmware during elementary hardware initialisation process.
> 
> why it is always safe to assume that low RAM contains good parity data .?
> Is it always true..?
> this question came in picture after I got cacheparity error sometimes.

For the general case it's not safe.  Some systems need memory to be
initialized by writing to it first because before the parity or ECC
bits may have an undefined state.

The safe way to initalize the caches is using the Index_Store_Tag_D etc.
cacheops but of course that requires knowledge about the particular
processor's exactly cache architecture.

  Ralf
