Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jan 2018 10:12:47 +0100 (CET)
Received: from szxga05-in.huawei.com ([45.249.212.191]:2237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994652AbeALJMko5QXJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Jan 2018 10:12:40 +0100
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 69019EF43A06A;
        Fri, 12 Jan 2018 17:12:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.40) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.361.1; Fri, 12 Jan 2018
 17:12:19 +0800
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Greg KH <gregkh@linuxfoundation.org>
References: <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com>
 <b8ff7f17-7f2c-f220-9833-7ae5bd7343d5@c-s.fr>
 <8dd19411-5b06-0aa4-fd0e-e5b112c25dcb@huawei.com>
 <1eb206ed-95e9-5839-485d-0e549ff3f505@c-s.fr>
CC:     <linux-kernel@vger.kernel.org>, <ysxie@foxmail.com>,
        <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <boris.brezillon@free-electrons.com>, <richard@nod.at>,
        <marek.vasut@gmail.com>, <cyrille.pitchen@wedev4u.fr>,
        <linux-mtd@lists.infradead.org>, <alsa-devel@alsa-project.org>,
        <wim@iguana.be>, <linux@roeck-us.net>,
        <linux-watchdog@vger.kernel.org>, <b.zolnierkie@samsung.com>,
        <linux-fbdev@vger.kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <arnd@arndb.de>,
        <andriy.shevchenko@linux.intel.com>,
        <industrypack-devel@lists.sourceforge.net>, <wg@grandegger.com>,
        <mkl@pengutronix.de>, <linux-can@vger.kernel.org>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <linux-rtc@vger.kernel.org>, <daniel.vetter@intel.com>,
        <jani.nikula@linux.intel.com>, <seanpaul@chromium.org>,
        <airlied@linux.ie>, <dri-devel@lists.freedesktop.org>,
        <kvalo@codeaurora.org>, <linux-wireless@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <tj@kernel.org>,
        <linux-ide@vger.kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <dvhart@infradead.org>, <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <jakub.kicinski@netronome.com>, <davem@davemloft.net>,
        <nios2-dev@lists.rocketboards.org>, <netdev@vger.kernel.org>,
        <vinod.koul@intel.com>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <jslaby@suse.com>
From:   Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <ff498c83-d1ee-7553-e20c-a07369f8dad6@huawei.com>
Date:   Fri, 12 Jan 2018 17:12:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1eb206ed-95e9-5839-485d-0e549ff3f505@c-s.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Return-Path: <xieyisheng1@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62097
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

Hi Christophe ，

On 2018/1/4 16:05, Christophe LEROY wrote:
> 
> 
> Le 25/12/2017 à 02:34, Yisheng Xie a écrit :
>>
>>
>> On 2017/12/24 17:05, christophe leroy wrote:
>>>
>>>
>>> Le 23/12/2017 à 14:48, Greg KH a écrit :
>>>> On Sat, Dec 23, 2017 at 06:55:25PM +0800, Yisheng Xie wrote:
>>>>> Hi all,
>>>>>
>>>>> When I tried to use devm_ioremap function and review related code, I found
>>>>> devm_ioremap and devm_ioremap_nocache is almost the same with each other,
>>>>> except one use ioremap while the other use ioremap_nocache.
>>>>
>>>> For all arches?  Really?  Look at MIPS, and x86, they have different
>>>> functions.
>>>>
>>>>> While ioremap's
>>>>> default function is ioremap_nocache, so devm_ioremap_nocache also have the
>>>>> same function with devm_ioremap, which can just be killed to reduce the size
>>>>> of devres.o(from 20304 bytes to 18992 bytes in my compile environment).
>>>>>
>>>>> I have posted two versions, which use macro instead of function for
>>>>> devm_ioremap_nocache[1] or devm_ioremap[2]. And Greg suggest me to kill
>>>>> devm_ioremap_nocache for no need to keep a macro around for the duplicate
>>>>> thing. So here comes v3 and please help to review.
>>>>
>>>> I don't think this can be done, what am I missing?  These functions are
>>>> not identical, sorry for missing that before.
>>>
>>> devm_ioremap() and devm_ioremap_nocache() are quite similar, both use devm_ioremap_release() for the release, why not just defining:
>>>
>>> static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
>>>                 resource_size_t size, bool nocache)
>>> {
>>> [...]
>>>      if (nocache)
>>>          addr = ioremap_nocache(offset, size);
>>>      else
>>>          addr = ioremap(offset, size);
>>> [...]
>>> }
>>>
>>> then in include/linux/io.h
>>>
>>> static inline void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>>>                 resource_size_t size)
>>> {return __devm_ioremap(dev, offset, size, false);}
>>>
>>> static inline void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>>>                     resource_size_t size);
>>> {return __devm_ioremap(dev, offset, size, true);}
>>
>> Yeah, this seems good to me, right now we have devm_ioremap, devm_ioremap_wc, devm_ioremap_nocache
>> May be we can use an enum like:
>> typedef enum {
>>     DEVM_IOREMAP = 0,
>>     DEVM_IOREMAP_NOCACHE,
>>     DEVM_IOREMAP_WC,
>> } devm_ioremap_type;
>>
>> static inline void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>>                  resource_size_t size)
>>   {return __devm_ioremap(dev, offset, size, DEVM_IOREMAP);}
>>
>>   static inline void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>>                      resource_size_t size);
>>   {return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_NOCACHE);}
>>
>>   static inline void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
>>                      resource_size_t size);
>>   {return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_WC);}
>>
>>   static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
>>                  resource_size_t size, devm_ioremap_type type)
>>   {
>>       void __iomem **ptr, *addr = NULL;
>>   [...]
>>       switch (type){
>>       case DEVM_IOREMAP:
>>           addr = ioremap(offset, size);
>>           break;
>>       case DEVM_IOREMAP_NOCACHE:
>>           addr = ioremap_nocache(offset, size);
>>           break;
>>       case DEVM_IOREMAP_WC:
>>           addr = ioremap_wc(offset, size);
>>           break;
>>       }
>>   [...]
>>   }
> 
> 
> That looks good to me, will you submit a v4 ?

Sorry for late response. And I will submit the v4 as your suggestion.

Thanks
Yisheng

> 
> Christophe
> 
>>
