Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Nov 2010 20:06:32 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41512 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491930Ab0KWTGZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 Nov 2010 20:06:25 +0100
Message-ID: <4CEC10AE.10305@openwrt.org>
Date:   Tue, 23 Nov 2010 20:06:22 +0100
From:   Felix Fietkau <nbd@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Arnaud Lacombe <lacombar@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kaloz@openwrt.org, "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@atheros.com>
Subject: Re: [PATCH 03/18] MIPS: add generic support for multiple machines
 within a single kernel
References: <1290524800-21419-1-git-send-email-juhosg@openwrt.org>        <1290524800-21419-4-git-send-email-juhosg@openwrt.org> <AANLkTikMwNqd507sPSTQOXt4KYkr9v61H=4_ESo7xFdj@mail.gmail.com> <4CEC0D1C.7090605@openwrt.org>
In-Reply-To: <4CEC0D1C.7090605@openwrt.org>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <nbd@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@openwrt.org
Precedence: bulk
X-list: linux-mips

On 2010-11-23 7:51 PM, Gabor Juhos wrote:
> Hi Arnaud,
> 
>> On Tue, Nov 23, 2010 at 10:06 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
>>> This patch adds a generic solution to support multiple machines based on
>>> a given SoC within a single kernel image. It is implemented already for
>>> several other architectures but MIPS has no generic support for that yet.
>>>
>> Is this the way `arch/mips' wants to go to support multiple machine
>> within a same kernel image ? 
> 
> I don't know yet what will be the chosen way.
> 
>> Flattened Device Tree is the other way to achieve that. I remind the latter
>> being proposed by Felix Fietkau on #openwrt.
> 
> FDT makes sense when the bootloader supports that. FDT makes sense when the
> bootloader supports that, but i'm not aware of any AR71xx/AR724x/AR913x based
> board which has such bootloader. Additionally, the device-tree support for MIPS
> has been added only recently and none of the existing MIPS boards are using that
> yet AFAIK. If that will be widely used we can consider to switch to that later.
We don't need boot loader support, we can make a simple loader stub that
passes the FDT data to the kernel. It would certainly be better than our
current cmdline hack ;)
I think using FDT would save us a lot of maintenance work, as we
wouldn't have to change the kernel for every single new board that we
add support for.

- Felix
