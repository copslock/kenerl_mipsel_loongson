Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:35:17 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:56998 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S23754632AbYKRW2W (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2008 22:28:22 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mAIMSLsn023449;
	Tue, 18 Nov 2008 22:28:21 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mAIMSKIp023447;
	Tue, 18 Nov 2008 22:28:20 GMT
Date:	Tue, 18 Nov 2008 22:28:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <KKylheku@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Interrupt routing issue on BCM1480.
Message-ID: <20081118222820.GA14689@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C50144C3F0@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C50144C3F0@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 18, 2008 at 02:00:08PM -0800, Kaz Kylheku wrote:

> Ralf's fixes in arch/mips/pci/pci-bcm1480.c break on our board. Multiple
> devices somehow report the same pin number (or perhaps some invalid pin
> number that is mapped to 1).  The mapping function then assigns IRQ 8 to
> multiple devices.

That's fine.  A simple PCI device that uses an interrupt is supposed to
use INTA that is report a 1 in the interrupt pin register.  After going
through any PCI-to-PCI bridges (if they exist), INTA..INTD eventually
will be wired in a system specific way to the host.  For the BCM91480
that wiring seems to be to simply wire (or "or") all INTA pins together
and connect that signal to the SOC, same for the remaining INTB..INTD.
In practice this means it is expected to see most PCI devices to use
K_BCM1480_INT_PCI_INTA which is 8.  I suppose your system may wire up
things in a different way and CFE knows about that but not pcibios_map_irq().

> The old ``return dev->irq'' in pcibios_map_irq worked fine.
> 
> What was the issue: is it that CFE sets up these IRQ numbers, such that
> they might not correspond to pins?

Linux interrupt number is not necessarily the same as that of any
firmware, so relying on firmware is generally wrong or at least
something only to be done if you know what you do ...

  Ralf
