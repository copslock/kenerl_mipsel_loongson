Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 14:23:35 +0200 (CEST)
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36403 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991859AbcHLMX3KPyHD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 14:23:29 +0200
Received: by mail-ua0-f193.google.com with SMTP id 74so1907094uau.3;
        Fri, 12 Aug 2016 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yi2napnl6UWGgcIlDbW08f8HCt2G/CUkEVydkpybq8k=;
        b=n2bdFhVJn5xhawSQOH1AsUzvVvdxacZI4ea2Bykx/vWBt3VvNCpP1QTu6vr+8/03ln
         iT7/1r5TP3fFTtF+bxAX53D5jt0HIFNU93X/mAMjGGy0vQVL1LRe9gMimfRV8HFV7huN
         t4wobdH86gMxrE6o4QgKSuDJRlIT3Kqxvbbc8qf/9BFXt+NamcjU9rvVmlphncritFN3
         S8JMSiBHgJjgenYtu9Z7qh/FeQZJnViWiOlU41788htj7JB0SytM8ry4PFz9PaHGYaa6
         1WZTlWUjpS8nkPMPqZmLqQ5fRCX9SKkPBM1iYc8vhx96mTZF002HLHN2AvFtOIYIugZe
         7ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yi2napnl6UWGgcIlDbW08f8HCt2G/CUkEVydkpybq8k=;
        b=HCKipXmjlLfZqZGAo/i2Rngd3nfgyRTO7YVgQUW+dh2cRF2aNiB0+9o3z7BtYbLejK
         DsatoskSWzoZTNlsgdzbkrSPJJGfwjhHn2kzFWIsrGafvtL/6gmPzIxl6SwzZwRmSAon
         4COvMNBr1M7H5sAh5iLPFlq/NWrCVUTs3fFWSJuAvx/bYrhkWXLWSLwFlj8UfSiuhuPe
         IB5/5cWiPr3Yzh8nJqn1QmA7CaVnco9ZX91TMwv/z5meBfIXscE3PtDRZKtsw1OrE23U
         GG67SpuJrhiBP1LN1OHhFcCAqVjbghNmiiJIew03nzdDPf+bA4g26cXfvBrrvRAjQ/91
         kmOg==
X-Gm-Message-State: AEkoouti2S9x8/Dl80Nol/mV4/O2tQo1Qu/jaCZqEcBlXuimcmU7K0ISBsAr318v+5K18tGOf6agjFwarBfXpw==
X-Received: by 10.31.248.9 with SMTP id w9mr905822vkh.64.1471004603251; Fri,
 12 Aug 2016 05:23:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.129 with HTTP; Fri, 12 Aug 2016 05:23:02 -0700 (PDT)
In-Reply-To: <293A0898-C1DE-4275-9293-5BE29FC61018@gmail.com>
References: <20160812085231.53290-1-jaedon.shin@gmail.com> <CAOiHx=ke2CC9tm6Rn01A5UAGRscb1QJGWq-som74r5UO5_g9EA@mail.gmail.com>
 <293A0898-C1DE-4275-9293-5BE29FC61018@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Fri, 12 Aug 2016 14:23:02 +0200
Message-ID: <CAOiHx=m7_3xwfQRJJJHencjqd38He+wOU1aVkgTf1j7ucDtubg@mail.gmail.com>
Subject: Re: [v3 0/5] Add device nodes for BCM7xxx SoCs
To:     Jaedon Shin <jaedon.shin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54508
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Hi,

On 12 August 2016 at 14:19, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Hi Jonas,
>
> On Aug 12, 2016, at 7:51 PM, Jonas Gorski <jonas.gorski@gmail.com> wrote:
>>
>> Hi,
>>
>> On 12 August 2016 at 10:52, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>>> This patch series adds support for Broadcom BCM7xxx MIPS based SoCs.
>>>
>>> The NAND device nodes have common file including chip select, BCH
>>> and partitions for the reference board with the same properties.
>>>
>>> Changes in v3:
>>> - Fixed incorrect interrupt number in aon_pm_l2_intc.
>>>
>>> Changes in v2:
>>> - Removed status properties in always enabled GPIO nodes.
>>> - Removed NAND nodes for v3.3 brcmnand controller.
>>> - Renamed interrupt-controller instead of lable string.
>>> - Renamed bcm97xxx-nand-cs1-bch8.dtsi
>>>
>>> Jaedon Shin (5):
>>>  MIPS: BMIPS: Add support PWM device nodes
>>>  MIPS: BMIPS: Add support GPIO device nodes
>>>  MIPS: BMIPS: Add support SDHCI device nodes
>>>  MIPS: BMIPS: Add support NAND device nodes
>>>  MIPS: BMIPS: Use interrupt-controller node name
>>
>> Please directly add the interrupt controller names with the correct
>> name instead of fixing them up later.
>>
>> Also please CC devicetree@vger for device tree related patches.
>>
>>
>> Regards
>> Jonas
>
> The last commit "MIPS: BMIPS: Use interrupt-controller node name" has
> on all changes about interrupt-controller@ not only your comments.
> I think it is needed for consistency and historicity.

That's fine if you want to fix up other wrong usages, but don't
introduce them first just to modify them later in the same patch set.
So please update your patches to add the nodes with the right names
right away.


Jonas
