Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Sep 2015 21:02:19 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:57053 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008270AbbILTCRLCRJO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Sep 2015 21:02:17 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 3711028C088;
        Sat, 12 Sep 2015 21:01:07 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com [209.85.215.53])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 712B428C14D;
        Sat, 12 Sep 2015 21:00:59 +0200 (CEST)
Received: by lanb10 with SMTP id b10so65078981lan.3;
        Sat, 12 Sep 2015 12:02:06 -0700 (PDT)
X-Received: by 10.152.23.167 with SMTP id n7mr4897594laf.18.1442084526512;
 Sat, 12 Sep 2015 12:02:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.147.1 with HTTP; Sat, 12 Sep 2015 12:01:46 -0700 (PDT)
In-Reply-To: <55F474A4.4030308@hauke-m.de>
References: <1442075174-30414-1-git-send-email-jogo@openwrt.org>
 <1442075174-30414-4-git-send-email-jogo@openwrt.org> <55F474A4.4030308@hauke-m.de>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sat, 12 Sep 2015 21:01:46 +0200
Message-ID: <CAOiHx==akNOMTcySJF+b5h6+a9=neU8bJ8yqixUrDVzcPSciSA@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: make MIPS_CMDLINE_DTB default
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Ganesan Ramalingam <ganesanr@broadcom.com>,
        Jayachandran C <jchandra@broadcom.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Sat, Sep 12, 2015 at 8:53 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 09/12/2015 06:26 PM, Jonas Gorski wrote:
>> Seval of-enabled machines (bmips, lantiq, xlp, pistachio, ralink) copied
>> the arguments from dtb to arcs_command_line to prevent the kernel from
>> overwriting them.
>>
>> Since there is now an option to keep the dtb arguments, default to the
>> new option remove the "backup" to arcs_command_line in case of USE_OF is
>> enabled, except for those platforms that still take the bootloader
>> arguments or do not use any at all.
>>
>> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
>> ---
>>  arch/mips/Kconfig           | 3 +++
>>  arch/mips/bmips/setup.c     | 1 -
>>  arch/mips/lantiq/prom.c     | 2 --
>>  arch/mips/netlogic/xlp/dt.c | 1 -
>>  arch/mips/pistachio/init.c  | 1 -
>>  arch/mips/ralink/of.c       | 2 --
>>  6 files changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index 3753437..703142b 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -2730,6 +2730,9 @@ endchoice
>>
>>  choice
>>       prompt "Kernel command line type" if !CMDLINE_OVERRIDE
>> +     default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATh79 && !MACH_INGENIC && \
>
> ATh79 does not exist, ATH79 does.

Indeed. Maybe I should learn to use the caps-lock key ;). Will fix it for v2.


Jonas
