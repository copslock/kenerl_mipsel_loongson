Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Aug 2003 02:41:37 +0100 (BST)
Received: from p508B6AA9.dip.t-dialin.net ([IPv6:::ffff:80.139.106.169]:48317
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225213AbTHDBlf>; Mon, 4 Aug 2003 02:41:35 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h741fXpR004443;
	Mon, 4 Aug 2003 03:41:33 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h741fWB5004442;
	Mon, 4 Aug 2003 03:41:32 +0200
Date: Mon, 4 Aug 2003 03:41:32 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Pete Popov <ppopov@mvista.com>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: udelay
Message-ID: <20030804014132.GA4419@linux-mips.org>
References: <1059788948.9224.62.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059788948.9224.62.camel@zeus.mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 01, 2003 at 06:49:08PM -0700, Pete Popov wrote:

> Looks like the latest udelay in 2.4 is borked. Anyway else notice that
> problem?  I did a 10 sec test: mdelay works, udelay is broken, at least
> for the CPU and toolchain I'm using.

That just doesn't make sense.  Mdelay is based on udelay so if udelay
is broken mdelay should be broken, too.

  Ralf
