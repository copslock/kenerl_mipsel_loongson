Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 May 2004 18:05:02 +0100 (BST)
Received: from p508B60BE.dip.t-dialin.net ([IPv6:::ffff:80.139.96.190]:27454
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225319AbUEPRFB>; Sun, 16 May 2004 18:05:01 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i4GH4oxT004901;
	Sun, 16 May 2004 19:04:51 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i4GH4jpv004900;
	Sun, 16 May 2004 19:04:45 +0200
Date: Sun, 16 May 2004 19:04:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Johannes Stezenbach <js@convergence.de>,
	Kieran Fulke <kieran@pawsoff.org>, linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
Message-ID: <20040516170445.GA4793@linux-mips.org>
References: <20040513183059.GA25743@getyour.pawsoff.org> <40A478B0.3070005@bitbox.co.uk> <20040516113622.GA14049@getyour.pawsoff.org> <20040516152113.GA9390@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040516152113.GA9390@convergence.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, May 16, 2004 at 05:21:13PM +0200, Johannes Stezenbach wrote:

> In essence, I believe something other than the saa7146 must be asserting
> irq 23.  Or is it possible that a bug in the PCI init stuff in
> saa7146_core.c can
> cause this? Any hints how we could debug this would be welcome.

arch/mips/cobalt/irq.c:cobalt_irq() looks pretty suspect.  It connects
CAUSEF_IP7 and interrupt 23 - but the CPU's builtin count / compare
interrupt already uses this bit.

Sharing the timer interrupt with something else isn't impossible but seems
a less than bright thing to do.  Somebody with production hw to test
should compare this interrupt dispatch function with old working code
from 2.2 or 2.4 ...

  Ralf
