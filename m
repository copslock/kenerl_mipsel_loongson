Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Aug 2005 19:14:10 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:16915 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226040AbVHQSNy>; Wed, 17 Aug 2005 19:13:54 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7HIIcMg024010;
	Wed, 17 Aug 2005 19:18:38 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7HIIZMn023998;
	Wed, 17 Aug 2005 19:18:35 +0100
Date:	Wed, 17 Aug 2005 19:18:35 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Joshua Wise <Joshua.Wise@sicortex.com>
Cc:	Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Aaron Brooks <aaron.brooks@sicortex.com>
Subject: Re: NAPI poll routine happens in interrupt context?
Message-ID: <20050817181835.GE2667@linux-mips.org>
References: <200508170932.10441.Joshua.Wise@sicortex.com> <20050817094317.3437607e@dxpl.pdx.osdl.net> <200508171321.20094.Joshua.Wise@sicortex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508171321.20094.Joshua.Wise@sicortex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Aug 17, 2005 at 01:21:18PM -0400, Joshua Wise wrote:

> > The bug is that ipv6 is doing an operation to handle MIB statistics and
> > the MIPS architecture math routines seem to need to sleep.

Except nothing in the network stack is using fp - the use of FP inside the
MIPS kernel is not supported in any way.  What happend is probably the
fetching of the opcode of the instruction in the branch delay slot of
the unaligned instruction emulator blew up because it uses a get_user which
again calls might_sleep and that won't exactly work if not called from
process context.

  Ralf
