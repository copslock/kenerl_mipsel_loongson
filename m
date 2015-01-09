Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2015 21:30:37 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011023AbbAIUafR0UGm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Jan 2015 21:30:35 +0100
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3ABBDA59;
        Fri,  9 Jan 2015 20:30:28 +0000 (UTC)
Date:   Fri, 9 Jan 2015 12:30:27 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 2/2 resend v2] USB: host: Introduce flag to enable use of
 64-bit dma_mask for ehci-platform
Message-ID: <20150109203027.GA5772@kroah.com>
References: <20141215132628.GA20109@alberich>
 <20150106124644.GA4194@alberich>
 <20150106125015.GC4194@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150106125015.GC4194@alberich>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Tue, Jan 06, 2015 at 01:50:15PM +0100, Andreas Herrmann wrote:
> ehci-octeon driver used a 64-bit dma_mask. With removal of ehci-octeon
> and usage of ehci-platform ehci dma_mask is now limited to 32 bits
> (coerced in ehci_platform_probe).
> 
> Provide a flag in ehci platform data to allow use of 64 bits for
> dma_mask.
> 
> Cc: David Daney <david.daney@cavium.com>
> Cc: Alex Smith <alex.smith@imgtec.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
>  arch/mips/cavium-octeon/octeon-platform.c |    4 +---
>  drivers/usb/host/ehci-platform.c          |    3 ++-
>  include/linux/usb/ehci_pdriver.h          |    1 +
>  3 files changed, 4 insertions(+), 4 deletions(-)

This no longer applies to my usb-testing branch, can you refresh it and
resend?

thanks,

greg k-h
