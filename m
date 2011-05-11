Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2011 18:49:54 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:45597 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491131Ab1EKQtv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2011 18:49:51 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4BGpHYU023804;
        Wed, 11 May 2011 17:51:17 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4BGpGGB023801;
        Wed, 11 May 2011 17:51:16 +0100
Date:   Wed, 11 May 2011 17:51:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 8/8] USB support for XLS platforms.
Message-ID: <20110511165116.GA20012@linux-mips.org>
References: <cover.1304712046.git.jayachandranc@netlogicmicro.com>
 <70d6e74aef472dfde06b0aeb4a63ebaf7666b155.1304712046.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70d6e74aef472dfde06b0aeb4a63ebaf7666b155.1304712046.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, May 07, 2011 at 01:37:52AM +0530, Jayachandran C wrote:

> update ehci-hcd.c and ohci-hcd.c to add XLS hcds
> add ehci/ohci devices to XLR/XLS platform driver
> Kconfig update
> 
> Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
> ---
>  arch/mips/Kconfig                 |    2 +
>  arch/mips/netlogic/xlr/platform.c |   89 ++++++++++++++++++++
>  drivers/usb/host/ehci-hcd.c       |    5 +
>  drivers/usb/host/ehci-xls.c       |  161 +++++++++++++++++++++++++++++++++++++
>  drivers/usb/host/ohci-hcd.c       |    5 +
>  drivers/usb/host/ohci-xls.c       |  151 ++++++++++++++++++++++++++++++++++
>  6 files changed, 413 insertions(+), 0 deletions(-)

This will need to be reviewed and acked by the USB maintainers.  Can you
repost ccing to linux-usb and the respective maintainers?  Thanks!

  Ralf
