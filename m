Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Dec 2010 01:31:01 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:58369 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491102Ab0LWAa5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Dec 2010 01:30:57 +0100
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by mx2.suse.de (Postfix) with ESMTP id 133E888B6C;
        Thu, 23 Dec 2010 01:30:56 +0100 (CET)
Date:   Wed, 22 Dec 2010 16:30:48 -0800
From:   Greg KH <gregkh@suse.de>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        David Brownell <dbrownell@users.sourceforge.net>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 11/16] USB: ehci: add workaround for Synopsys HC bug
Message-ID: <20101223003048.GB9811@suse.de>
References: <1293049861-28913-1-git-send-email-juhosg@openwrt.org>
 <1293049861-28913-12-git-send-email-juhosg@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1293049861-28913-12-git-send-email-juhosg@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <gregkh@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips

On Wed, Dec 22, 2010 at 09:30:56PM +0100, Gabor Juhos wrote:
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
> 
> Workarounds:
> 
> 1) If no queue head is active (no Status field's Active bit is set)
> after removing the queue heads, the software can write one of the valid
> queue head addresses to the ASYNCLISTADDR register and deallocate the
> removed queue head's memory after 2 microframes.
> 
> If one or more of the queue heads is active (the Active bit is set in
> the Status field) after removing the queue heads, the software can delay
> memory deallocation after time X, where X is the time required for the
> Host Controller to go through all the queue heads once. X varies with
> the number of queue heads and the time required to process periodic
> transactions: if more periodic transactions must be performed, the Host
> Controller has less time to process asynchronous transaction processing.
> 
> 2) Do not use the Doorbell mechanism to remove the queue heads. Disable
> the Asynchronous Schedule Enable bit instead.
> 
> The bug has been discussed on the linux-usb-devel mailing-list
> four years ago, the original thread can be found here:
> http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg45345.html
> 
> This patch implements the first workaround as suggested by David Brownell.
> The built-in USB host controller of the Atheros AR7130/AR7141/AR7161 SoCs
> requires this to work properly.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Cc: David Brownell <dbrownell@users.sourceforge.net>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: linux-usb@vger.kernel.org
> ---
> 
> Changes since RFC: ---
> 
> Changes since v1:
>     - rebased against 2.6.37-rc7
> 
>  drivers/usb/host/ehci-q.c |    3 +++
>  drivers/usb/host/ehci.h   |    1 +
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-q.c b/drivers/usb/host/ehci-q.c
> index 233c288..343b8de 100644
> --- a/drivers/usb/host/ehci-q.c
> +++ b/drivers/usb/host/ehci-q.c
> @@ -1193,6 +1193,9 @@ static void end_unlink_async (struct ehci_hcd *ehci)
>  		ehci->reclaim = NULL;
>  		start_unlink_async (ehci, next);
>  	}
> +
> +	if (ehci->has_synopsys_hc_bug)
> +		writel((u32)ehci->async->qh_dma, &ehci->regs->async_next);
>  }
>  
>  /* makes sure the async qh will become idle */
> diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
> index ba8eab3..6da85b2 100644
> --- a/drivers/usb/host/ehci.h
> +++ b/drivers/usb/host/ehci.h
> @@ -133,6 +133,7 @@ struct ehci_hcd {			/* one per controller */
>  	unsigned		broken_periodic:1;
>  	unsigned		fs_i_thresh:1;	/* Intel iso scheduling */
>  	unsigned		use_dummy_qh:1;	/* AMD Frame List table quirk*/
> +	unsigned		has_synopsys_hc_bug:1; /* Synopsys HC */

That's fine, but who sets this value to 1?  I don't see any code that
does that, so why add this at all?  :)

thanks,

greg k-h
