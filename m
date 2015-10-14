Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 20:22:25 +0200 (CEST)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34665 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009569AbbJNSWX3X0F0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Oct 2015 20:22:23 +0200
Received: by wicgb1 with SMTP id gb1so141041786wic.1
        for <linux-mips@linux-mips.org>; Wed, 14 Oct 2015 11:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3pBFqGZOIoEa9BXhEhbvHuY883MFTWVcDgm0pjVibyo=;
        b=MlXnQ/oFKDAY4OGQhQUhRlPr/kt1HRyGRzNt6HOpaotA9sXE6v1HsbCfoSMfOFamQA
         fwTWORzXCh2nDOhIjKNmyOPdsRZOUjwjoAKHiBe4rHc5CiJbTrLSXDf6Z4BkxbsqNgwh
         Ubi6BNiVrYcTR08OaepTvNDpC8Ke4uhBZCpkuLRUnFuWX9KwXRz6lb1ST9Xq6LCYhyRK
         uR9y1x68FrAMwcnxlntiuWXdYMP+EO6H844YBRg7Em8fGenpZ+PFFERcmmeU1lFyxKF7
         6lE74ZZbfs55sEoh1mlM5lBi8rhteEWqFTQMHpUqnV2/CXOCHOD1BGS2Wc/4xaQxTIuN
         O3PQ==
X-Gm-Message-State: ALoCoQkOsEBA1ezyjEA6aKue7NG5RM0aTGc3/Jr51LZyZNpbw5e2Z8R2IxifIl+s0h39LrV5IHQ8
MIME-Version: 1.0
X-Received: by 10.180.86.39 with SMTP id m7mr30484170wiz.91.1444846936792;
 Wed, 14 Oct 2015 11:22:16 -0700 (PDT)
Received: by 10.28.50.194 with HTTP; Wed, 14 Oct 2015 11:22:16 -0700 (PDT)
In-Reply-To: <20151014173350.GV15287@xsjsorenbubuntu>
References: <1444827117-10939-1-git-send-email-Zubair.Kakakhel@imgtec.com>
        <1444827117-10939-3-git-send-email-Zubair.Kakakhel@imgtec.com>
        <20151014151813.GL15287@xsjsorenbubuntu>
        <561E7B65.3090704@metafoo.de>
        <20151014165450.GS15287@xsjsorenbubuntu>
        <561E8FDF.9070500@metafoo.de>
        <20151014173350.GV15287@xsjsorenbubuntu>
Date:   Wed, 14 Oct 2015 11:22:16 -0700
Message-ID: <CAAtXAHcfFcoh4=UFn9R4UJdUyPiJ9mMqpBg09jkfiOUynH58yw@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpio/xilinx: enable for MIPS
From:   Moritz Fischer <moritz.fischer@ettus.com>
To:     =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        ralf@linux-mips.org, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <moritz.fischer@ettus.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: moritz.fischer@ettus.com
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

On Wed, Oct 14, 2015 at 10:33 AM, Sören Brinkmann
<soren.brinkmann@xilinx.com> wrote:
> On Wed, 2015-10-14 at 07:24PM +0200, Lars-Peter Clausen wrote:
>> On 10/14/2015 06:54 PM, Sören Brinkmann wrote:
>> > On Wed, 2015-10-14 at 05:57PM +0200, Lars-Peter Clausen wrote:
>> >> On 10/14/2015 05:18 PM, Sören Brinkmann wrote:
>> >>> On Wed, 2015-10-14 at 01:51PM +0100, Zubair Lutfullah Kakakhel wrote:
>> >>>> MIPSfpga uses the axi gpio controller. Enable the driver for MIPS.
>> >>>>
>> >>>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>> >>>> ---
>> >>>>  drivers/gpio/Kconfig | 2 +-
>> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>>>
>> >>>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> >>>> index 8949b3f..58e9afd 100644
>> >>>> --- a/drivers/gpio/Kconfig
>> >>>> +++ b/drivers/gpio/Kconfig
>> >>>> @@ -508,7 +508,7 @@ config GPIO_XGENE_SB
>> >>>>
>> >>>>  config GPIO_XILINX
>> >>>>          tristate "Xilinx GPIO support"
>> >>>> -        depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86)
>> >>>> +        depends on OF_GPIO && (PPC || MICROBLAZE || ARCH_ZYNQ || X86 || MIPS)
>> >>>
>> >>> Hmm, in general, this driver is hopefully generic enough that it doesn't
>> >>> have any real architecture dependencies. And I suspect, we want to
>> >>> enable this driver for ARM64 for ZynqMP soon too. Should we probably
>> >>> drop these arch dependencies completely? It seems to become quite a long list.
>> >>
>> >> I've been thinking about this a while ago. This is certainly not the only
>> >> driver affected by this problem. But the thing is people always complain if
>> >> new symbols become visable in Kconfig that don't apply to their platform.
>> >>
>> >> Maybe we should introduce a HAS_REPROGRAMABLE_LOGIC (or similar) feature
>> >> Kconfig symbol and let platforms which have a FPGA select it and let drivers
>> >> for FPGA peripherals depend on it.
>> >
>> > Sounds like a good idea to me. But, does that work for all use-cases.
>> > E.g. if you plug some PCIe card with an FPGA into an x86(_64) machine.
>> > That would allow you to use those drivers, but I'm not sure how that
>> > could pull in the new config symbol.
>>
>> Hm, right. We could also make it a user-selectable config symbol. In that
>> case you only need to disable one symbol when you don't have FPGA support
>> rather than one for each driver. Although I'm not quite sure where to put
>> such a symbol.
>
> Eventually, the FPGA manager subsystem could probably provide some high
> level config symbols. Though, it is probably also not given that every
> FPGA-enabled platform needs the FPGA manager.

I agree. I suspect most platforms will not actually runtime reload the
FPGA using
FPGA manager they probably use onboard flash or something similar.

>
>         Sören
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Moritz
