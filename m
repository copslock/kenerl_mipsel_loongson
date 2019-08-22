Return-Path: <SRS0=V/Ym=WS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAC5C3A59D
	for <linux-mips@archiver.kernel.org>; Thu, 22 Aug 2019 07:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDE921726
	for <linux-mips@archiver.kernel.org>; Thu, 22 Aug 2019 07:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfHVH4o (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:56:44 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34065 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfHVH4o (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 22 Aug 2019 03:56:44 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 86F8D1BF211;
        Thu, 22 Aug 2019 07:56:41 +0000 (UTC)
Date:   Thu, 22 Aug 2019 09:56:40 +0200
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, richardcochran@gmail.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        thomas.petazzoni@bootlin.com, allan.nielsen@microchip.com
Subject: Re: [PATCH net-next v3 4/8] MIPS: dts: mscc: describe the PTP ready
 interrupt
Message-ID: <20190822075640.GB3006@kwain>
References: <20190724081715.29159-1-antoine.tenart@bootlin.com>
 <20190724081715.29159-5-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190724081715.29159-5-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

On Wed, Jul 24, 2019 at 10:17:11AM +0200, Antoine Tenart wrote:
> This patch adds a description of the PTP ready interrupt, which can be
> triggered when a PTP timestamp is available on an hardware FIFO.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> Acked-by: Paul Burton <paul.burton@mips.com>

The net patches of this series were applied into the net-next tree.
However the two dts patches were not and should go through the MIPS
tree. Gentle ping about this :)

Thanks,
Antoine

> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index 1e55a778def5..797d336db54d 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -139,8 +139,8 @@
>  				    "port2", "port3", "port4", "port5", "port6",
>  				    "port7", "port8", "port9", "port10", "qsys",
>  				    "ana", "s2";
> -			interrupts = <21 22>;
> -			interrupt-names = "xtr", "inj";
> +			interrupts = <18 21 22>;
> +			interrupt-names = "ptp_rdy", "xtr", "inj";
>  
>  			ethernet-ports {
>  				#address-cells = <1>;
> -- 
> 2.21.0
> 

-- 
Antoine T�nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
