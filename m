Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2012 16:06:09 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:43473 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903558Ab2EKOGE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 May 2012 16:06:04 +0200
Message-ID: <4FAD1C6D.5080701@openwrt.org>
Date:   Fri, 11 May 2012 16:04:29 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 12/14] MTD: MIPS: lantiq: implement OF support
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org>       <1336133919-26525-12-git-send-email-blogic@openwrt.org> <1336745193.2625.81.camel@sauron.fi.intel.com>
In-Reply-To: <1336745193.2625.81.camel@sauron.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 33259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/05/12 16:06, Artem Bityutskiy wrote:
> On Fri, 2012-05-04 at 14:18 +0200, John Crispin wrote:
>> Adds bindings for OF and make use of module_platform_driver for lantiq
>> based socs.
>>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
>> Cc: linux-mtd@lists.infradead.org
>> ---
>> This patch is part of a series moving the mips/lantiq target to OF and clkdev
>> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.
> Looks ok, but could you please send me the entire series anyway, may be
> privately. I want to feed it to aiaiai and check before acking this
> patch. Also, please, make sure you add dependency on OF in Kconfig.

Hi Artem,

The lantiq platform selects USE_OF

config USE_OF
        bool "Flattened Device Tree support"
        select OF
        select OF_EARLY_FLATTREE
        select IRQ_DOMAIN
        help
          Include support for flattened device tree machine descriptions.

Do i still need an explicit dependency on OF in this case ?

Thanks,
John
