Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2018 19:20:45 +0200 (CEST)
Received: from mail-pf1-x444.google.com ([IPv6:2607:f8b0:4864:20::444]:39721
        "EHLO mail-pf1-x444.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992925AbeILRUlclzYH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2018 19:20:41 +0200
Received: by mail-pf1-x444.google.com with SMTP id j8-v6so1337707pff.6;
        Wed, 12 Sep 2018 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t/3fuSUWKlMErblXl+X17Nvw4ar4hBpSHTpi62zkTJY=;
        b=OxEVmGI0Pb8CALxWpFkge4zZ7GHrZwbYzHu0IWM+0DNsWmRHAtDaC0Yl09Eqcpp7Ve
         9zilym5F7qvFnyhoRoAzF9TShO0rjI2biwbmWoRD6kIhbMeAiUsq+pjmQIZldS6qbNOO
         UAYmriQhDJqjX5iZ2j7XnXJRM/wVHVhlAXIgnoaSF/2x44D5THC0ueEw9s2fsD6JumL9
         d0VSx8DfyD3ADnSbs6RZzv+gR2XXhdcndu1Qiwuhmvaogk8zYG6zhDbhVydI9RedFod0
         /xXUEXY5sX/SnI9CkcacrFi0l6aRyEqDRw3J1GF6ho1S/LXSmpRvJUpGhd+OYFOkDfqD
         NYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t/3fuSUWKlMErblXl+X17Nvw4ar4hBpSHTpi62zkTJY=;
        b=sTqdJtFe99VDf0oe3+sNMsYsr8+3+0yLiaJVQvSsD/B9sfEN/FIxgpFVUE8AhfNFLa
         LJy1SD06lPiUfXUHdTjmVcZgcs9bSFznmeWEArmUh0Rqk7wE+o8quHJO3hbC+MIDY+3U
         6uDQHmyua1UuE8pPl/fnBpfUluqK/rygdDGTUGgozn8KKfoYTXXD0i0p+G6MH9O88Xjo
         9a0cRtFhZrulITeeCT4CwGm9ghdl19NGGMowARZTrgNmeXtINeip57sQQKL6GD1u2O0n
         QOfLECwJDNjWcOpt85CRQIPhBvOp5wIgXPhz4dK1sJNif3uYkzh/6jC1htcveEq8HYDs
         uMsg==
X-Gm-Message-State: APzg51DuJ9uftaWseqXcVeW7VNJHuYnWc/ELvPlpVvESo9bCwmcCq5kn
        yAcLFtpwax1Y/E3UNHkd9Wc=
X-Google-Smtp-Source: ANB0VdbPvIuYD0tkjKLjL00OGm1lKgUocLveTOIu4WN4zD47e0beyEiNz5E8CMgx/Qfu4wpZ04e+IQ==
X-Received: by 2002:a65:4043:: with SMTP id h3-v6mr3375046pgp.207.1536772834709;
        Wed, 12 Sep 2018 10:20:34 -0700 (PDT)
Received: from [10.10.115.253] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id z17-v6sm3126668pfl.146.2018.09.12.10.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 10:20:33 -0700 (PDT)
Subject: Re: [PATCH v5 08/12] MIPS: BMIPS: add PCI bindings for 7425, 7435
To:     Jonas Gorski <jonas.gorski@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>
Cc:     paul.burton@mips.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>, nicolas.pitre@linaro.org,
        keescook@chromium.org, jinb.park7@gmail.com,
        vladimir.murzin@arm.com, alexandre.belloni@bootlin.com,
        palmer@sifive.com, stefan@agner.ch, eric@anholt.net,
        Simon Horman <horms+renesas@verge.net.au>, tony@atomide.com,
        stefan.wahren@i2se.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>, thellstrom@vmware.com,
        alexander.deucher@amd.com, dirk@hohndel.org,
        Thomas Gleixner <tglx@linutronix.de>, pombredanne@nexb.com,
        kstewart@linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>, justinpopo6@gmail.com,
        markus.mayer@broadcom.com, gpowell@broadcom.com, opendmb@gmail.com,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Christoph Hellwig <hch@lst.de>
References: <1536266581-7308-1-git-send-email-jim2101024@gmail.com>
 <1536266581-7308-9-git-send-email-jim2101024@gmail.com>
 <20180906214955.2yzyj6tkmflnnvdx@pburton-laptop>
 <CANCKTBumoy6mw2n+V7hN_T1SYxhq3JQMxgQUUSmOLuMX-Kv=zw@mail.gmail.com>
 <CAOiHx=khXs6x-EByPXRF=xEpL4eSiBfwxgJFV=3X8J5rXWNEMw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <28c70637-c727-db23-d1ef-6f86c8b8dc45@gmail.com>
Date:   Wed, 12 Sep 2018 10:20:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAOiHx=khXs6x-EByPXRF=xEpL4eSiBfwxgJFV=3X8J5rXWNEMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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



On 9/12/2018 7:36 AM, Jonas Gorski wrote:
> On 10 September 2018 at 16:37, Jim Quinlan <jim2101024@gmail.com> wrote:
>> On Thu, Sep 6, 2018 at 5:50 PM Paul Burton <paul.burton@mips.com> wrote:
>>>
>>> Hi Jim,
>>>
>>> On Thu, Sep 06, 2018 at 04:42:57PM -0400, Jim Quinlan wrote:
>>>> Adds the PCIe nodes for the Broadcom STB PCIe root complex.
>>>>
>>>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>>>> ---
>>>>   arch/mips/boot/dts/brcm/bcm7425.dtsi     | 28 ++++++++++++++++++++++++++++
>>>>   arch/mips/boot/dts/brcm/bcm7435.dtsi     | 28 ++++++++++++++++++++++++++++
>>>>   arch/mips/boot/dts/brcm/bcm97425svmb.dts |  4 ++++
>>>>   arch/mips/boot/dts/brcm/bcm97435svmb.dts |  4 ++++
>>>>   4 files changed, 64 insertions(+)
>>>
>>> Do you have a preference for how this gets merged? If it goes via the
>>> PCI tree then for patches 8 & 9:
>>>
>>>      Acked-by: Paul Burton <paul.burton@mips.com>
>>>
>> Hi Paul,
>>
>> I hope that the 12 commits  go together and will go through the PCI
>> tree.  I'm inclined to think I will have to do a V6, and in the cover
>> leter I will mention this request.
> 
> Somehow nothing of the v5 patch series seem to have made it to any
> mailing lists, at least I can't find them in my inbox (or spam) in any
> of the mailing lists, nor through the public archives of e.g. LKML.
> Patchwork (ozlabs and kernel) doesn't know of them either.

Indeed, that would explain why there has been little discussion on this....
-- 
Florian
