Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2018 03:38:06 +0200 (CEST)
Received: from szxga05-in.huawei.com ([45.249.212.191]:2245 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992747AbeIUBiCxI7s0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Sep 2018 03:38:02 +0200
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 563E5E8431EDA;
        Fri, 21 Sep 2018 09:37:53 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 09:37:53 +0800
Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
To:     Stephen Hemminger <stephen@networkplumber.org>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920123306.14772-18-yuehaibing@huawei.com>
 <20180920074341.3acef75c@xeon-e3>
CC:     <davem@davemloft.net>, <dmitry.tarnyagin@lockless.no>,
        <wg@grandegger.com>, <mkl@pengutronix.de>,
        <michal.simek@xilinx.com>, <hsweeten@visionengravers.com>,
        <madalin.bucur@nxp.com>, <pantelis.antoniou@gmail.com>,
        <claudiu.manoil@nxp.com>, <leoyang.li@nxp.com>,
        <linux@armlinux.org.uk>, <sammy@sammy.net>, <ralf@linux-mips.org>,
        <nico@fluxnic.net>, <steve.glendinning@shawell.net>,
        <f.fainelli@gmail.com>, <grygorii.strashko@ti.com>,
        <w-kwok2@ti.com>, <m-karicheri2@ti.com>, <t.sailer@alumni.ethz.ch>,
        <jreuter@yaina.de>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
        <arvid.brodin@alten.se>, <pshelar@ovn.org>, <dev@openvswitch.org>,
        <linux-mips@linux-mips.org>, <xen-devel@lists.xenproject.org>,
        <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-can@vger.kernel.org>,
        <devel@linuxdriverproject.org>, <linux-hams@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <b9b170c4-caba-928e-4c6f-eb51cb5e4707@huawei.com>
Date:   Fri, 21 Sep 2018 09:37:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180920074341.3acef75c@xeon-e3>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Return-Path: <yuehaibing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66472
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuehaibing@huawei.com
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

On 2018/9/20 22:43, Stephen Hemminger wrote:
> On Thu, 20 Sep 2018 20:33:01 +0800
> YueHaibing <yuehaibing@huawei.com> wrote:
> 
>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>> which is a typedef for an enum type, so make sure the implementation in
>> this driver has returns 'netdev_tx_t' value, and change the function
>> return type to netdev_tx_t.
>>
>> Found by coccinelle.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/net/hyperv/netvsc_drv.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
>> index 3af6d8d..056c472 100644
>> --- a/drivers/net/hyperv/netvsc_drv.c
>> +++ b/drivers/net/hyperv/netvsc_drv.c
>> @@ -511,7 +511,8 @@ static int netvsc_vf_xmit(struct net_device *net, struct net_device *vf_netdev,
>>  	return rc;
>>  }
>>  
>> -static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>> +static netdev_tx_t
>> +netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>>  {
>>  	struct net_device_context *net_device_ctx = netdev_priv(net);
>>  	struct hv_netvsc_packet *packet = NULL;
>> @@ -528,8 +529,11 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>>  	 */
>>  	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
>>  	if (vf_netdev && netif_running(vf_netdev) &&
>> -	    !netpoll_tx_running(net))
>> -		return netvsc_vf_xmit(net, vf_netdev, skb);
>> +	    !netpoll_tx_running(net)) {
>> +		ret = netvsc_vf_xmit(net, vf_netdev, skb);
>> +		if (ret)
>> +			return NETDEV_TX_BUSY;
>> +	}
> 
> Sorry, the new code is wrong. It will fall through if ret == 0 (NETDEV_TX_OK)
> Please review and test your patches.

I'm sorry for this, will correct it as Haiyang's suggestion.

> 
> .
> 
