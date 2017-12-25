Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Dec 2017 02:10:03 +0100 (CET)
Received: from szxga05-in.huawei.com ([45.249.212.191]:2235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23990408AbdLYBJ4qL9V4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Dec 2017 02:09:56 +0100
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 796A5DB94437B;
        Mon, 25 Dec 2017 09:09:36 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.40) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.361.1; Mon, 25 Dec 2017
 09:09:33 +0800
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
To:     christophe leroy <christophe.leroy@c-s.fr>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>
References: <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com>
 <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net>
 <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
CC:     <linux-kernel@vger.kernel.org>, <ysxie@foxmail.com>,
        <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <boris.brezillon@free-electrons.com>, <richard@nod.at>,
        <marek.vasut@gmail.com>, <cyrille.pitchen@wedev4u.fr>,
        <linux-mtd@lists.infradead.org>, <alsa-devel@alsa-project.org>,
        <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
        <b.zolnierkie@samsung.com>, <linux-fbdev@vger.kernel.org>,
        <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>, <arnd@arndb.de>,
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
Message-ID: <6c0ade63-f4d3-d44d-c622-b091eb2ba902@huawei.com>
Date:   Mon, 25 Dec 2017 09:09:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Return-Path: <xieyisheng1@huawei.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61566
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

hi Christophe and Greg,

On 2017/12/24 16:55, christophe leroy wrote:
> 
> 
> Le 23/12/2017 à 16:57, Guenter Roeck a écrit :
>> On 12/23/2017 05:48 AM, Greg KH wrote:
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
>>
>> Both mips and x86 end up mapping the same function, but other arches don't.
>> mn10300 is one where ioremap and ioremap_nocache are definitely different.
> 
> alpha: identical
> arc: identical
> arm: identical
> arm64: identical
> cris: different        <==
> frv: identical
> hexagone: identical
> ia64: different        <==
> m32r: identical
> m68k: identical
> metag: identical
> microblaze: identical
> mips: identical
> mn10300: different     <==
> nios: identical
> openrisc: different    <==
> parisc: identical
> riscv: identical
> s390: identical
> sh: identical
> sparc: identical
> tile: identical
> um: rely on asm/generic
> unicore32: identical
> x86: identical
> asm/generic (no mmu): identical

Wow, that's correct, sorry for I have just checked the main archs, I means
x86,arm, arm64, mips.

However, I stall have no idea about why these 4 archs want different ioremap
function with others. Drivers seems cannot aware this? If driver call ioremap
want he really want for there 4 archs, cache or nocache?

> 
> So 4 among all arches seems to have ioremap() and ioremap_nocache() being different.
> 
> Could we have a define set by the 4 arches on which ioremap() and ioremap_nocache() are different, something like HAVE_DIFFERENT_IOREMAP_NOCACHE ?

Then, what the HAVE_DIFFERENT_IOREMAP_NOCACHE is uesed for ?

Thanks
Yisheng
> 
> Christophe
> 
>>
>> Guenter
>>
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

Never mind, I should checked all the arches, sorry about that.

>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> ---
> L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
> https://www.avast.com/antivirus
> 
> 
> .
> 
