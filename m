Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Jan 2011 20:35:42 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:49459 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492001Ab1ACTfj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Jan 2011 20:35:39 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 5AF0345C012;
        Mon,  3 Jan 2011 20:35:34 +0100 (CET)
Received: from [192.168.254.10] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 0371A1F0001;
        Mon,  3 Jan 2011 20:35:34 +0100 (CET)
Message-ID: <4D222503.1000700@openwrt.org>
Date:   Mon, 03 Jan 2011 20:35:31 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; hu-HU; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>,
        Kathy Giori <Kathy.Giori@atheros.com>
Subject: Re: [PATCH v4 01/16] MIPS: add initial support for the Atheros AR71XX/AR724X/AR931X
 SoCs
References: <1293994589-6794-1-git-send-email-juhosg@openwrt.org> <1293994589-6794-2-git-send-email-juhosg@openwrt.org> <201101022143.13712.florian@openwrt.org>
In-Reply-To: <201101022143.13712.florian@openwrt.org>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-VBMS: A16D4C31A5A | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Florian,

<...>

>> +
>> +static DEFINE_SPINLOCK(ath79_device_reset_lock);
>> +
>> +u32 ath79_cpu_freq;
>> +EXPORT_SYMBOL_GPL(ath79_cpu_freq);
>> +
>> +u32 ath79_ahb_freq;
>> +EXPORT_SYMBOL_GPL(ath79_ahb_freq);
>> +
>> +u32 ath79_ddr_freq;
>> +EXPORT_SYMBOL_GPL(ath79_ddr_freq);
> 
> Why not use the Clock API with fixed rates just like how it is done for AR7?

Can you tell me the advantage of that? We can't modify the rates of these
clocks, even we can't {en,dis}able them. Implementing the clock API would add an
unnecessary wrapper layer around the current implementation in my opinion.

Regards,
Gabor
