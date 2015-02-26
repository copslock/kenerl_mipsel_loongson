Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 00:33:11 +0100 (CET)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:36728 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007349AbbBZXdJKDVnJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 00:33:09 +0100
X-IronPort-AV: E=Sophos;i="5.09,655,1418112000"; 
   d="scan'208";a="57991889"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw3-out.broadcom.com with ESMTP; 26 Feb 2015 15:55:01 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Thu, 26 Feb 2015 15:33:00 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Thu, 26 Feb 2015 15:33:00 -0800
Received: from [10.136.8.241] (unknown [10.136.8.241])  by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id D3E2840FE5;  Thu, 26 Feb
 2015 15:31:50 -0800 (PST)
Message-ID: <54EFAD2A.9060501@broadcom.com>
Date:   Thu, 26 Feb 2015 15:32:58 -0800
From:   Ray Jui <rjui@broadcom.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Wolfram Sang <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC V2 12/12] i2c: bcm-iproc: make use of the new infrastructure
 for quirks
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de> <1424880126-15047-13-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1424880126-15047-13-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <rjui@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjui@broadcom.com
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



On 2/25/2015 8:02 AM, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-bcm-iproc.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index d3c89157b33774..f9f2c2082151e2 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -160,14 +160,6 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>  	u32 val;
>  	unsigned long time_left = msecs_to_jiffies(I2C_TIMEOUT_MESC);
>  
> -	/* need to reserve one byte in the FIFO for the slave address */
> -	if (msg->len > M_TX_RX_FIFO_SIZE - 1) {
> -		dev_err(iproc_i2c->device,
> -			"only support data length up to %u bytes\n",
> -			M_TX_RX_FIFO_SIZE - 1);
> -		return -EOPNOTSUPP;
> -	}
> -
>  	/* check if bus is busy */
>  	if (!!(readl(iproc_i2c->base + M_CMD_OFFSET) &
>  	       BIT(M_CMD_START_BUSY_SHIFT))) {
> @@ -287,6 +279,12 @@ static const struct i2c_algorithm bcm_iproc_algo = {
>  	.functionality = bcm_iproc_i2c_functionality,
>  };
>  
> +static struct i2c_adapter_quirks bcm_iproc_i2c_quirks = {
> +	/* need to reserve one byte in the FIFO for the slave address */
> +	.max_read_len = M_TX_RX_FIFO_SIZE - 1,
> +	.max_write_len = M_TX_RX_FIFO_SIZE - 1,
> +};
> +
>  static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
>  {
>  	unsigned int bus_speed;
> @@ -413,6 +411,7 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
>  	i2c_set_adapdata(adap, iproc_i2c);
>  	strlcpy(adap->name, "Broadcom iProc I2C adapter", sizeof(adap->name));
>  	adap->algo = &bcm_iproc_algo;
> +	adap->quirks = &bcm_iproc_i2c_quirks;
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
>  
> 

Change on the iproc i2c driver looks good to me. Sanity tested the
change from Wolfram's i2c/quirks branch on Cygnus 958300K combo board.
Sanity tested with an attempt to transfer large amount of I2C data to
ensure the transfer is denied by the i2c-core:

/ # cat /dev/i2c-0
[  657.310261] i2c i2c-0: quirk: msg too long (addr 0x0000, size 4096, read)

Reviewed-by: Ray Jui <rjui@broadcom.com>
Tested-by: Ray Jui <rjui@broadcom.com>

Thanks,

Ray
