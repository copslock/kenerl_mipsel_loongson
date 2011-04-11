Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Apr 2011 20:54:11 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:58017 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1491143Ab1DKSyE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Apr 2011 20:54:04 +0200
Received: (qmail 3979 invoked by uid 2102); 11 Apr 2011 14:53:53 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Apr 2011 14:53:53 -0400
Date:   Mon, 11 Apr 2011 14:53:53 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Gabor Juhos <juhosg@openwrt.org>
cc:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] USB: ehci: add workaround for Synopsys HC bug
In-Reply-To: <1302465900-16814-2-git-send-email-juhosg@openwrt.org>
Message-ID: <Pine.LNX.4.44L0.1104111452040.1975-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+4dbee946@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips

On Sun, 10 Apr 2011, Gabor Juhos wrote:

> A Synopsys USB core used in various SoCs has a bug which might cause
> that the host controller not issuing ping.
> 
> When software uses the Doorbell mechanism to remove queue heads, the
> host controller still has references to the removed queue head even
> after indicating an Interrupt on Async Advance. This happens if the last
> executed queue head's Next Link queue head is removed.
> 
> Consequences of the defect:
> The Host controller fetches the removed queue head, using memory that
> would otherwise be deallocated.This results in incorrect transactions on
> both the USB and system memory. This may result in undefined behavior.

> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -1183,6 +1183,9 @@ static void end_unlink_async (struct ehci_hcd *ehci)
>  		ehci->reclaim = NULL;
>  		start_unlink_async (ehci, next);
>  	}
> +
> +	if (ehci->has_synopsys_hc_bug)
> +		writel((u32)ehci->async->qh_dma, &ehci->regs->async_next);
>  }

This should be ehci_writel(ehci, ...).

Alan Stern
