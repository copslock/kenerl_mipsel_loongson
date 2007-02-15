Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2007 23:06:36 +0000 (GMT)
Received: from gw.goop.org ([64.81.55.164]:56526 "EHLO mail.goop.org")
	by ftp.linux-mips.org with ESMTP id S20037601AbXBOXGb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Feb 2007 23:06:31 +0000
Received: by lurch.goop.org (Postfix, from userid 525)
	id E55C72C8044; Thu, 15 Feb 2007 15:05:22 -0800 (PST)
Received: from lurch.goop.org (localhost [127.0.0.1])
	by lurch.goop.org (Postfix) with ESMTP id 21B2B2C803F;
	Thu, 15 Feb 2007 15:05:22 -0800 (PST)
Received: from [192.168.3.174] (dsl001-150-252.sfo1.dsl.speakeasy.net [72.1.150.252])
	by lurch.goop.org (Postfix) with ESMTP;
	Thu, 15 Feb 2007 15:05:22 -0800 (PST)
Message-ID: <45D4E740.9020504@goop.org>
Date:	Thu, 15 Feb 2007 15:05:36 -0800
From:	Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Andrew Morton <akpm@linux-foundation.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Optimize generic get_unaligned / put_unaligned implementations.
References: <20050830104056.GA4710@linux-mips.org> <20060306.203218.69025300.nemoto@toshiba-tops.co.jp> <20060306170552.0aab29c5.akpm@osdl.org> <20070214214226.GA17899@linux-mips.org> <20070214203903.8d013170.akpm@linux-foundation.org> <20070215143441.GA18155@linux-mips.org> <20070215135358.020781dd.akpm@linux-foundation.org> <20070215221839.GA14103@linux-mips.org>
In-Reply-To: <20070215221839.GA14103@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP by lurch.goop.org
Return-Path: <jeremy@goop.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeremy@goop.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> Gcc info page says:
>
> [...]
> `packed'
>      The `packed' attribute specifies that a variable or structure field
>      should have the smallest possible alignment--one byte for a
>      variable, and one bit for a field, unless you specify a larger
>      value with the `aligned' attribute.
> [...]
>
> Qed?

So that the compiler has to assume that if its accessing this __packed
structure, it may be embedded unaligned within something else? And
because the pointer is cast through (void *) it isn't allowed to use
alias analysis to notice that the pointer wasn't originally (apparently)
unaligned.

Seems sound to me.

    J
