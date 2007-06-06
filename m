Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 15:43:33 +0100 (BST)
Received: from iolanthe.rowland.org ([192.131.102.54]:46995 "HELO
	iolanthe.rowland.org") by ftp.linux-mips.org with SMTP
	id S20027075AbXFFOnb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 15:43:31 +0100
Received: (qmail 3537 invoked by uid 2102); 6 Jun 2007 10:42:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jun 2007 10:42:23 -0400
Date:	Wed, 6 Jun 2007 10:42:23 -0400 (EDT)
From:	Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
cc:	gregkh@suse.de, <linux-mips@linux-mips.org>,
	<akpm@linux-foundation.org>, <dbrownell@users.sourceforge.net>,
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] [PATCH 11/12] drivers: PMC MSP71xx USB driver
In-Reply-To: <200706060048.l560moU4007288@pasqua.pmc-sierra.bc.ca>
Message-ID: <Pine.LNX.4.44L0.0706061039280.3533-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips

On Tue, 5 Jun 2007, Marc St-Jean wrote:

> @@ -2749,12 +2749,33 @@ static void hub_events(void)
>  			}
>  			
>  			if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
> -				dev_err (hub_dev,
> -					"over-current change on port %d\n",
> -					i);
> +				/* clear OCC bit */
>  				clear_port_feature(hdev, i,
>  					USB_PORT_FEAT_C_OVER_CURRENT);
> +
> +				/*
> +				 * This step is required to toggle the
> +				 * PP bit to 0 and 1 (by hub_power_on)
> +				 * in order the CSC bit to be transitioned
> +				 * properly for device hotplug.
> +				 */
> +				/* clear PP bit */
> +				clear_port_feature(hdev, i,
> +						USB_PORT_FEAT_POWER);
> +
> +				/* resume power */
>  				hub_power_on(hub);
> +
> +				udelay(100);
> +
> +				/* read OCA bit */
> +				if (portstatus &
> +				    (1 << USB_PORT_FEAT_OVER_CURRENT)) {
> +					/* declare overcurrent */
> +					dev_err(hub_dev,
> +						"over-current change "
> +						"on port %d\n", i);
> +				}
>  			}

Quite apart from all the issues David mentioned, you shouldn't change 
the way errors are reported.  The dev_err() statement should always be 
executed when there is an overcurrent change; it shouldn't depend on 
whether the overcurrent feature is set at the moment.

Remember, the message reports an overcurrent _change_, not an 
overcurrent _state_.

Alan Stern
