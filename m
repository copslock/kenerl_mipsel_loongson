Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 07:39:45 +0100 (CET)
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:46215 "EHLO
        rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491770Ab0BAGjj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Feb 2010 07:39:39 +0100
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
        id 13CF34004C; Mon,  1 Feb 2010 07:39:35 +0100 (CET)
Date:   Mon, 1 Feb 2010 07:39:35 +0100
From:   Andreas Mohr <andi@lisas.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Maxime Bizon <mbizon@freebox.fr>,
        David Brownell <dbrownell@users.sourceforge.net>,
        linux-usb@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] USB: add Broadcom 63xx integrated EHCI controller
        support.
Message-ID: <20100201063934.GA13692@rhlx01.hs-esslingen.de>
References: <1264874071-28851-3-git-send-email-mbizon@freebox.fr> <Pine.LNX.4.44L0.1001302110520.14199-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1001302110520.14199-100000@netrider.rowland.org>
X-Priority: none
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <andi@rhlx01.hs-esslingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andi@lisas.de
Precedence: bulk
X-list: linux-mips

On Sat, Jan 30, 2010 at 09:11:45PM -0500, Alan Stern wrote:
> On Sat, 30 Jan 2010, Maxime Bizon wrote:
> > +static const struct hc_driver ehci_bcm63xx_hc_driver = {
> > +	.description =		hcd_name,
> > +	.product_desc =		"BCM63XX integrated EHCI controller",
> > +	.hcd_priv_size =	sizeof(struct ehci_hcd),
> > +
> > +	.irq =			ehci_irq,
> > +	.flags =		HCD_MEMORY | HCD_USB2,
> > +
> > +	.reset =		ehci_bcm63xx_setup,
> > +	.start =		ehci_run,
> > +	.stop =			ehci_stop,
> > +	.shutdown =		ehci_shutdown,
> > +
> > +	.urb_enqueue =		ehci_urb_enqueue,
> > +	.urb_dequeue =		ehci_urb_dequeue,
> > +	.endpoint_disable =	ehci_endpoint_disable,
> > +
> > +	.get_frame_number =	ehci_get_frame,
> > +
> > +	.hub_status_data =	ehci_hub_status_data,
> > +	.hub_control =		ehci_hub_control,
> > +	.bus_suspend =		ehci_bus_suspend,
> > +	.bus_resume =		ehci_bus_resume,
> > +	.relinquish_port =	ehci_relinquish_port,
> > +	.port_handed_over =	ehci_port_handed_over,
> > +};
> 
> You'll run into trouble if you don't include the standard 
> endpoint_reset method pointer.
> 
> Alan Stern

And one will run into even more trouble (as did I! hung ports galore...)
if one doesn't include the .clear_tt_buffer_complete callback either,
due to using an outdated non-mainline-synchronized host driver
(that was Broadcom as well, ehci-ssb.c).
The best thing to do is a full review of all _diffs_ in _all_
usb host kernel files in even moderately recent times (say 2.6.23 - 2.6.33)
and add every missing required item to these bcm63xx host files, too.

Is your code coming from OpenWrt too by chance? :-P


Kudos to Alan for catching this problem during review
(probably he was still alerted by my miserable luck)

HTH,

Andreas Mohr

P.S.: yup I should get ehci-ssb.c cleaned up and submitted soon.
