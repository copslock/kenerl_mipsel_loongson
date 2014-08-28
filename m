Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2014 18:03:49 +0200 (CEST)
Received: from mail-ig0-f176.google.com ([209.85.213.176]:39578 "EHLO
        mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007231AbaH1QDo1jC10 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Aug 2014 18:03:44 +0200
Received: by mail-ig0-f176.google.com with SMTP id hn18so8263450igb.3
        for <linux-mips@linux-mips.org>; Thu, 28 Aug 2014 09:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UxIKyVbv4vs1ThA2JEZMWSvlKbo6moa8ffGBy4DaZkE=;
        b=gtZpZAWPB6Y5cuCJf4QJHqU/mD5HCzuDwu4FB4LtIPuV31BwsZQOQl7XFS7yzm7/0F
         GUYKfqyxtXTELrMvCKhT9Ea5TfZd6VutuCjd5w5tiwuXYGZyx7ykSeXZlNLSLWy4uNe6
         A8TlgvbI5WMjY7jByvjwQ0hTbLoqq12BtqsQCpbG+e4uVMxSbKpJf6QsK+SZjKWqq0ej
         k3Q53i77ZJxfs6lixM0DzymskseqFaH7Bq3Y+nimrAoTbLbGup9AJDxjO1njJpW/czdV
         z0MoimpU//m73YawqbnQ6VMUDudBjbyrJyCFaHhlen58rsL0czIU4wJuBP6cL4CL16BI
         H4Xg==
MIME-Version: 1.0
X-Received: by 10.50.176.202 with SMTP id ck10mr39498608igc.2.1409241818481;
 Thu, 28 Aug 2014 09:03:38 -0700 (PDT)
Received: by 10.107.130.160 with HTTP; Thu, 28 Aug 2014 09:03:38 -0700 (PDT)
In-Reply-To: <CACna6rwKheOAogaeeDd5pLNaRo=Zq0euURTT87BY-S1MdOWwVQ@mail.gmail.com>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
        <2859425.94ptgpItD3@wuerfel>
        <CACna6rx0E_s76wLLkDjj90sXH=Q3yzBemQM5Qrp96QiWCWr0qg@mail.gmail.com>
        <6633831.1CSHMPPLH1@wuerfel>
        <CACna6rwKheOAogaeeDd5pLNaRo=Zq0euURTT87BY-S1MdOWwVQ@mail.gmail.com>
Date:   Thu, 28 Aug 2014 18:03:38 +0200
Message-ID: <CACna6ryEp0oFXy0ZOEU0yve8r74qg7cC1GDdFSbarr2qjz5-YA@mail.gmail.com>
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
X-archive-position: 42313
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

On 28 August 2014 18:00, Rafał Miłecki <zajec5@gmail.com> wrote:
> On 28 August 2014 17:32, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Thursday 28 August 2014 14:37:54 Rafał Miłecki wrote:
>>> To make booting possible, flash content is mapped to the memory. We're
>>> talking about read only access. This mapping allows CPU to get code
>>> (bootloader) and execute it as well as it allows CFE to get NVRAM
>>> content easily. You don't need flash driver (with erasing & writing
>>> support) to read NVRAM.
>>
>> Ok. Just out of curiosity, how does the system manage to map NAND
>> flash into physical address space? Is this a feature of the SoC
>> of the flash chip?
>
> I don't know exactly. Many (all?) device with BCM4706 SoC have two
> flashes. Serial flash (~2 MiB) with bootloader + nvram and NAND flash
> with the firmware. However Netgear WNR3500Lv2 (based on BCM47186B0)
> has only a NAND flash.

Btw. since NAND flashes tend to be huhe, they can't be fully mapped
into memory. This is where Broadcom's "nfl_boot_size" comes in. This
is a function saying how much of NAND content it mapped into memory.
It returns NFL_BOOT_SIZE (0x200000) or NFL_BIG_BOOT_SIZE (0x800000)
depending on the block size.
