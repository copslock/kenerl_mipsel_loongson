Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2018 03:33:42 +0200 (CEST)
Received: from szxga06-in.huawei.com ([45.249.212.32]:57531 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994648AbeIUBdjbjw-0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 21 Sep 2018 03:33:39 +0200
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AC4E49E1DB295;
        Fri, 21 Sep 2018 09:33:28 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 09:33:26 +0800
Subject: Re: [PATCH net-next 00/22] net: fix return type of ndo_start_xmit
 function
To:     David Miller <davem@davemloft.net>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920.085055.1188796939437872993.davem@davemloft.net>
CC:     <dmitry.tarnyagin@lockless.no>, <wg@grandegger.com>,
        <mkl@pengutronix.de>, <michal.simek@xilinx.com>,
        <hsweeten@visionengravers.com>, <madalin.bucur@nxp.com>,
        <pantelis.antoniou@gmail.com>, <claudiu.manoil@nxp.com>,
        <leoyang.li@nxp.com>, <linux@armlinux.org.uk>, <sammy@sammy.net>,
        <ralf@linux-mips.org>, <nico@fluxnic.net>,
        <steve.glendinning@shawell.net>, <f.fainelli@gmail.com>,
        <grygorii.strashko@ti.com>, <w-kwok2@ti.com>,
        <m-karicheri2@ti.com>, <t.sailer@alumni.ethz.ch>,
        <jreuter@yaina.de>, <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu2@citrix.com>, <paul.durrant@citrix.com>,
        <arvid.brodin@alten.se>, <pshelar@ovn.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        <linux-omap@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <devel@linuxdriverproject.org>, <linux-usb@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <dev@openvswitch.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <83d29681-b008-9b1f-5961-e23f0174d5f4@huawei.com>
Date:   Fri, 21 Sep 2018 09:33:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180920.085055.1188796939437872993.davem@davemloft.net>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Return-Path: <yuehaibing@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66470
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

On 2018/9/20 23:50, David Miller wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Thu, 20 Sep 2018 20:32:44 +0800
> 
>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>> which is a typedef for an enum type, so make sure the implementation in
>> this driver has returns 'netdev_tx_t' value, and change the function
>> return type to netdev_tx_t.
> 
> I would advise you not to send so many of these changes as a group.
> 
> If one of the patches needs feedback addressed, which is already the
> case, you will have to resubmit the entire series all over again with
> the fixes.
> 

Yes, I will send it separately after test and review again.

Thank you for your advice.

> .
> 
