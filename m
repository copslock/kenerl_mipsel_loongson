Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 01:33:59 +0000 (GMT)
Received: from p508B6845.dip.t-dialin.net ([IPv6:::ffff:80.139.104.69]:20163
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225199AbTCMBd6>; Thu, 13 Mar 2003 01:33:58 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h2D1XjF08451;
	Thu, 13 Mar 2003 02:33:45 +0100
Date: Thu, 13 Mar 2003 02:33:45 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Richard Hodges <rh@matriplex.com>
Cc: Ranjan Parthasarathy <ranjanp@efi.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Disabling lwl and lwr instruction generation
Message-ID: <20030313023344.A7013@linux-mips.org>
References: <D9F6B9DABA4CAE4B92850252C52383AB0796823C@ex-eng-corp.efi.com> <20030313014338.C29568@linux-mips.org> <Pine.BSF.4.50.0303121647400.95890-100000@mail.matriplex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.BSF.4.50.0303121647400.95890-100000@mail.matriplex.com>; from rh@matriplex.com on Wed, Mar 12, 2003 at 04:50:53PM -0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 12, 2003 at 04:50:53PM -0800, Richard Hodges wrote:

> I got lwl and lwr from a memcpy() with two void pointers...
> 
> I quickly changed those to the (aligned) structure pointers instead, and
> then memcpy() changed to ordinary word loads and stores.
> 
> So, is somebody starting a toolchain for that new Chinese CPU? :-)

Wouldn't be the first processor without lwl/lwr instructions.  There have
been a few that didn't implement it for silly bean^Wgate counting issues
others have done it for patent and licensing reasons.

(Afair MIPS's patent is about to expire and IBM's prior art patent in the
same area is even way older but that legalese ...)

  Ralf
