Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Feb 2007 00:14:47 +0000 (GMT)
Received: from gw.goop.org ([64.81.55.164]:27624 "EHLO mail.goop.org")
	by ftp.linux-mips.org with ESMTP id S20037697AbXBPAOm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Feb 2007 00:14:42 +0000
Received: by lurch.goop.org (Postfix, from userid 525)
	id C482E2C8044; Thu, 15 Feb 2007 16:13:33 -0800 (PST)
Received: from lurch.goop.org (localhost [127.0.0.1])
	by lurch.goop.org (Postfix) with ESMTP id E67512C803F;
	Thu, 15 Feb 2007 16:13:32 -0800 (PST)
Received: from [192.168.3.174] (dsl001-150-252.sfo1.dsl.speakeasy.net [72.1.150.252])
	by lurch.goop.org (Postfix) with ESMTP;
	Thu, 15 Feb 2007 16:13:32 -0800 (PST)
Message-ID: <45D4F735.1020106@goop.org>
Date:	Thu, 15 Feb 2007 16:13:41 -0800
From:	Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070212)
MIME-Version: 1.0
To:	Andrew Morton <akpm@linux-foundation.org>
CC:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Optimize generic get_unaligned / put_unaligned implementations.
References: <20050830104056.GA4710@linux-mips.org>	<20060306.203218.69025300.nemoto@toshiba-tops.co.jp>	<20060306170552.0aab29c5.akpm@osdl.org>	<20070214214226.GA17899@linux-mips.org>	<20070214203903.8d013170.akpm@linux-foundation.org>	<20070215143441.GA18155@linux-mips.org>	<20070215135358.020781dd.akpm@linux-foundation.org>	<20070215221839.GA14103@linux-mips.org> <20070215153823.239fd616.akpm@linux-foundation.org>
In-Reply-To: <20070215153823.239fd616.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP by lurch.goop.org
Return-Path: <jeremy@goop.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeremy@goop.org
Precedence: bulk
X-list: linux-mips

Andrew Morton wrote:
> hm.  So if I have
>
> 	struct bar {
> 		unsigned long b;
> 	} __attribute__((packed));
>
> 	struct foo {
> 		unsigned long u;
> 		struct bar b;
> 	};
>
> then the compiler can see that foo.b.b is well-aligned, regardless of the
> packedness.

In Ralf's code, the structure is anonymous, and is used to declare a
pointer type, which is initialized from a void *.  So I think the
compiler isn't allowed to assume anything about its alignment.

    J
