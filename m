Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2010 17:28:38 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:37819 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492227Ab0KOQ2c convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Nov 2010 17:28:32 +0100
Received: by gxk25 with SMTP id 25so3389433gxk.36
        for <multiple recipients>; Mon, 15 Nov 2010 08:28:26 -0800 (PST)
Received: by 10.42.167.9 with SMTP id q9mr2369955icy.76.1289838506140; Mon, 15
 Nov 2010 08:28:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.231.5.194 with HTTP; Mon, 15 Nov 2010 08:28:05 -0800 (PST)
In-Reply-To: <4CE0F8D1.8000704@openwrt.org>
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org>
 <1289598684-30624-12-git-send-email-juhosg@openwrt.org> <20101114082242.GA3137@angua.secretlab.ca>
 <4CE04EBC.4080701@openwrt.org> <20101115040456.GB19965@angua.secretlab.ca> <4CE0F8D1.8000704@openwrt.org>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Mon, 15 Nov 2010 09:28:05 -0700
X-Google-Sender-Auth: v7XhZ4mWHk7J19QmZ8hNKFf2JRc
Message-ID: <AANLkTiknq2Rdzp-xb-xTm5c_1QwBsq_vsS1N3iAL_Xn7@mail.gmail.com>
Subject: Re: [RFC 11/18] spi: add SPI controller driver for the Atheros
 AR71XX/AR724X/AR913X SoCs
To:     Gabor Juhos <juhosg@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@atheros.com>,
        David Brownell <dbrownell@users.sourceforge.net>,
        spi-devel-general@lists.sourceforge.net,
        Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Mon, Nov 15, 2010 at 2:09 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
> 2010.11.15. 5:04 keltezéssel, Grant Likely írta:
>> On Sun, Nov 14, 2010 at 10:03:56PM +0100, Gabor Juhos wrote:
>>>>> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
>>>>> +{
>>>>> +  return __raw_readl(sp->base + reg);
>>>>> +}
>>>>> +
>>>>> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg, u32 val)
>>>>> +{
>>>>> +  __raw_writel(val, sp->base + reg);
>>>>> +}
>>>>
>>>> This is suspect.  Why is __raw_{readl,writel} being used instead of
>>>> ioread32/iowrite32?  The __raw versions don't provide any kind of
>>>> ordering barriers.
>>>
>>> Mainly because the resulting code is smaller, and the performance is a bit
>>> better with the use of the __raw versions. The controller is embedded into the
>>> SoC and the registers are memory mapped, so i think it is safe to access them
>>> with __raw_{readl,writel}. However I can change it if that is the preferred method.
>>>
>>
>> Smaller, yes, because it doesn't have any io barriers; but is it safe?
>> Do you know whether or not the CPU will reorder the instructions on
>> you?  Being embedded into the SoC doesn't really mean anything in this
>> regard.  Unless you really understand all the behaviour of the CPU and
>> bus, then the safe versions must be used.
>>
>> If you *do* really understand all the behaviour and decide it is safe
>> to use the __raw versions, then the driver needs to be well documented
>> as to the reasons why the __raw versions are safe to use.
>
> These SoCs are using the MIPS 24K core. This core is based on an in-order
> architecture, so it is safe to use the __raw versions from the CPU's side.
>
> To be honest, I have no informations about that the completion of the request is
> always in order that the request are received on the AHB bus between the CPU and
> the SPI controller. However the Atheros' reference code uses the __raw versions
> everywhere to access the registers of the built-in devices, so I assume that no
> out-of-order completion is allowed on that bus.

Ralf, what say you?  I personally don't like this, and it makes for a
bad example of driver code, but I'll accept it if you say that it is
the right thing to do for MIPS device drivers.  (Although I retain my
requirement that the use of __raw accessors needs to be well
documented).

g.
