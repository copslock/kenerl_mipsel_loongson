Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 10:51:39 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:50356 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012690AbcBYJvclMZdm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 10:51:32 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 8D2202803F9;
        Thu, 25 Feb 2016 10:51:30 +0100 (CET)
Received: from Dicker-Alter.lan (p548C9A7A.dip0.t-ipconnect.de [84.140.154.122])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu, 25 Feb 2016 10:51:30 +0100 (CET)
Subject: Re: [PATCH 2/2] MIPS: ralink: Make reset_control_ops const
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1456393547-28030-1-git-send-email-p.zabel@pengutronix.de>
 <1456393547-28030-3-git-send-email-p.zabel@pengutronix.de>
Cc:     linux-mips@linux-mips.org, kernel@pengutronix.de
From:   John Crispin <blogic@openwrt.org>
Message-ID: <56CECEA2.2050904@openwrt.org>
Date:   Thu, 25 Feb 2016 10:51:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1456393547-28030-3-git-send-email-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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



On 25/02/2016 10:45, Philipp Zabel wrote:
> The reset_ops structure is never modified. Make it const.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Acked-by: John Crispin <blogic@openwrt.org>

> ---
>  arch/mips/ralink/reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
> index ee117c4..09ccdd1 100644
> --- a/arch/mips/ralink/reset.c
> +++ b/arch/mips/ralink/reset.c
> @@ -61,7 +61,7 @@ static int ralink_reset_device(struct reset_controller_dev *rcdev,
>  	return ralink_deassert_device(rcdev, id);
>  }
>  
> -static struct reset_control_ops reset_ops = {
> +static const struct reset_control_ops reset_ops = {
>  	.reset = ralink_reset_device,
>  	.assert = ralink_assert_device,
>  	.deassert = ralink_deassert_device,
> 
