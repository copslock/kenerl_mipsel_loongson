Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Sep 2012 17:22:18 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:33170 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903205Ab2IIPWN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Sep 2012 17:22:13 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 192088880;
        Sun,  9 Sep 2012 17:22:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aB-ZH3eDWthP; Sun,  9 Sep 2012 17:22:07 +0200 (CEST)
Received: from [192.168.178.21] (dyndsl-085-016-153-152.ewe-ip-backbone.de [85.16.153.152])
        by hauke-m.de (Postfix) with ESMTPSA id 87FFF87B9;
        Sun,  9 Sep 2012 17:22:07 +0200 (CEST)
Message-ID: <504CB41E.6070201@hauke-m.de>
Date:   Sun, 09 Sep 2012 17:22:06 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     ralf@linux-mips.org, john@phrozen.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, florian@openwrt.org
Subject: Re: [PATCH v3 2/3] bcma: add GPIO driver for SoCs
References: <1346427485-12801-1-git-send-email-hauke@hauke-m.de> <1346427485-12801-3-git-send-email-hauke@hauke-m.de> <CACna6rwb15pfbM6rM5ros0yCSW+uv1CbwWz5pUz8OgvONKKrvg@mail.gmail.com>
In-Reply-To: <CACna6rwb15pfbM6rM5ros0yCSW+uv1CbwWz5pUz8OgvONKKrvg@mail.gmail.com>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 34445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/03/2012 09:15 PM, Rafał Miłecki wrote:
> 2012/8/31 Hauke Mehrtens <hauke@hauke-m.de>:
>> +u32 bcma_gpio_in(struct bcma_bus *bus, u32 mask)
>> +{
>> +       unsigned long flags;
>> +       u32 res = 0;
>> +
>> +       spin_lock_irqsave(&bus->gpio_lock, flags);
>> +       res = bcma_chipco_gpio_in(&bus->drv_cc, mask);
>> +       spin_unlock_irqrestore(&bus->gpio_lock, flags);
>> +
>> +       return res;
>> +}
>> +EXPORT_SYMBOL(bcma_gpio_in);
> 
> 
> Could we put here direct ops on ChipCommon regs and drop GPIO
> functions from driver_chipcommon.c?

So you mean that all accesses to the gpio registers are locked, also
when b43 or bcma accesses them? If so, I will change my patch and test
it on my devices. I am currently not at my development machine and do
not have the test devices here, but I will see if I find some time on
Tuesday when I am home again.

So bcma_chipco_gpio_XXX() should not be exported in the way it is done
now any more and all accesses to the gpio registers should be locked.

Hauke
