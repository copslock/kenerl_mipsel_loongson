Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2003 22:53:49 +0000 (GMT)
Received: from p508B6BAF.dip.t-dialin.net ([IPv6:::ffff:80.139.107.175]:9960
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225346AbTKQWxh>; Mon, 17 Nov 2003 22:53:37 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAHMqvA0016385;
	Mon, 17 Nov 2003 23:52:57 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAHMqmX3016381;
	Mon, 17 Nov 2003 23:52:48 +0100
Date: Mon, 17 Nov 2003 23:52:48 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jeffrey Baitis <baitisj@evolution.com>
Cc: linux-mips@linux-mips.org, Adam_Kiepul@pmc-sierra.com,
	"Mr. Brian R. Gunnison" <brian@evolution.com>,
	Francis Yu <francisyu@synergyrep.com>,
	Johnny Lam <Johnny_Lam@pmc-sierra.com>
Subject: Re: Newbie R5K questions -- -mips2 vs -mips4; is n32 ABI supported by Linux?
Message-ID: <20031117225248.GA15868@linux-mips.org>
References: <1069106666.1829.323.camel@powerpuff.evo1.pas.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069106666.1829.323.camel@powerpuff.evo1.pas.lab>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 17, 2003 at 02:04:26PM -0800, Jeffrey Baitis wrote:

> I'm currently trying to increase performance on our PMC-Sierra RM5231
> system by taking advantage of the MIPS IV ISA. This processor has a
> 32-bit address bus interface with 64-bit GPRs, so I guess that the
> choice of -mabi=n32 is ideal for this processor.

In addition to what Daniel just said ...

N32 requires a 64-bit kernel to run on which is significantly larger
thereby causing more cache misses so a 64-bit kernel is often slower.
On the kernel side a 64-bit kernel is drastically better at handling
large amounts of memory, so once a 32-bit kernel needs highmem the
64-bit kernel will win the race.  Often these effects influence
performance more than what you might gain from exploiting a new ISA.

  Ralf
