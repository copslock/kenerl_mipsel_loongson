Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2011 17:08:29 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:36330 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1491765Ab1DMPIZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Apr 2011 17:08:25 +0200
Received: (qmail 2729 invoked by uid 2102); 13 Apr 2011 11:08:21 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Apr 2011 11:08:21 -0400
Date:   Wed, 13 Apr 2011 11:08:21 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Gabor Juhos <juhosg@openwrt.org>
cc:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] USB: ehci: add workaround for Synopsys HC bug
In-Reply-To: <1302684864-12484-2-git-send-email-juhosg@openwrt.org>
Message-ID: <Pine.LNX.4.44L0.1104131108040.2005-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+4dbee946@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
X-list: linux-mips

On Wed, 13 Apr 2011, Gabor Juhos wrote:

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
> 
> The built-in USB host controller of the Atheros AR7130/AR7141/AR7161 SoCs
> requires this to work properly.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb@vger.kernel.org

Acked-by: Alan Stern <stern@rowland.harvard.edu>
