Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 15:15:03 +0000 (GMT)
Received: from p508B7E65.dip.t-dialin.net ([IPv6:::ffff:80.139.126.101]:39516
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225366AbUA1POz>; Wed, 28 Jan 2004 15:14:55 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0SFEVex014460;
	Wed, 28 Jan 2004 16:14:31 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0SFETX1014459;
	Wed, 28 Jan 2004 16:14:29 +0100
Date: Wed, 28 Jan 2004 16:14:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Nathan Field <ndf@ghs.com>
Cc: linux-mips@linux-mips.org
Subject: Re: linux_2_4 and Malta
Message-ID: <20040128151429.GA17242@linux-mips.org>
References: <Pine.LNX.4.44.0401271938380.31973-200000@zcar.ghs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401271938380.31973-200000@zcar.ghs.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 27, 2004 at 07:45:23PM -0800, Nathan Field wrote:

> I'm having problems getting the linux_2_4 branch of the kernel to output 
> serial on my Malta board. The HEAD branch (2.6) seems to work fine, but 
> I'd prefer to avoid that if possible.

After lagging behind kernel.org for such a long time 2.6 has begun to
stabilize in amzingly short time.  It hasn't crashed on me for a few days
on supported configurations.

> Is anyone else having this problem? 
> I've attached my .config just in case I'm doing something stupid. I got 
> the 2.4.17 kernel to work fine.
> 
> The prom_print stuff outputs to the serial port fine, but printk's never 
> get out. Looking at the kernel under a debugger it also seems that the 
> kernel is crashing randomly and ending up in an infinite loop branching to 
> self.

What processor are you using on the Malta?

  Ralf
