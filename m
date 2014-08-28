Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 14:38:01 +0200 (CEST)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:63802 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007191AbaH1MiAZgLB- convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Aug 2014 14:38:00 +0200
Received: by mail-ig0-f178.google.com with SMTP id hn18so802049igb.11
        for <linux-mips@linux-mips.org>; Thu, 28 Aug 2014 05:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=F1ZQYGQcuCy6QazQ2HevZOBPdZWvsVK5ar7FSOob5Oc=;
        b=VPsZK4t5ryvxWmTnYnfiZXmRmUUKnCLhy6jj4grFQQQ3U5MGZspbg2IcjIo9aXYd4R
         ZCHOdOliVPb1u+otY1DsfX3VFpKhkTOzc++QREtEt0L3i0OxcQUkkzHIRUiGUtKLQyVc
         do3zbqpKPhyDcB4JRcXlwm/yM/OWpMcO/PMejGLjPa+P1vVFVajY24vDI8WMY/aMXf0C
         BdlAvo8hMJAyId6TUX96bcD2TgpFUuTBMMiZ5BOMRdS7uUvVQ8Vfg+XXsu447tN8VNgA
         eq6DZbaVORQsDojI98fNp8p4vQcfYZXzuePT40SXI+B10cIqJDj5gZJrOmEAKsJmPJu3
         /q0Q==
MIME-Version: 1.0
X-Received: by 10.42.212.146 with SMTP id gs18mr536244icb.96.1409229474494;
 Thu, 28 Aug 2014 05:37:54 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Thu, 28 Aug 2014 05:37:54 -0700 (PDT)
In-Reply-To: <2859425.94ptgpItD3@wuerfel>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
        <3921668.sgOLRYjGUr@wuerfel>
        <CACna6rwnz0TGZ8QgW39o4MPfXTp1a1h8naDJqEGVV4UqtkgaWw@mail.gmail.com>
        <2859425.94ptgpItD3@wuerfel>
Date:   Thu, 28 Aug 2014 14:37:54 +0200
Message-ID: <CACna6rx0E_s76wLLkDjj90sXH=Q3yzBemQM5Qrp96QiWCWr0qg@mail.gmail.com>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42308
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

On 28 August 2014 13:56, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 August 2014 13:39:55 Rafał Miłecki wrote:
>> On 28 August 2014 13:02, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Thursday 28 August 2014 12:47:29 Rafał Miłecki wrote:
>> >> On 28 August 2014 12:13, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> > My impression is that all the information that you need in these early
>> >> > three steps is stuff that is already meant to be part of DT.
>> >> > This isn't surprising, because the bcm47xx serves a similar purpose
>> >> > to DT, it's just more specialized.
>> >> >
>> >> > This duplication is a bit unfortunate, but it seems that just using
>> >> > the respective information from DT would be easier here.
>> >> >
>> >> > Is any of the information you need early dynamic? It sounds that
>> >> > for a given SoC, it should never change and can just be statically
>> >> > encoded in DT.
>> >>
>> >> I'm not sure which info you exactly are talking about. I believe one
>> >> SoC model always use the same CPU, ChipCommon, embedded wireless and
>> >> PCIe + USB controllers. However amount of RAM, type of flash (serial
>> >> vs. NAND), size of flash, booting method, NVRAM location, etc. all
>> >> depend on vendor's choice. I think CPU speed could also depend on
>> >> vendor choice.
>> >
>> > But those would also be present in DT on ARM, right?
>>
>> Well, that depends. Hauke was planning to put info about flash in DT.
>> Me on the other hand suggested reading info about flash from the
>> board. See my reply:
>> https://www.mail-archive.com/devicetree@vger.kernel.org/msg39365.html
>>
>> My plan was to use patch like
>> [PATCH] bcma: get & store info about flash type SoC booted from
>> http://www.spinics.net/lists/linux-wireless/msg126163.html
>> (it would work on both: MIPS and ARM)
>> and then:
>>
>> switch (boot_device) {
>> case BCMA_BOOT_DEV_NAND:
>>     nvram_address = 0x1000dead;
>>     break;
>> case BCMA_BOOT_DEV_SERIAL:
>>     nvram_address = 0x1000c0de;
>>     break;
>> }
>>
>
> I don't understand. Why does the nvram address depend on the boot
> device?

NVRAM is basically just a partition on flash, however there are few
tricks applying to it.

To make booting possible, flash content is mapped to the memory. We're
talking about read only access. This mapping allows CPU to get code
(bootloader) and execute it as well as it allows CFE to get NVRAM
content easily. You don't need flash driver (with erasing & writing
support) to read NVRAM.
Depending on the boot flash device, content of flash is mapped at
different offsets:
1) MIPS serial flash: SI_FLASH2 (0x1c000000)
2) MIPS NAND flash: SI_FLASH1 (0x1fc00000)
3) ARM serial flash: SI_NS_NORFLASH (0x1e000000)
4) ARM NAND flash: SI_NS_NANDFLASH (0x1c000000)

So on my ARM device with serial flash (connected over SPI) I was able
to get NVRAM header this way:

void __iomem *iobase = ioremap_nocache(0x1e000000, 0x1000000);
u8 *buf;

buf = (u8 *)(iobase + 0xff0000);
pr_info("[NVRAM] %02X %02X %02X %02X\n", buf[0], buf[1], buf[2], buf[3]);

This resulted in:
[NVRAM] 46 4C 53 48

(I hardcoded 0xff0000 above, normally you would need to try 0x10000,
0x20000, 0x30000 and so on...).
