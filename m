Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 16:51:06 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:50124 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824814Ab3HHOvD7JQQ2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Aug 2013 16:51:03 +0200
Message-ID: <5203B020.1080909@imgtec.com>
Date:   Thu, 8 Aug 2013 15:50:08 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: Re: [PATCH 2/2] serial: MIPS: lantiq: make driver use pinctrl
References: <1375968687-8704-1-git-send-email-blogic@openwrt.org> <1375968687-8704-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1375968687-8704-2-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_08_08_15_50_51
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 08/08/13 14:31, John Crispin wrote:
> From: Thomas Langer <thomas.langer@lantiq.com>
> 
> Add use of devm_pinctrl_get_select_default to active default pinctrl settings.
> 
> Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
> Acked-by: John Crispin <blogic@openwrt.org>
> ---
>  drivers/tty/serial/lantiq.c |    7 +++++++
>  1 file changed, 7 insertions(+)


> @@ -719,6 +722,10 @@ lqasc_probe(struct platform_device *pdev)
>  	port->irq	= irqres[0].start;
>  	port->mapbase	= mmres->start;
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev, "pins are not configured from the driver\n");

I believe since v3.9 (specifically commit ab78029) this happens
automatically.

Cheers
James
