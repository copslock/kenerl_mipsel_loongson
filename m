Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Feb 2004 18:53:52 +0000 (GMT)
Received: from p508B7363.dip.t-dialin.net ([IPv6:::ffff:80.139.115.99]:44356
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225226AbUBBSxw>; Mon, 2 Feb 2004 18:53:52 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i12IrUex024033;
	Mon, 2 Feb 2004 19:53:30 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i12IrTDl024032;
	Mon, 2 Feb 2004 19:53:29 +0100
Date: Mon, 2 Feb 2004 19:53:29 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Smith, Todd" <Todd.Smith@camc.org>
Cc: "'linux-mips@linux-mips.org '" <linux-mips@linux-mips.org>
Subject: Re: MIPS Kernel size
Message-ID: <20040202185329.GA23667@linux-mips.org>
References: <490E0430C3C72046ACF7F18B7CD76A2A56955D@KES.camcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490E0430C3C72046ACF7F18B7CD76A2A56955D@KES.camcare.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 02, 2004 at 11:12:10AM -0500, Smith, Todd wrote:

> I am still interested in some older PDA usage that has limited resources.  I
> certainly don't want to hold up or stop current kernel dev but is there a
> problem with keeping small kernel and/or userspace limits?

Different tradeoffs.  In general the kernel is optimized for performance,
even at the cost of significant amounts of memory.  As the most infamous
example the kernel is using lots of fairly complex hash and radix trees.

But why would a system that has just a default route need the same kind
of data structures and algorithms it takes to route packets on backbone
router in the default free zone?  Why would you drive a moon rocket to
for shopping?

Linux has generally developped in the direction of larger machines and
higher scalability and sometimes that's causing fairly bad itching.  The
-tiny tree is an attempt to correct this.  It's a development tree but
with the goal of merging changes back into the standard kernel and I
hope much of it will be merged back into 2.6 - 2.8 is too far in the
future to wait for ...

  Ralf
