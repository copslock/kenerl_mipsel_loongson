Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2005 11:15:14 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:2078 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133470AbVJaLO5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 31 Oct 2005 11:14:57 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9VBFK9i013529;
	Mon, 31 Oct 2005 11:15:20 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9VBFJvT013528;
	Mon, 31 Oct 2005 11:15:19 GMT
Date:	Mon, 31 Oct 2005 11:15:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Franck <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] Add 4KSx support (try 2)
Message-ID: <20051031111519.GA13281@linux-mips.org>
References: <cda58cb80510310034k60b273dfm@mail.gmail.com> <4365DF22.8060004@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4365DF22.8060004@mips.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 31, 2005 at 10:08:50AM +0100, Kevin D. Kissell wrote:

> There are places, for example arch/mips/mm/cache.c, but
> also some of the other makefiles, where you're using your
> new config flags to drive things where the standard
> CONFIG_CPU_MIPS32 (which I guess has now fragmented into
> CONFIG_CPU_MIPS32_R1 and CONFIG_CPU_MIPS32_R2, which would
> apply to the Sc and Sd respectively) would do the right thing
> while creating fewer source file mods.

CONFIG_CPU_MIPS32 is a short cut; it's set if any of CONFIG_CPU_MIPS32_R1
or CONFIG_CPU_MIPS32_R2 is set.  Equivalent for MIPS64.  Another short
set of short cuts is CONFIG_CPU_MIPSR1 which is set if any of
CONFIG_CPU_MIPS32_R1 or CONFIG_CPU_MIPS64_R1 is set and again the
equivalent thing for CONFIG_CPU_MIPSR2 exists.

> Have you thought about what the ACX state would mean for
> kernel debuggers in general and kgdb in particular?

The real issue I have with the patch is that ACX is extending the state
that would need to be saved and restored in signal handlers and I have to
solve the question where to keep that information without breaking
compatibility - that's pretty much the same exercise which we had just
recently with adding DSP support.  I need to look into that Franck; until
this patch is on hold.  It however looks correct otherwise.

  Ralf
