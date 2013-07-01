Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jul 2013 13:02:43 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:64269 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822972Ab3GALCkpiRyi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jul 2013 13:02:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 9026FD92;
        Mon,  1 Jul 2013 13:02:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id MhryFjXFtgw4; Mon,  1 Jul 2013 13:02:33 +0200 (CEST)
Received: from [192.168.178.21] (ppp-188-174-150-173.dynamic.mnet-online.de [188.174.150.173])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 90431D91;
        Mon,  1 Jul 2013 13:02:32 +0200 (CEST)
Message-ID: <51D1629A.6040700@metafoo.de>
Date:   Mon, 01 Jul 2013 13:06:02 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: bcm63xx: clk: Add dummy clk_set_rate() function
References: <1372676244-1399-1-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1372676244-1399-1-git-send-email-markos.chandras@imgtec.com>
X-Enigmail-Version: 1.4.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 07/01/2013 12:57 PM, Markos Chandras wrote:
> Several drivers use the clk_set_rate() function that needs
> to be defined in the platform's clock code. The Broadcom
> BCM63xx platform hardcodes the clock rate so we create a new
> dummy clk_set_rate() function which just returns -EINVAL.
> 
> Also fixes the following build problem on a randconfig:
> drivers/built-in.o: In function `nop_usb_xceiv_probe':
> phy-nop.c:(.text+0x3ec26c): undefined reference to `clk_set_rate'
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com> 

To make the set complete clk_round_rate() should be added as well

> ---
> This patch is for the upstream-sfr/mips-for-linux-next tree
> ---
>  arch/mips/bcm63xx/clk.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
> index c726a97..70dcc52 100644
> --- a/arch/mips/bcm63xx/clk.c
> +++ b/arch/mips/bcm63xx/clk.c
> @@ -318,6 +318,12 @@ unsigned long clk_get_rate(struct clk *clk)
>  
>  EXPORT_SYMBOL(clk_get_rate);
>  
> +int clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(clk_set_rate);
> +
>  struct clk *clk_get(struct device *dev, const char *id)
>  {
>  	if (!strcmp(id, "enet0"))
