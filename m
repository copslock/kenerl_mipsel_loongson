Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2011 20:42:57 +0200 (CEST)
Received: from cantor2.suse.de ([195.135.220.15]:44709 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491882Ab1HLSmu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Aug 2011 20:42:50 +0200
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx2.suse.de (Postfix) with ESMTP id 78F688D40D;
        Fri, 12 Aug 2011 20:42:50 +0200 (CEST)
Date:   Fri, 12 Aug 2011 11:42:27 -0700
From:   Greg KH <gregkh@suse.de>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH V2 1/8] MIPS: Alchemy: abstract USB block control
 register access
Message-ID: <20110812184227.GA17057@suse.de>
References: <1313172753-31088-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1313172753-31088-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@suse.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9632

On Fri, Aug 12, 2011 at 08:12:33PM +0200, Manuel Lauss wrote:
> Alchemy chips have one or more registers which control access
> to the usb blocks as well as PHY configuration.  I don't want
> the OHCI/EHCI glues to know about the different registers and bits;
> new code hides the gory details of USB configuration from them.
> 
> Cc: linux-usb@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@suse.de>  (USB glue parts)
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> V2: moved the chip-specific parts from arch home to usb/host/alchemy-common.c
> 
>  arch/mips/alchemy/common/dma.c             |   12 +-
>  arch/mips/alchemy/common/power.c           |   42 ----
>  arch/mips/include/asm/mach-au1x00/au1000.h |   84 ++------
>  drivers/usb/host/Makefile                  |    1 +
>  drivers/usb/host/alchemy-common.c          |  337 ++++++++++++++++++++++++++++
>  drivers/usb/host/ehci-au1xxx.c             |   77 +------
>  drivers/usb/host/ohci-au1xxx.c             |  110 +--------
>  7 files changed, 382 insertions(+), 281 deletions(-)
>  create mode 100644 drivers/usb/host/alchemy-common.c

Much nicer, thanks.

I can take this in the USB tree if the MIPS developers want, or if not,
feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
and take it through the MIPS tree.

greg k-h
