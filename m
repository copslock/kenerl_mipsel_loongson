Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Sep 2005 21:53:06 +0100 (BST)
Received: from a1.ldhosting.net ([72.29.96.10]:34234 "EHLO astro.ldhosting.net")
	by ftp.linux-mips.org with ESMTP id S8133594AbVI1Uwu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Sep 2005 21:52:50 +0100
Received: from [172.25.13.122] (adsl-69-149-118-47.dsl.austtx.swbell.net [69.149.118.47])
	by astro.ldhosting.net (Postfix) with ESMTP id 9D3411000C5
	for <linux-mips@linux-mips.org>; Wed, 28 Sep 2005 15:52:43 -0500 (CDT)
Message-ID: <433B0299.8080507@smoothsmoothie.com>
Date:	Wed, 28 Sep 2005 15:52:41 -0500
From:	Jay Monkman <jtm@smoothsmoothie.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: USB on AU1550
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <jtm@smoothsmoothie.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jtm@smoothsmoothie.com
Precedence: bulk
X-list: linux-mips

I'm trying to get USB working on my AU1550 board, and I'm getting an error I
don't understand. I've searched the web and the mailing list archives, but
haven't found anything relevant.

I'm using 2.6.12, in big-endian mode.

After the kernel comes up, I plug in a USB flash drive and get this on the console:
    au1xxx-ohci au1xxx-ohci.0: GetStatus roothub.portstatus [1] = 0x00010101 CSC
PPS CCS
    hub 1-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
    hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x101
    au1xxx-ohci au1xxx-ohci.0: GetStatus roothub.portstatus [1] = 0x00100103
PRSC PPS PES CCS
    usb 1-2: new full speed USB device using au1xxx-ohci and address 2
    au1xxx-ohci au1xxx-ohci.0: Unlink after no-IRQ?  Controller is probably
using the wrong IRQ.


This is the comment in the code before that printk():
	/* IRQ setup can easily be broken so that USB controllers
	 * never get completion IRQs ... maybe even the ones we need to
	 * finish unlinking the initial failed usb_set_address()
	 * or device descriptor fetch.
	 */
	if (!hcd->saw_irq && hcd->self.root_hub != urb->dev) {
		dev_warn (hcd->self.controller, "Unlink after no-IRQ?  "
			"Controller is probably using the wrong IRQ."
			"\n");
		hcd->saw_irq = 1;
	}

When I get here in the code, hcd->saw_irq is 0, and it looks like this function
(hcd_unlink_urb()) is getting called from run_timer_softirq(), so I guess I'm
not getting the interrupt. However, immediately after returning, usb_hcd_irq()
does get called. As far as I can tell, the interrupt gets serviced as soon as
hcd_unlink_urb returns.

It looks like the timer function causing this is timeout_kill(), initialized in
usb_start_wait_urb() which has this comment:
	// Starts urb and waits for completion or timeout
	// note that this call is NOT interruptible, while
	// many device driver i/o requests should be interruptible



Can anyone point me in the right direction to get this working?

Thanks.
