Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 14:04:52 +0000 (GMT)
Received: from p508B7260.dip.t-dialin.net ([IPv6:::ffff:80.139.114.96]:14706
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225539AbUA2OEv>; Thu, 29 Jan 2004 14:04:51 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0TE4oex005753;
	Thu, 29 Jan 2004 15:04:50 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0TE4oah005752;
	Thu, 29 Jan 2004 15:04:50 +0100
Date: Thu, 29 Jan 2004 15:04:50 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] 32bit module support
Message-ID: <20040129140450.GA5589@linux-mips.org>
References: <20040123182436.C27362@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123182436.C27362@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 23, 2004 at 06:24:36PM -0800, Jun Sun wrote:

> I have not done extensive tests yet, but this patch appears to 
> be working.  I'd appreciate people giving it a try and let me 
> know how it goes.
> 
> There is one worrisome "FIXME" in that file, which is not clear
> to me.  Ralf?

Your code removed handling for a GNU extension.  Anyway, I already had a
fairly similar patch and I commited it last night.  I don't normally
announce patches I commit to the list but thought this one is noteworthy
as it solves the last big problem with 2.6.

What still needs to be done is adding module supprt for 64-bit also - but
that's not functional in 2.4 either and I have no plans to implement
64-bit modules in 2.4.

  Ralf
