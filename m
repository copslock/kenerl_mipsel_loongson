Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jan 2018 09:06:05 +0100 (CET)
Received: from pegase1.c-s.fr ([93.17.236.30]:6056 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992273AbeADIF6MYKpD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Jan 2018 09:05:58 +0100
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 3zC0jB2JM2z9ty9F;
        Thu,  4 Jan 2018 09:05:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EL3Mbyqh6pjl; Thu,  4 Jan 2018 09:05:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 3zC0jB02nDz9ty7n;
        Thu,  4 Jan 2018 09:05:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 749968BD47;
        Thu,  4 Jan 2018 09:05:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tgYrns3zuNWp; Thu,  4 Jan 2018 09:05:46 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.40])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C5CB98B973;
        Thu,  4 Jan 2018 09:05:45 +0100 (CET)
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
To:     Yisheng Xie <xieyisheng1@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, ysxie@foxmail.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        boris.brezillon@free-electrons.com, richard@nod.at,
        marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
        linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org,
        wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        lgirdwood@gmail.com, broonie@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, arnd@arndb.de,
        andriy.shevchenko@linux.intel.com,
        industrypack-devel@lists.sourceforge.net, wg@grandegger.com,
        mkl@pengutronix.de, linux-can@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
        tj@kernel.org, linux-ide@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, devel@driverdev.osuosl.org,
        dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, jakub.kicinski@netronome.com,
        davem@davemloft.net, nios2-dev@lists.rocketboards.org,
        netdev@vger.kernel.org, vinod.koul@intel.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        jslaby@suse.com
References: <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com>
 <b8ff7f17-7f2c-f220-9833-7ae5bd7343d5@c-s.fr>
 <8dd19411-5b06-0aa4-fd0e-e5b112c25dcb@huawei.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <1eb206ed-95e9-5839-485d-0e549ff3f505@c-s.fr>
Date:   Thu, 4 Jan 2018 09:05:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <8dd19411-5b06-0aa4-fd0e-e5b112c25dcb@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Return-Path: <christophe.leroy@c-s.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: christophe.leroy@c-s.fr
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



Le 25/12/2017 à 02:34, Yisheng Xie a écrit :
> 
> 
> On 2017/12/24 17:05, christophe leroy wrote:
>>
>>
>> Le 23/12/2017 à 14:48, Greg KH a écrit :
>>> On Sat, Dec 23, 2017 at 06:55:25PM +0800, Yisheng Xie wrote:
>>>> Hi all,
>>>>
>>>> When I tried to use devm_ioremap function and review related code, I found
>>>> devm_ioremap and devm_ioremap_nocache is almost the same with each other,
>>>> except one use ioremap while the other use ioremap_nocache.
>>>
>>> For all arches?  Really?  Look at MIPS, and x86, they have different
>>> functions.
>>>
>>>> While ioremap's
>>>> default function is ioremap_nocache, so devm_ioremap_nocache also have the
>>>> same function with devm_ioremap, which can just be killed to reduce the size
>>>> of devres.o(from 20304 bytes to 18992 bytes in my compile environment).
>>>>
>>>> I have posted two versions, which use macro instead of function for
>>>> devm_ioremap_nocache[1] or devm_ioremap[2]. And Greg suggest me to kill
>>>> devm_ioremap_nocache for no need to keep a macro around for the duplicate
>>>> thing. So here comes v3 and please help to review.
>>>
>>> I don't think this can be done, what am I missing?  These functions are
>>> not identical, sorry for missing that before.
>>
>> devm_ioremap() and devm_ioremap_nocache() are quite similar, both use devm_ioremap_release() for the release, why not just defining:
>>
>> static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
>>                 resource_size_t size, bool nocache)
>> {
>> [...]
>>      if (nocache)
>>          addr = ioremap_nocache(offset, size);
>>      else
>>          addr = ioremap(offset, size);
>> [...]
>> }
>>
>> then in include/linux/io.h
>>
>> static inline void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>>                 resource_size_t size)
>> {return __devm_ioremap(dev, offset, size, false);}
>>
>> static inline void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>>                     resource_size_t size);
>> {return __devm_ioremap(dev, offset, size, true);}
> 
> Yeah, this seems good to me, right now we have devm_ioremap, devm_ioremap_wc, devm_ioremap_nocache
> May be we can use an enum like:
> typedef enum {
> 	DEVM_IOREMAP = 0,
> 	DEVM_IOREMAP_NOCACHE,
> 	DEVM_IOREMAP_WC,
> } devm_ioremap_type;
> 
> static inline void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
>                  resource_size_t size)
>   {return __devm_ioremap(dev, offset, size, DEVM_IOREMAP);}
> 
>   static inline void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
>                      resource_size_t size);
>   {return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_NOCACHE);}
> 
>   static inline void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
>                      resource_size_t size);
>   {return __devm_ioremap(dev, offset, size, DEVM_IOREMAP_WC);}
> 
>   static void __iomem *__devm_ioremap(struct device *dev, resource_size_t offset,
>                  resource_size_t size, devm_ioremap_type type)
>   {
>       void __iomem **ptr, *addr = NULL;
>   [...]
>       switch (type){
>       case DEVM_IOREMAP:
>           addr = ioremap(offset, size);
>           break;
>       case DEVM_IOREMAP_NOCACHE:
>           addr = ioremap_nocache(offset, size);
>           break;
>       case DEVM_IOREMAP_WC:
>           addr = ioremap_wc(offset, size);
>           break;
>       }
>   [...]
>   }


That looks good to me, will you submit a v4 ?

Christophe

> 
> Thanks
> Yisheng
> 
>>
>> Christophe
>>
>>>
>>> thanks,
>>>
>>> greg k-h
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> ---
>> L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
>> https://www.avast.com/antivirus
>>
>>
>> .
>>
