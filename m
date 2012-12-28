Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Dec 2012 01:00:29 +0100 (CET)
Received: from mail-we0-f176.google.com ([74.125.82.176]:63109 "EHLO
        mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822190Ab2L1AA2hIIOP convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Dec 2012 01:00:28 +0100
Received: by mail-we0-f176.google.com with SMTP id r5so4769787wey.35
        for <multiple recipients>; Thu, 27 Dec 2012 16:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=H++xTBx3SI2v3souMs0UiZYZ1hLotcpfr30TacvmcFg=;
        b=L8dpF9g+dcNr47zRfB1ppXab/b9ANIalXLgHNV+28xDNGqsM0Lrojmra4vWHJ+QCs5
         VI1vBGK9qLVsZVMiBqPTAZ2nN5BOXYa58/A5HNPLQ6wBmbHHQl2iOdERC3I7EHWXy2YJ
         5wpg1OsV9Ae4ixgMNhiYEy3e+keuo9uwYiW7NhMXSH7vgPFMtZNaHx4VqCZP1AtOKgWA
         kVE6AZTpW7ny/XdseA2CeONecWzLeM4qv3p2YJJRtYanHisfUipnqmUOw4wtoj3wblqO
         T1LYd8AQIf1sWH1Dl50lCAFRUu6P2Z19zIiCEgzc9pjQpfFOYJYJ4dS0gLjA6YenyE6A
         hdTA==
MIME-Version: 1.0
Received: by 10.194.88.98 with SMTP id bf2mr51287387wjb.49.1356652823008; Thu,
 27 Dec 2012 16:00:23 -0800 (PST)
Received: by 10.216.21.8 with HTTP; Thu, 27 Dec 2012 16:00:22 -0800 (PST)
In-Reply-To: <50DC4509.8090502@hauke-m.de>
References: <1356555074-1230-1-git-send-email-hauke@hauke-m.de>
        <CACna6rwqPtCb7GqXYQw5qL3_cUQ8xn6z_U5zCq0E0vZ0yhJXTA@mail.gmail.com>
        <50DC4509.8090502@hauke-m.de>
Date:   Fri, 28 Dec 2012 01:00:22 +0100
Message-ID: <CACna6rzAS0zwERF1kA=FXAsO7ROXb9qyEcLyQ7Uc7i=KBOrS+A@mail.gmail.com>
Subject: Re: [PATCH 0/6] MIPS: BCM47XX: nvram read enhancements
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 35341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

2012/12/27 Hauke Mehrtens <hauke@hauke-m.de>:
> On 12/27/2012 09:49 AM, Rafał Miłecki wrote:
>> 2012/12/26 Hauke Mehrtens <hauke@hauke-m.de>:
>>> Clean up the nvram reading code and add support for different nvram
>>> sizes.
>>>
>>> This depends on patch "MIPS: bcm47xx: separate functions finding flash
>>> window addr" by Rafał Miłeck, Patchwork:  https://patchwork.linux-mips.org/patch/4738/
>>>
>>> Hauke Mehrtens (6):
>>>   MIPS: BCM47XX: use common error codes in nvram reads
>>>   MIPS: BCM47XX: return error when init of nvram failed
>>>   MIPS: BCM47XX: nvram add nand flash support
>>>   MIPS: BCM47XX: rename early_nvram_init to nvram_init
>>>   MIPS: BCM47XX: handle different nvram sizes
>>>   MIPS: BCM47XX: add bcm47xx prefix in front of nvram function names
>>
>> Hm, the only question? Why so late ;) I've spent 3 hours yesterday
>> debugging nvram on my WNDR4500, it didn't fill SPROM of PCIe cards
>> correctly. Will test your patches today.
>
> I waited till the bit in the flash part in bcma got into the mips tree.
> Most of the patches in this series were already in my tree and OpenWrt
> for some time.
>
> Does it work now? Your patch was the most important one. In this series
> only the "handle different nvram sizes" could fix the problem with your
> device.

I didn't have access to the hardware until now. It seems to be working
now! I don't get invalid SPROM with rev 0 anymore.

The only message log that bothers me is:
[    0.716000] bcma: bus1: invalid sprom read from the PCIe card, try
to use fallback sprom
[    0.812000] can not parse nvram name pci/1/1/mcsbw402gpo(null) with
value 0x0x88800000 got -22
I didn't have time to track it yet.

-- 
Rafał
