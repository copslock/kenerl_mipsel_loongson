Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2014 02:21:38 +0100 (CET)
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47287 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006750AbaKYBVgovvI9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Nov 2014 02:21:36 +0100
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9043220AF0
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 20:21:35 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Mon, 24 Nov 2014 20:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=x-sasl-enc:date:from:to:cc:subject
        :message-id:references:mime-version:content-type:in-reply-to; s=
        smtpout; bh=TXaaO5M0lOcWIjCWVInFhDMQgKc=; b=qNFp9wDrAwdg818DQ2vB
        LKOoCqptep5tZpcprgxxvLY/Pe+NuZTKaox4BDxudtKs9qAOy7Y7sqlDE0zfGVi9
        8FoZyaE4G1auJTCKSr8JjHka4HkkL6Ef8pBsPKkzAmhQSYYMNxK30ziQXVHLMUKt
        OPeTy4k6UvNrX4+OOkfvZb4=
X-Sasl-enc: kaNPNkF4eyqQyRqtIkWCkwUBXsmHXz7VMt5FlWUbF+Td 1416878495
Received: from localhost (unknown [24.22.230.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2CB24C0027F;
        Mon, 24 Nov 2014 20:21:35 -0500 (EST)
Date:   Mon, 24 Nov 2014 17:21:34 -0800
From:   Greg KH <greg@kroah.com>
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/3] USB: host: Remove ehci-octeon and ohci-octeon drivers
Message-ID: <20141125012134.GA5579@kroah.com>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1415914590-31647-2-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415914590-31647-2-git-send-email-andreas.herrmann@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Thu, Nov 13, 2014 at 10:36:28PM +0100, Andreas Herrmann wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> Remove special-purpose octeon drivers and instead use ehci-platform
> and ohci-platform as suggested with
> http://marc.info/?l=linux-mips&m=140139694721623&w=2
> 
> [andreas.herrmann:
> 	fixed compile error]
> 
> Cc: David Daney <david.daney@cavium.com>
> Cc: Alex Smith <alex.smith@imgtec.com>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/mips/cavium-octeon/octeon-platform.c |  274 ++++++++++++++++++++++++++++-
>  arch/mips/configs/cavium_octeon_defconfig |    3 +
>  drivers/usb/host/Kconfig                  |   18 +-
>  drivers/usb/host/Makefile                 |    1 -
>  drivers/usb/host/ehci-hcd.c               |    5 -
>  drivers/usb/host/ehci-octeon.c            |  188 --------------------
>  drivers/usb/host/octeon2-common.c         |  200 ---------------------
>  drivers/usb/host/ohci-hcd.c               |    5 -
>  drivers/usb/host/ohci-octeon.c            |  202 ---------------------
>  9 files changed, 285 insertions(+), 611 deletions(-)
>  delete mode 100644 drivers/usb/host/ehci-octeon.c
>  delete mode 100644 drivers/usb/host/octeon2-common.c
>  delete mode 100644 drivers/usb/host/ohci-octeon.c

This doesn't apply to my usb-next or usb-testing branch of usb.git on
git.kernel.org, so I can't apply it :(
