Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2015 23:56:17 +0200 (CEST)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:42593 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013241AbbEMV4N4wvmU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2015 23:56:13 +0200
X-IronPort-AV: E=Sophos;i="5.13,422,1427785200"; 
   d="scan'208";a="64788857"
Received: from irvexchcas08.broadcom.com (HELO IRVEXCHCAS08.corp.ad.broadcom.com) ([10.9.208.57])
  by mail-gw2-out.broadcom.com with ESMTP; 13 May 2015 15:05:24 -0700
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP Server
 (TLS) id 14.3.235.1; Wed, 13 May 2015 14:56:03 -0700
Received: from mail-sj1-12.sj.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP Server id
 14.3.235.1; Wed, 13 May 2015 14:56:02 -0700
Received: from [10.176.128.58] (xl-bun-04.bun.broadcom.com [10.176.128.58])     by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 72FE627A84;        Wed, 13 May
 2015 14:56:01 -0700 (PDT)
Message-ID: <5553C870.5070407@broadcom.com>
Date:   Wed, 13 May 2015 23:56:00 +0200
From:   Arend van Spriel <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111103 Lightning/1.0b2 Thunderbird/3.1.16
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        brcm80211 development <brcm80211-dev-list@broadcom.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: 4.1-rc2: build issue with duplicate redefinition of _PAGE_GLOBAL_SHIFT
References: <55539B68.8060304@broadcom.com> <CAOiHx==e0MTorbgAgmL13nT=5ChW2OnFB7RKxenjaRZbnzS1-A@mail.gmail.com>
In-Reply-To: <CAOiHx==e0MTorbgAgmL13nT=5ChW2OnFB7RKxenjaRZbnzS1-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <arend@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
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

On 05/13/15 21:19, Jonas Gorski wrote:
> Hi Arend,
>
> On Wed, May 13, 2015 at 8:43 PM, Arend van Spriel<arend@broadcom.com>  wrote:
>> For our upstream brcm80211 drivers we build for a number of architectures
>> including MIPS. In recent builds we get an error/warning:
>>
>>    CC [M]  drivers/net/wireless/brcm80211/brcmfmac/cfg80211.o
>> In file included from ./arch/mips/include/asm/io.h:27:0,
>>                   from ./arch/mips/include/asm/page.h:176,
>>                   from include/linux/mm_types.h:15,
>>                   from include/linux/kmemcheck.h:4,
>>                   from include/linux/skbuff.h:18,
>>                   from include/linux/if_ether.h:23,
>>                   from include/linux/etherdevice.h:25,
>>                   from drivers/net/wireless/brcm80211/brcmfmac/cfg80211.c:20:
>> ./arch/mips/include/asm/pgtable-bits.h:164:0: error: "_PAGE_GLOBAL_SHIFT"
>> redefined [-Werror]
>> ./arch/mips/include/asm/pgtable-bits.h:141:0: note: this is the location of
>> the previous definition
>>
>> As it is likely a Kconfig issue I have attached the config file that was
>> used for the build. I started out with mips_config.old and ran 'make
>> oldconfig' and just hit enter a couple of times selecting all defaults which
>> ends up with the mips_config file having the issue. As I have no clue what
>> Kconfig combinations are valid I am hoping anyone on the mips list can shed
>> some light on this.
>
> this isn't a config issue, it's a clear bug which
>
> https://patchwork.linux-mips.org/patch/9960/
>
> intends to fix.

Excellent. Thanks, Jonas.

Regards,
Arend
