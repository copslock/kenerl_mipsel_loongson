Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Mar 2018 18:16:15 +0100 (CET)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:39089
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994554AbeCLRQI0givB convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Mar 2018 18:16:08 +0100
Received: by mail-ot0-x244.google.com with SMTP id h8so16036183oti.6
        for <linux-mips@linux-mips.org>; Mon, 12 Mar 2018 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UoAIS7IgUCAJbCoOtGNemHGR3c9u6eFB3dTe2tdOgMc=;
        b=L5zO7QFVsjxdWpoeIOVUYFcRQ0aJA8WXh19VN6ixblZFITrxZFaOOCbszyw62eZFW2
         mmxzzOVXOehCQxYE3ecPNCp7EDF6/NTQRLMenmQXFK7zXLrPh0WEs/7PrhqmfDosRN8W
         b7LXUqerLeNvLg8nkl95XIr77Xhbqs8ZTeDEP5T/Jaapy3AI4AvEO+t04O5DHfzQeDDi
         w/ycn/HUpKGwOdEDrMv4O67FT6p/wOxKLmvSV2q5fYSC5jeN/+5vDQhd71YyOSCrTSGj
         kHaERnIuF9Is9O5bOBT/6EE6nK6bTQZIBDpT6tppWb9E24vGp3aw74pHfYitc7qZmXfS
         k0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UoAIS7IgUCAJbCoOtGNemHGR3c9u6eFB3dTe2tdOgMc=;
        b=tC0dZ3Lr1TFysYtCE+fwsVcq6zw3cNRN0696TTJQIf5rQPEXYISAlCt2sDkE4aqxuu
         1OVdj99syHqbPl7v0pk9hm1Mbep49nV6fpGMG+yf6CQfZ6vkQLONr9ifrAZGaOc0A7HZ
         zGP/tCQxBa/Mk5aUvOc48YOREjhV7cjv2vu3lKmNe7vArN7yMVcex9wnHp83BzvyWKPC
         d4qFxni1PGi8YigElcPUwsiJMBL7c0WSTdeLQWTCHV9p2/r/AW676/1DvsuFYPXnJNCo
         p/EuxzYtCZfOmMPgi+HUV6nddD1YdzTBkGA3+F6QMbGDxotVtGfTrSV73DU9lHbV8sre
         gfAw==
X-Gm-Message-State: AElRT7EX2uJUm16XCvGkjn8ZRuUAziGEBzibB6D59Iu4EiOWXQGuM8/6
        WZ68/G+vg4YS4GBf8LGaabui5+Yy04SJ+J0GLv4=
X-Google-Smtp-Source: AG47ELuFbH3ZeQnbP7RgAQOxm9uQq7UxjXhmnIB9x68lEJXd1UaMa81C2nyV5SqJbYp9OuoTlVfc+Js7SKlYLRfwzQY=
X-Received: by 10.157.64.181 with SMTP id n50mr6126378ote.241.1520874958010;
 Mon, 12 Mar 2018 10:15:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.20.79 with HTTP; Mon, 12 Mar 2018 10:15:37 -0700 (PDT)
In-Reply-To: <CAAEAJfDmQBShUVXupVMdcPSiu5t2i7VdF_1LM9Syu_Qiq6PsKg@mail.gmail.com>
References: <20180309151219.18723-1-ezequiel@vanguardiasur.com.ar>
 <CA+7wUsxuavjaVOpoOEVJp4gSd+J_FQ37JuRE_N2BhEqOx7G1yA@mail.gmail.com> <CAAEAJfDmQBShUVXupVMdcPSiu5t2i7VdF_1LM9Syu_Qiq6PsKg@mail.gmail.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 12 Mar 2018 18:15:37 +0100
X-Google-Sender-Auth: QrlJv5kh1nzqZ4MkIV9EAsyc_7M
Message-ID: <CA+7wUsy2vNgwwo_rXwKbHhzXrSOc_7rRJzcx=gFBvGX0Cn92nA@mail.gmail.com>
Subject: Re: [PATCH 00/14] Enable SD/MMC on JZ4780 SoCs
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <mathieu.malaterre@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: malat@debian.org
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

On Sat, Mar 10, 2018 at 11:17 PM, Ezequiel Garcia
<ezequiel@vanguardiasur.com.ar> wrote:
> Hi Mathieu,
>
> On 10 March 2018 at 14:02, Mathieu Malaterre <malat@debian.org> wrote:
>> On Fri, Mar 9, 2018 at 4:12 PM, Ezequiel Garcia
>> <ezequiel@vanguardiasur.com.ar> wrote:
>>> This patchset adds support for SD/MMC on JZ4780 based
>>> platforms, such as the MIPS Creator CI20 board.
>>>
>>> Most of the work has been done by Alex, Paul and Zubair,
>>> while I've only prepared the upstream submission, cleaned
>>> some patches, and written some commit logs where needed.
>>>
>>> All praises should go to them, all rants to me.
>>>
>>> The series is based on v4.16-rc4.
>>>
>>> Alex Smith (3):
>>>   mmc: jz4740: Set clock rate to mmc->f_max rather than JZ_MMC_CLK_RATE
>>>   mmc: jz4740: Add support for the JZ4780
>>>   mmc: jz4740: Fix race condition in IRQ mask update
>>>
>>> Ezequiel Garcia (9):
>>>   mmc: jz4780: Order headers alphabetically
>>>   mmc: jz4740: Use dev_get_platdata
>>>   mmc: jz4740: Introduce devicetree probe
>>>   mmc: dt-bindings: add MMC support to JZ4740 SoC
>>>   mmc: jz4740: Use dma_request_chan()
>>>   MIPS: dts: jz4780: Add DMA controller node to the devicetree
>>>   MIPS: dts: jz4780: Add MMC controller node to the devicetree
>>>   MIPS: dts: ci20: Enable DMA and MMC in the devicetree
>>>   MIPS: configs: ci20: Enable DMA and MMC support
>>>
>>> Paul Cercueil (1):
>>>   mmc: jz4740: Fix error exit path in driver's probe
>>>
>>> Zubair Lutfullah Kakakhel (1):
>>>   mmc: jz4740: Reset the device requesting the interrupt
>>
>> Nice work. Entire series works just fine on my MIPS Creator CI20 (v1).
>>
>
> Cool. This means a Tested-by for the entire series?

Right, that was not clear, so:

Tested-by: Mathieu Malaterre <malat@debian.org>

for the entire series. thanks !

>> Nitpick: could you update the email addresses:
>>
>> s/imgtec/mips/
>>
>
> You sure that is appropriate? First of all, the work has done
> under Imagination Technologies umbrella (even if now the
> developers work for MIPS).
>
> And second, I'd feel better if such request would come
> from the authors, or at least acked by them.

I did not realize Alex was a special case. So please discard, no need
to update Alex email.

> Thanks for testing!
> --
> Ezequiel García, VanguardiaSur
> www.vanguardiasur.com.ar
