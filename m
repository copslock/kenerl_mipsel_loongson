Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2014 02:31:00 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41174 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822151AbaDAAa4YV0Dm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2014 02:30:56 +0200
Date:   Tue, 1 Apr 2014 01:30:56 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Levente Kurusa <levex@linux.com>,
        Ralf Baechle <ralf@linux-mips.org>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] tc: account for device_register() failure
In-Reply-To: <52863D5E.7080606@linux.com>
Message-ID: <alpine.LFD.2.11.1404010108270.27402@eddie.linux-mips.org>
References: <52863D5E.7080606@linux.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 15 Nov 2013, Levente Kurusa wrote:

> This patch makes the TURBOchannel driver bail out if the call
> to device_register() failed.
> 
> Signed-off-by: Levente Kurusa <levex@linux.com>

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

This fixes some build warnings:

drivers/tc/tc.c: In function 'tc_bus_add_devices':
drivers/tc/tc.c:132: warning: ignoring return value of 'device_register', 
declared with attribute warn_unused_result
drivers/tc/tc.c: In function 'tc_init':
drivers/tc/tc.c:151: warning: ignoring return value of 'device_register', 
declared with attribute warn_unused_result

Levente, thanks for your fix and apologies for the long RTT -- can you 
please resend your patch to <linux-mips@linux-mips.org> and Ralf so that 
it'll be pulled via the MIPS tree?  I'll post a follow-up update to fix 
some issues with `tc_init' that I noticed thanks to your change.

> ---
>  tc.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tc/tc.c b/drivers/tc/tc.c
> index a8aaf6a..6b3a038 100644
> --- a/drivers/tc/tc.c
> +++ b/drivers/tc/tc.c
> @@ -129,7 +129,10 @@ static void __init tc_bus_add_devices(struct tc_bus *tbus)
> 
>  		tc_device_get_irq(tdev);
> 
> -		device_register(&tdev->dev);
> +		if (device_register(&tdev->dev)) {
> +			put_device(&tdev->dev);
> +			goto out_err;
> +		}
>  		list_add_tail(&tdev->node, &tbus->devices);
> 
>  out_err:
> @@ -148,7 +151,10 @@ static int __init tc_init(void)
> 
>  	INIT_LIST_HEAD(&tc_bus.devices);
>  	dev_set_name(&tc_bus.dev, "tc");
> -	device_register(&tc_bus.dev);
> +	if (device_register(&tc_bus.dev)) {
> +		put_device(&tc_bus.dev);
> +		return 0;	
> +	}
> 
>  	if (tc_bus.info.slot_size) {
>  		unsigned int tc_clock = tc_get_speed(&tc_bus) / 100000;
> 

  Maciej
