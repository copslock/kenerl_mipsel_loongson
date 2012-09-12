Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2012 20:03:31 +0200 (CEST)
Received: from bear.ext.ti.com ([192.94.94.41]:51376 "EHLO bear.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903340Ab2ILSDU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Sep 2012 20:03:20 +0200
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
        by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q8CI2Zvf021542;
        Wed, 12 Sep 2012 13:02:35 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
        by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q8CI2ZS9023276;
        Wed, 12 Sep 2012 13:02:35 -0500
Received: from dlelxv22.itg.ti.com (172.17.1.197) by dfle73.ent.ti.com
 (128.247.5.110) with Microsoft SMTP Server id 14.1.323.3; Wed, 12 Sep 2012
 13:02:35 -0500
Received: from [158.218.103.130] (gtla0875269.am.dhcp.ti.com
 [158.218.103.130])     by dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id
 q8CI2RDL032273;        Wed, 12 Sep 2012 13:02:28 -0500
Message-ID: <5050CE33.9060909@ti.com>
Date:   Wed, 12 Sep 2012 14:02:27 -0400
From:   Cyril Chemparathy <cyril@ti.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120824 Thunderbird/15.0
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <devicetree-discuss@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-c6x-dev@linux-c6x.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux@openrisc.net>,
        <linuxppc-dev@lists.ozlabs.org>,
        <microblaze-uclinux@itee.uq.edu.au>, <a-jacquiot@ti.com>,
        <arnd@arndb.de>, <benh@kernel.crashing.org>,
        <bigeasy@linutronix.de>, <blogic@openwrt.org>,
        <david.daney@cavium.com>, <dhowells@redhat.com>,
        <grant.likely@secretlab.ca>, <hpa@zytor.com>, <jonas@southpole.se>,
        <linus.walleij@linaro.org>, <linux@arm.linux.org.uk>,
        <m.szyprowski@samsung.com>, <mahesh@linux.vnet.ibm.com>,
        <mingo@redhat.com>, <monstr@monstr.eu>, <msalter@redhat.com>,
        <nico@linaro.org>, <paul.gortmaker@windriver.com>,
        <paulus@samba.org>, <ralf@linux-mips.org>,
        <rob.herring@calxeda.com>, <suzuki@in.ibm.com>,
        <tglx@linutronix.de>, <tj@kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH] of: specify initrd location using 64-bit
References: <1347465937-7056-1-git-send-email-cyril@ti.com> <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
In-Reply-To: <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cyril@ti.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 9/12/2012 12:16 PM, Geert Uytterhoeven wrote:
> On Wed, Sep 12, 2012 at 6:05 PM, Cyril Chemparathy <cyril@ti.com> wrote:
>> On some PAE architectures, the entire range of physical memory could reside
>> outside the 32-bit limit.  These systems need the ability to specify the
>> initrd location using 64-bit numbers.
>>
>> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
>> use 64-bit numbers instead of the current unsigned long.
>
>> -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>
> Why not phys_addr_t?
>

The rest of the memory specific bits of the device-tree code use u64 for 
addresses, and I kept it the same for consistency.

> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>

-- 
Thanks
- Cyril
