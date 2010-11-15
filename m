Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2010 10:09:50 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:36351 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491955Ab0KOJJr convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Nov 2010 10:09:47 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 2C0FC45C030;
        Mon, 15 Nov 2010 10:09:40 +0100 (CET)
Received: from [192.168.254.10] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id BCF57370001;
        Mon, 15 Nov 2010 10:09:39 +0100 (CET)
Message-ID: <4CE0F8D1.8000704@openwrt.org>
Date:   Mon, 15 Nov 2010 10:09:37 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; hu-HU; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        David Brownell <dbrownell@users.sourceforge.net>,
        spi-devel-general@lists.sourceforge.net,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [RFC 11/18] spi: add SPI controller driver for the Atheros AR71XX/AR724X/AR913X
 SoCs
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org> <1289598684-30624-12-git-send-email-juhosg@openwrt.org> <20101114082242.GA3137@angua.secretlab.ca> <4CE04EBC.4080701@openwrt.org> <20101115040456.GB19965@angua.secretlab.ca>
In-Reply-To: <20101115040456.GB19965@angua.secretlab.ca>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-VBMS: A1577CF2F7C | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

2010.11.15. 5:04 keltezéssel, Grant Likely írta:
> On Sun, Nov 14, 2010 at 10:03:56PM +0100, Gabor Juhos wrote:
>>>> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
>>>> +{
>>>> +	return __raw_readl(sp->base + reg);
>>>> +}
>>>> +
>>>> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg, u32 val)
>>>> +{
>>>> +	__raw_writel(val, sp->base + reg);
>>>> +}
>>>
>>> This is suspect.  Why is __raw_{readl,writel} being used instead of
>>> ioread32/iowrite32?  The __raw versions don't provide any kind of
>>> ordering barriers.
>>
>> Mainly because the resulting code is smaller, and the performance is a bit
>> better with the use of the __raw versions. The controller is embedded into the
>> SoC and the registers are memory mapped, so i think it is safe to access them
>> with __raw_{readl,writel}. However I can change it if that is the preferred method.
>>
> 
> Smaller, yes, because it doesn't have any io barriers; but is it safe?
> Do you know whether or not the CPU will reorder the instructions on
> you?  Being embedded into the SoC doesn't really mean anything in this
> regard.  Unless you really understand all the behaviour of the CPU and
> bus, then the safe versions must be used.
> 
> If you *do* really understand all the behaviour and decide it is safe
> to use the __raw versions, then the driver needs to be well documented
> as to the reasons why the __raw versions are safe to use.

These SoCs are using the MIPS 24K core. This core is based on an in-order
architecture, so it is safe to use the __raw versions from the CPU's side.

To be honest, I have no informations about that the completion of the request is
always in order that the request are received on the AHB bus between the CPU and
the SPI controller. However the Atheros' reference code uses the __raw versions
everywhere to access the registers of the built-in devices, so I assume that no
out-of-order completion is allowed on that bus.

Regards,
Gabor
