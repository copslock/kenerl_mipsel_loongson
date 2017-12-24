Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Dec 2017 09:55:35 +0100 (CET)
Received: from pegase1.c-s.fr ([93.17.236.30]:3786 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990402AbdLXIz2mtDX8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 24 Dec 2017 09:55:28 +0100
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 3z4GKg5nxYz9ttRV;
        Sun, 24 Dec 2017 09:55:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JgmsZ25FYx3Y; Sun, 24 Dec 2017 09:55:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 3z4GKg4PTmz9ttRY;
        Sun, 24 Dec 2017 09:55:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A59B38B935;
        Sun, 24 Dec 2017 09:55:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oyrtmggyqBRe; Sun, 24 Dec 2017 09:55:22 +0100 (CET)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 172C68B930;
        Sun, 24 Dec 2017 09:55:20 +0100 (CET)
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Yisheng Xie <xieyisheng1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, ysxie@foxmail.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        boris.brezillon@free-electrons.com, richard@nod.at,
        marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
        linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org,
        wim@iguana.be, linux-watchdog@vger.kernel.org,
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
 <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <c28ac0bc-8bd2-3dce-3167-8c0f80ec601e@c-s.fr>
Date:   Sun, 24 Dec 2017 09:55:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 171223-0, 23/12/2017), Outbound message
X-Antivirus-Status: Clean
Return-Path: <christophe.leroy@c-s.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61564
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



Le 23/12/2017 à 16:57, Guenter Roeck a écrit :
> On 12/23/2017 05:48 AM, Greg KH wrote:
>> On Sat, Dec 23, 2017 at 06:55:25PM +0800, Yisheng Xie wrote:
>>> Hi all,
>>>
>>> When I tried to use devm_ioremap function and review related code, I 
>>> found
>>> devm_ioremap and devm_ioremap_nocache is almost the same with each 
>>> other,
>>> except one use ioremap while the other use ioremap_nocache.
>>
>> For all arches?  Really?  Look at MIPS, and x86, they have different
>> functions.
>>
> 
> Both mips and x86 end up mapping the same function, but other arches don't.
> mn10300 is one where ioremap and ioremap_nocache are definitely different.

alpha: identical
arc: identical
arm: identical
arm64: identical
cris: different        <==
frv: identical
hexagone: identical
ia64: different        <==
m32r: identical
m68k: identical
metag: identical
microblaze: identical
mips: identical
mn10300: different     <==
nios: identical
openrisc: different    <==
parisc: identical
riscv: identical
s390: identical
sh: identical
sparc: identical
tile: identical
um: rely on asm/generic
unicore32: identical
x86: identical
asm/generic (no mmu): identical

So 4 among all arches seems to have ioremap() and ioremap_nocache() 
being different.

Could we have a define set by the 4 arches on which ioremap() and 
ioremap_nocache() are different, something like 
HAVE_DIFFERENT_IOREMAP_NOCACHE ?

Christophe

> 
> Guenter
> 
>>> While ioremap's
>>> default function is ioremap_nocache, so devm_ioremap_nocache also 
>>> have the
>>> same function with devm_ioremap, which can just be killed to reduce 
>>> the size
>>> of devres.o(from 20304 bytes to 18992 bytes in my compile environment).
>>>
>>> I have posted two versions, which use macro instead of function for
>>> devm_ioremap_nocache[1] or devm_ioremap[2]. And Greg suggest me to kill
>>> devm_ioremap_nocache for no need to keep a macro around for the 
>>> duplicate
>>> thing. So here comes v3 and please help to review.
>>
>> I don't think this can be done, what am I missing?  These functions are
>> not identical, sorry for missing that before.
>>
>> thanks,
>>
>> greg k-h
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
