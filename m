Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 23:40:03 +0000 (GMT)
Received: from p508B6DCE.dip.t-dialin.net ([IPv6:::ffff:80.139.109.206]:52633
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225308AbSLQXkC>; Tue, 17 Dec 2002 23:40:02 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBHNdvM01492;
	Wed, 18 Dec 2002 00:39:57 +0100
Date: Wed, 18 Dec 2002 00:39:57 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Marcus.Jones@Zarlink.Com
Cc: linux-mips@linux-mips.org
Subject: Re: Pre-emptive kernel for MIPs 32
Message-ID: <20021218003957.A1301@linux-mips.org>
References: <OF5C4D3FBD.1018D485-ON80256C92.005EC5E1@zarlink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF5C4D3FBD.1018D485-ON80256C92.005EC5E1@zarlink.com>; from Marcus.Jones@Zarlink.Com on Tue, Dec 17, 2002 at 05:22:36PM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 17, 2002 at 05:22:36PM +0000, Marcus.Jones@Zarlink.Com wrote:

> Is anyone using the pre-emptive kernel option on the Linux MIPs kernel.
> Could you recommend a CVS tag to use for a reasonably stable version?

There is no stable that is 2.4 kernel with preemption support in CVS,
so you need to get the preemption patch from somewhere else.

  Ralf
