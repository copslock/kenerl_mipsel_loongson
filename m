Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2018 03:35:41 +0200 (CEST)
Received: from szxga07-in.huawei.com ([45.249.212.35]:40699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992747AbeIUBfbrL3o0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Sep 2018 03:35:31 +0200
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 28A312C7B5C6E;
        Fri, 21 Sep 2018 09:35:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 09:35:16 +0800
Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920123306.14772-18-yuehaibing@huawei.com>
 <20180920074341.3acef75c@xeon-e3>
 <BN6PR21MB016180C794F26A279345A17FCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.tarnyagin@lockless.no" <dmitry.tarnyagin@lockless.no>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
        "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
        "pantelis.antoniou@gmail.com" <pantelis.antoniou@gmail.com>,
        "claudiu.manoil@nxp.com" <claudiu.manoil@nxp.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "sammy@sammy.net" <sammy@sammy.net>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "steve.glendinning@shawell.net" <steve.glendinning@shawell.net>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
        "w-kwok2@ti.com" <w-kwok2@ti.com>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "t.sailer@alumni.ethz.ch" <t.sailer@alumni.ethz.ch>,
        "jreuter@yaina.de" <jreuter@yaina.de>,
        "KY Srinivasan" <kys@microsoft.com>,
        "wei.liu2@citrix.com" <wei.liu2@citrix.com>,
        "paul.durrant@citrix.com" <paul.durrant@citrix.com>,
        "arvid.brodin@alten.se" <arvid.brodin@alten.se>,
        "pshelar@ovn.org" <pshelar@ovn.org>,
        "dev@openvswitch.org" <dev@openvswitch.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <1dfae517-640a-fa56-34e8-52964c29a15f@huawei.com>
Date:   Fri, 21 Sep 2018 09:35:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <BN6PR21MB016180C794F26A279345A17FCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Return-Path: <yuehaibing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66471
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

On 2018/9/20 22:50, Haiyang Zhang wrote:
> 
> 
>> -----Original Message-----
>> From: Stephen Hemminger <stephen@networkplumber.org>
>> Sent: Thursday, September 20, 2018 10:44 AM
>> To: YueHaibing <yuehaibing@huawei.com>
>> Cc: davem@davemloft.net; dmitry.tarnyagin@lockless.no;
>> wg@grandegger.com; mkl@pengutronix.de; michal.simek@xilinx.com;
>> hsweeten@visionengravers.com; madalin.bucur@nxp.com;
>> pantelis.antoniou@gmail.com; claudiu.manoil@nxp.com; leoyang.li@nxp.com;
>> linux@armlinux.org.uk; sammy@sammy.net; ralf@linux-mips.org;
>> nico@fluxnic.net; steve.glendinning@shawell.net; f.fainelli@gmail.com;
>> grygorii.strashko@ti.com; w-kwok2@ti.com; m-karicheri2@ti.com;
>> t.sailer@alumni.ethz.ch; jreuter@yaina.de; KY Srinivasan <kys@microsoft.com>;
>> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu2@citrix.com;
>> paul.durrant@citrix.com; arvid.brodin@alten.se; pshelar@ovn.org;
>> dev@openvswitch.org; linux-mips@linux-mips.org; xen-
>> devel@lists.xenproject.org; netdev@vger.kernel.org; linux-usb@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-can@vger.kernel.org;
>> devel@linuxdriverproject.org; linux-hams@vger.kernel.org; linux-
>> omap@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-arm-
>> kernel@lists.infradead.org
>> Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
>> ndo_start_xmit function
>>
>> On Thu, 20 Sep 2018 20:33:01 +0800
>> YueHaibing <yuehaibing@huawei.com> wrote:
>>> int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>>>  	 */
>>>  	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
>>>  	if (vf_netdev && netif_running(vf_netdev) &&
>>> -	    !netpoll_tx_running(net))
>>> -		return netvsc_vf_xmit(net, vf_netdev, skb);
>>> +	    !netpoll_tx_running(net)) {
>>> +		ret = netvsc_vf_xmit(net, vf_netdev, skb);
>>> +		if (ret)
>>> +			return NETDEV_TX_BUSY;
>>> +	}
>>
>> Sorry, the new code is wrong. It will fall through if ret == 0 (NETDEV_TX_OK)
>> Please review and test your patches.
> 
> Plus consideration of -- For error case, please just return NETDEV_TX_OK. We 
> are not sure if the error can go away after retrying, returning NETDEV_TX_BUSY 
> may cause infinite retry from the upper layer.
> 
> So, let's just always return NETDEV_TX_OK like this:
> 		netvsc_vf_xmit(net, vf_netdev, skb);
> 		return NETDEV_TX_OK;

Thank you for review.

Will do that in v2.

> 
> Thanks,
> - Haiyang
> 
> .
> 
