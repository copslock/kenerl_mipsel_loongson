Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 15:37:16 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:39921 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S6870194Ab2JDNgmOgBm2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 15:36:42 +0200
Received: (qmail 2758 invoked by uid 2102); 3 Oct 2012 12:01:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Oct 2012 12:01:22 -0400
Date:   Wed, 3 Oct 2012 12:01:22 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Florian Fainelli <florian@openwrt.org>
cc:     linux-usb@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Jayachandran C <jayachandranc@netlogicmicro.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/25] USB: ehci: allow need_io_watchdog to be passed to
 ehci-platform driver
In-Reply-To: <1349276601-8371-7-git-send-email-florian@openwrt.org>
Message-ID: <Pine.LNX.4.44L0.1210031154400.1441-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 34598
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 3 Oct 2012, Florian Fainelli wrote:

> And convert all the existing users of ehci-platform to specify a correct
> need_io_watchdog value.

IMO (and I realize that not everybody agrees), the patch description 
should not be considered an extension of the patch title, as though the 
title were the first sentence and the description the remainder of the 
same paragraph.  Descriptions should stand on their own and be 
comprehensible even to somebody who hasn't read the title.

> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
>  arch/mips/ath79/dev-usb.c             |    2 ++
>  arch/mips/loongson1/common/platform.c |    1 +
>  arch/mips/netlogic/xlr/platform.c     |    1 +
>  drivers/usb/host/bcma-hcd.c           |    1 +
>  drivers/usb/host/ehci-platform.c      |    1 +
>  drivers/usb/host/ssb-hcd.c            |    1 +
>  include/linux/usb/ehci_pdriver.h      |    3 +++
>  7 files changed, 10 insertions(+)

More importantly...  Nearly every driver will have need_io_watchdog
set.  Only a few of them explicitly turn it off.  The approach you're 
using puts an extra burden on most of the drivers.

> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> index 764e010..08d5dec 100644
> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -32,6 +32,7 @@ static int ehci_platform_reset(struct usb_hcd *hcd)
>  	ehci->has_synopsys_hc_bug = pdata->has_synopsys_hc_bug;
>  	ehci->big_endian_desc = pdata->big_endian_desc;
>  	ehci->big_endian_mmio = pdata->big_endian_mmio;
> +	ehci->need_io_watchdog = pdata->need_io_watchdog;

> --- a/include/linux/usb/ehci_pdriver.h
> +++ b/include/linux/usb/ehci_pdriver.h
> @@ -29,6 +29,8 @@
>   *			initialization.
>   * @port_power_off:	set to 1 if the controller needs to be powered down
>   *			after initialization.
> + * @need_io_watchdog:	set to 1 if the controller needs the I/O watchdog to
> + *			run.

Instead, how about adding a no_io_watchdog flag?  Then after 
ehci-platform.c calls ehci_setup(), it can see whether to turn off 
ehci->need_io_watchdog.

This way, most of this patch would become unnecessary.

Alan Stern
