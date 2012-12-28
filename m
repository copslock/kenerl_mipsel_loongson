Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Dec 2012 12:33:02 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:57378 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822664Ab2L1LdBBBGy3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Dec 2012 12:33:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 6BD5B8F60;
        Fri, 28 Dec 2012 12:33:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0BmKzutz7Frx; Fri, 28 Dec 2012 12:32:51 +0100 (CET)
Received: from [IPv6:2001:67c:20a1:1208:8401:4b4f:e1fa:500c] (unknown [IPv6:2001:67c:20a1:1208:8401:4b4f:e1fa:500c])
        by hauke-m.de (Postfix) with ESMTPSA id 6F7CA8E1C;
        Fri, 28 Dec 2012 12:32:51 +0100 (CET)
Message-ID: <50DD8361.80805@hauke-m.de>
Date:   Fri, 28 Dec 2012 12:32:49 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/6] MIPS: BCM47XX: nvram read enhancements
References: <1356555074-1230-1-git-send-email-hauke@hauke-m.de> <CACna6rwqPtCb7GqXYQw5qL3_cUQ8xn6z_U5zCq0E0vZ0yhJXTA@mail.gmail.com> <50DC4509.8090502@hauke-m.de> <CACna6rzAS0zwERF1kA=FXAsO7ROXb9qyEcLyQ7Uc7i=KBOrS+A@mail.gmail.com>
In-Reply-To: <CACna6rzAS0zwERF1kA=FXAsO7ROXb9qyEcLyQ7Uc7i=KBOrS+A@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35344
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

On 12/28/2012 01:00 AM, Rafał Miłecki wrote:
> 2012/12/27 Hauke Mehrtens <hauke@hauke-m.de>:
>> On 12/27/2012 09:49 AM, Rafał Miłecki wrote:
>>> 2012/12/26 Hauke Mehrtens <hauke@hauke-m.de>:
>>>> Clean up the nvram reading code and add support for different nvram
>>>> sizes.
>>>>
>>>> This depends on patch "MIPS: bcm47xx: separate functions finding flash
>>>> window addr" by Rafał Miłeck, Patchwork:  https://patchwork.linux-mips.org/patch/4738/
>>>>
>>>> Hauke Mehrtens (6):
>>>>   MIPS: BCM47XX: use common error codes in nvram reads
>>>>   MIPS: BCM47XX: return error when init of nvram failed
>>>>   MIPS: BCM47XX: nvram add nand flash support
>>>>   MIPS: BCM47XX: rename early_nvram_init to nvram_init
>>>>   MIPS: BCM47XX: handle different nvram sizes
>>>>   MIPS: BCM47XX: add bcm47xx prefix in front of nvram function names
>>>
>>> Hm, the only question? Why so late ;) I've spent 3 hours yesterday
>>> debugging nvram on my WNDR4500, it didn't fill SPROM of PCIe cards
>>> correctly. Will test your patches today.
>>
>> I waited till the bit in the flash part in bcma got into the mips tree.
>> Most of the patches in this series were already in my tree and OpenWrt
>> for some time.
>>
>> Does it work now? Your patch was the most important one. In this series
>> only the "handle different nvram sizes" could fix the problem with your
>> device.
> 
> I didn't have access to the hardware until now. It seems to be working
> now! I don't get invalid SPROM with rev 0 anymore.
> 
> The only message log that bothers me is:
> [    0.716000] bcma: bus1: invalid sprom read from the PCIe card, try
> to use fallback sprom
> [    0.812000] can not parse nvram name pci/1/1/mcsbw402gpo(null) with
> value 0x0x88800000 got -22

Nice, an other form of invalid syntax (0x0x88800000) in the nvram, lets
see what the vendors do next. ;-)
This particular issue should not be a problem neither b43 nor brcmsmac
is reading this value and all the other values should be read from nvram
correctly.

Hauke

> I didn't have time to track it yet.
> 
