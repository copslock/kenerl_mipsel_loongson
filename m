Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Nov 2008 15:04:31 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:44214 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23055730AbYKCPE3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Nov 2008 15:04:29 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id 34F32386DBBE;
	Mon,  3 Nov 2008 16:04:23 +0100 (CET)
Date:	Mon, 3 Nov 2008 16:05:42 +0100
From:	Phil Sutter <n0-1@freewrt.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, sshtylyov@ru.mvista.com,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: rb532: fix bit swapping in rb532_set_bit()
Message-ID: <20081103150542.GB13461@nuty>
Mail-Followup-To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, linux-mips@linux-mips.org
References: <20081103142942.GA13461@nuty> <1225722625-19750-1-git-send-email-n0-1@freewrt.org> <20081103.234856.61509468.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081103.234856.61509468.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.11
Return-Path: <n0-1@freewrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, Nov 03, 2008 at 11:48:56PM +0900, Atsushi Nemoto wrote:
> Well, the linux gpio framework uses 0 for low, _nonzero_ for high.
> You should not assume the bitval is 0 or 1.

Good point. I was thinking about this potential problem, too. This is
why the mentioned function contains the following line (sadly too far
off to occur in the patch):

| bitval = !!bitval;              /* map parameter to {0,1} */

I put that separately to not make the below lines even more unreadable.

> 	val &= ~(!bitval << offset);   /* unset bit if bitval == 0 */
> 	val |= (!!bitval << offset);   /* set bit if bitval != 0 */

But as a boolean inverse has to be used anyway, your solution looks more
elegant than mine.

Greetings, Phil
