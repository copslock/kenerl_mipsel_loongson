Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2015 16:49:48 +0100 (CET)
Received: from iolanthe.rowland.org ([192.131.102.54]:42439 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S27026290AbbAFPtmtnpP0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Jan 2015 16:49:42 +0100
Received: (qmail 2482 invoked by uid 2102); 6 Jan 2015 10:49:40 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Jan 2015 10:49:40 -0500
Date:   Tue, 6 Jan 2015 10:49:40 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
cc:     Greg KH <greg@kroah.com>, David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/2 resend v2] USB: host: Introduce flag to enable use
 of 64-bit dma_mask for ehci-platform
In-Reply-To: <20150106125015.GC4194@alberich>
Message-ID: <Pine.LNX.4.44L0.1501061048230.1602-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+54ad1fae@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stern@rowland.harvard.edu
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Tue, 6 Jan 2015, Andreas Herrmann wrote:

> ehci-octeon driver used a 64-bit dma_mask. With removal of ehci-octeon
> and usage of ehci-platform ehci dma_mask is now limited to 32 bits
> (coerced in ehci_platform_probe).
> 
> Provide a flag in ehci platform data to allow use of 64 bits for
> dma_mask.
> 
> Cc: David Daney <david.daney@cavium.com>
> Cc: Alex Smith <alex.smith@imgtec.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Is something like this also needed for ohci-platform?  Or are all OHCI 
implementations restricted to 32-bit DMA masks?

Alan Stern
