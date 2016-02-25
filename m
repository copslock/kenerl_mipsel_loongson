Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 10:51:23 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:50347 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006642AbcBYJvVVKmRm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2016 10:51:21 +0100
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 3105D2803F9;
        Thu, 25 Feb 2016 10:51:19 +0100 (CET)
Received: from Dicker-Alter.lan (p548C9A7A.dip0.t-ipconnect.de [84.140.154.122])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Thu, 25 Feb 2016 10:51:19 +0100 (CET)
Subject: Re: [PATCH 1/2] MIPS: lantiq: Make reset_control_ops const
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1456393547-28030-1-git-send-email-p.zabel@pengutronix.de>
 <1456393547-28030-2-git-send-email-p.zabel@pengutronix.de>
Cc:     linux-mips@linux-mips.org, kernel@pengutronix.de
From:   John Crispin <blogic@openwrt.org>
Message-ID: <56CECE96.5000508@openwrt.org>
Date:   Thu, 25 Feb 2016 10:51:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1456393547-28030-2-git-send-email-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52235
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
>  arch/mips/lantiq/xway/reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/lantiq/xway/reset.c b/arch/mips/lantiq/xway/reset.c
> index bc29bb3..1f34608 100644
> --- a/arch/mips/lantiq/xway/reset.c
> +++ b/arch/mips/lantiq/xway/reset.c
> @@ -258,7 +258,7 @@ static int ltq_reset_device(struct reset_controller_dev *rcdev,
>  	return ltq_deassert_device(rcdev, id);
>  }
>  
> -static struct reset_control_ops reset_ops = {
> +static const struct reset_control_ops reset_ops = {
>  	.reset = ltq_reset_device,
>  	.assert = ltq_assert_device,
>  	.deassert = ltq_deassert_device,
> 
