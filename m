Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 19:51:29 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:33880 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491930Ab0KWSvW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Nov 2010 19:51:22 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 1AAAD4DC00E;
        Tue, 23 Nov 2010 19:51:13 +0100 (CET)
Received: from [192.168.254.10] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id B89791F0001;
        Tue, 23 Nov 2010 19:51:12 +0100 (CET)
Message-ID: <4CEC0D1C.7090605@openwrt.org>
Date:   Tue, 23 Nov 2010 19:51:08 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; hu-HU; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Arnaud Lacombe <lacombar@gmail.com>
CC:     Felix Fietkau <nbd@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>
Subject: Re: [PATCH 03/18] MIPS: add generic support for multiple machines
 within a single kernel
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>        <1290524800-21419-4-git-send-email-juhosg@openwrt.org> <AANLkTikMwNqd507sPSTQOXt4KYkr9v61H=4_ESo7xFdj@mail.gmail.com>
In-Reply-To: <AANLkTikMwNqd507sPSTQOXt4KYkr9v61H=4_ESo7xFdj@mail.gmail.com>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-VBMS: A109C0E330A | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Arnaud,

> On Tue, Nov 23, 2010 at 10:06 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
>> This patch adds a generic solution to support multiple machines based on
>> a given SoC within a single kernel image. It is implemented already for
>> several other architectures but MIPS has no generic support for that yet.
>>
> Is this the way `arch/mips' wants to go to support multiple machine
> within a same kernel image ? 

I don't know yet what will be the chosen way.

> Flattened Device Tree is the other way to achieve that. I remind the latter
> being proposed by Felix Fietkau on #openwrt.

FDT makes sense when the bootloader supports that. FDT makes sense when the
bootloader supports that, but i'm not aware of any AR71xx/AR724x/AR913x based
board which has such bootloader. Additionally, the device-tree support for MIPS
has been added only recently and none of the existing MIPS boards are using that
yet AFAIK. If that will be widely used we can consider to switch to that later.

Regards,
Gabor
