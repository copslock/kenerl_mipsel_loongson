Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Dec 2017 02:44:16 +0100 (CET)
Received: from szxga04-in.huawei.com ([45.249.212.190]:2174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990408AbdLYBoKIbCHa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Dec 2017 02:44:10 +0100
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E91EA3288755C;
        Mon, 25 Dec 2017 09:43:49 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.40) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.361.1; Mon, 25 Dec 2017
 09:43:47 +0800
Subject: Re: [PATCH v3 27/27] devres: kill devm_ioremap_nocache
To:     Greg KH <gregkh@linuxfoundation.org>
References: <1514026979-33838-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134532.GA10103@kroah.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ulf.hansson@linaro.org>, <jakub.kicinski@netronome.com>,
        <airlied@linux.ie>, <linux-wireless@vger.kernel.org>,
        <linus.walleij@linaro.org>, <alsa-devel@alsa-project.org>,
        <dri-devel@lists.freedesktop.org>,
        <platform-driver-x86@vger.kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <daniel.vetter@intel.com>,
        <dan.j.williams@intel.com>, <jason@lakedaemon.net>,
        <linux-rtc@vger.kernel.org>, <boris.brezillon@free-electrons.com>,
        <mchehab@kernel.org>, <dmaengine@vger.kernel.org>,
        <vinod.koul@intel.com>, <richard@nod.at>, <marek.vasut@gmail.com>,
        <industrypack-devel@lists.sourceforge.net>,
        <linux-pci@vger.kernel.org>, <dvhart@infradead.org>,
        <linux@roeck-us.net>, <linux-media@vger.kernel.org>,
        <seanpaul@chromium.org>, <devel@driverdev.osuosl.org>,
        <linux-watchdog@vger.kernel.org>, <arnd@arndb.de>,
        <b.zolnierkie@samsung.com>, <marc.zyngier@arm.com>,
        <jslaby@suse.com>, <jani.nikula@linux.intel.com>,
        <linux-can@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <broonie@kernel.org>, <mkl@pengutronix.de>,
        <linux-fbdev@vger.kernel.org>, <nios2-dev@lists.rocketboards.org>,
        <bhelgaas@google.com>, <tglx@linutronix.de>,
        <andriy.shevchenko@linux.intel.com>, <kvalo@codeaurora.org>,
        <a.zummo@towertech.it>, <netdev@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <lgirdwood@gmail.com>,
        <ralf@linux-mips.org>, <linux-spi@vger.kernel.org>,
        <ysxie@foxmail.com>, <wg@grandegger.com>,
        <cyrille.pitchen@wedev4u.fr>, <tj@kernel.org>,
        <alexandre.belloni@free-electrons.com>, <davem@davemloft.net>,
        <andy@infradead.org>
From:   Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <4d0991ec-9cd4-0c33-5560-ae9c2c762765@huawei.com>
Date:   Mon, 25 Dec 2017 09:43:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20171223134532.GA10103@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Return-Path: <xieyisheng1@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xieyisheng1@huawei.com
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



On 2017/12/23 21:45, Greg KH wrote:
> On Sat, Dec 23, 2017 at 07:02:59PM +0800, Yisheng Xie wrote:
>> --- a/lib/devres.c
>> +++ b/lib/devres.c
>> @@ -44,35 +44,6 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>>  EXPORT_SYMBOL(devm_ioremap);
>>  
>>  /**
>> - * devm_ioremap_nocache - Managed ioremap_nocache()
>> - * @dev: Generic device to remap IO address for
>> - * @offset: Resource address to map
>> - * @size: Size of map
>> - *
>> - * Managed ioremap_nocache().  Map is automatically unmapped on driver
>> - * detach.
>> - */
>> -void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>> -				   resource_size_t size)
>> -{
>> -	void __iomem **ptr, *addr;
>> -
>> -	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
>> -	if (!ptr)
>> -		return NULL;
>> -
>> -	addr = ioremap_nocache(offset, size);
> 
> Wait, devm_ioremap() calls ioremap(), not ioremap_nocache(), are you
> _SURE_ that these are all identical?  For all arches?  If so, then
> ioremap_nocache() can also be removed, right?

Yeah, As Christophe pointed out, that 4 archs do not have the same function.
But I do not why they do not want do the same thing. Driver may no know about
this? right?

> 
> In my quick glance, I don't think you can do this series at all :(

Yes, maybe should take Christophe suggestion and use a bool or enum to distinguish them?

Thanks
Yisheng
> 
> greg k-h
> 
> .
> 
