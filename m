Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2004 14:59:12 +0000 (GMT)
Received: from p508B7CF6.dip.t-dialin.net ([IPv6:::ffff:80.139.124.246]:27410
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224947AbUCJO7M>; Wed, 10 Mar 2004 14:59:12 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2AEx7ex009162;
	Wed, 10 Mar 2004 15:59:07 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2AEx6rj009161;
	Wed, 10 Mar 2004 15:59:06 +0100
Date: Wed, 10 Mar 2004 15:59:06 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips@linux-mips.org,
	netdev@oss.sgi.com
Subject: Re: "eth%d" - net dev name in 2.6?
Message-ID: <20040310145906.GA9104@linux-mips.org>
References: <20040310023308.GU31326@mvista.com> <20040310025346.GA5661@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310025346.GA5661@deprecation.cyrius.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4523
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 10, 2004 at 02:53:46AM +0000, Martin Michlmayr wrote:

> I have no idea, but I've seen a similar bug report at
> http://bugs.debian.org/234817

This affects drivers/net/ne.c, so I'm adding netdev to the cc list.

Same problem, dereferencing net_device->name before register_netdev().
That's caused by a bit toooo quick and sloopy conversion from
init_etherdev to alloc_etherdev & register_netdev.

  Ralf
