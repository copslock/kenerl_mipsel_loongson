Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Aug 2016 16:21:15 +0200 (CEST)
Received: from iolanthe.rowland.org ([192.131.102.54]:58132 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S23993107AbcHIOVGwrzeC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Aug 2016 16:21:06 +0200
Received: (qmail 2437 invoked by uid 2102); 9 Aug 2016 10:21:04 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2016 10:21:04 -0400
Date:   Tue, 9 Aug 2016 10:21:04 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Paul Burton <paul.burton@imgtec.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/20] usb: host: ehci-sead3: Remove non-DT probe code
In-Reply-To: <20160809123546.10190-9-paul.burton@imgtec.com>
Message-ID: <Pine.LNX.4.44L0.1608091020260.1919-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <stern+57b19836@rowland.harvard.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54462
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

On Tue, 9 Aug 2016, Paul Burton wrote:

> Now that the SEAD3 board is probing the EHCI controller using device
> tree, remove the non-DT support from the probe function.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  drivers/usb/host/ehci-sead3.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-sead3.c b/drivers/usb/host/ehci-sead3.c
> index 05db1ae..b88ecfe 100644
> --- a/drivers/usb/host/ehci-sead3.c
> +++ b/drivers/usb/host/ehci-sead3.c
> @@ -102,18 +102,10 @@ static int ehci_hcd_sead3_drv_probe(struct platform_device *pdev)
>  	if (usb_disabled())
>  		return -ENODEV;
>  
> -	if (pdev->dev.of_node) {
> -		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> -		if (!irq) {
> -			dev_err(&pdev->dev, "failed to map IRQ\n");
> -			return -ENODEV;
> -		}
> -	} else {
> -		if (pdev->resource[1].flags != IORESOURCE_IRQ) {
> -			pr_debug("resource[1] is not IORESOURCE_IRQ");
> -			return -ENOMEM;
> -		}
> -		irq = pdev->resource[1].start;
> +	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
> +	if (!irq) {
> +		dev_err(&pdev->dev, "failed to map IRQ\n");
> +		return -ENODEV;
>  	}
>  
>  	hcd = usb_create_hcd(&ehci_sead3_hc_driver, &pdev->dev, "SEAD-3");

For both this patch and the 06/20 patch:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
