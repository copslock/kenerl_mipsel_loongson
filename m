Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2010 15:49:33 +0200 (CEST)
Received: from mail-out.m-online.net ([212.18.0.9]:55347 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492015Ab0GNNt1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Jul 2010 15:49:27 +0200
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 4BAD01C15B1B;
        Wed, 14 Jul 2010 15:49:22 +0200 (CEST)
X-Auth-Info: AWuL4qZ4SbywjC6Q3Gd7Ew+k4h9yjeuDTIqLKyjxeOo=
Received: from lancy.mylan.de (p4FF069FD.dip.t-dialin.net [79.240.105.253])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 245631C00244;
        Wed, 14 Jul 2010 15:49:22 +0200 (CEST)
Message-ID: <4C3DC06D.10107@grandegger.com>
Date:   Wed, 14 Jul 2010 15:49:33 +0200
From:   Wolfgang Grandegger <wg@grandegger.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     linux-mips@linux-mips.org, Wolfgang Grandegger <wg@denx.de>
Subject: Re: [PATCH] mips/alchemy: add basic support for the GPR board
References: <1279101547-14498-1-git-send-email-wg@grandegger.com> <AANLkTilE6ss4qBk43Dml6SLwUrzawAVtcMw69RrMT4RF@mail.gmail.com>
In-Reply-To: <AANLkTilE6ss4qBk43Dml6SLwUrzawAVtcMw69RrMT4RF@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <wg@grandegger.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27387
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wg@grandegger.com
Precedence: bulk
X-list: linux-mips

On 07/14/2010 12:12 PM, Manuel Lauss wrote:
> On Wed, Jul 14, 2010 at 11:59 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> From: Wolfgang Grandegger <wg@denx.de>
>>
>> This patch adds basic support for the General Purpose Router (GPR)
>> board from Trapeze ITS.
>>
>> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
>> ---
>>  arch/mips/Makefile                         |    6 +
>>  arch/mips/alchemy/Kconfig                  |    9 +
>>  arch/mips/alchemy/gpr/Makefile             |   11 +
>>  arch/mips/alchemy/gpr/board_setup.c        |   97 ++
>>  arch/mips/alchemy/gpr/init.c               |   63 +
>>  arch/mips/alchemy/gpr/platform.c           |  185 +++
>>  arch/mips/configs/gpr_defconfig            | 2062 ++++++++++++++++++++++++++++
>>  arch/mips/include/asm/mach-au1x00/au1000.h |    2 +
>>  8 files changed, 2435 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/mips/alchemy/gpr/Makefile
>>  create mode 100644 arch/mips/alchemy/gpr/board_setup.c
>>  create mode 100644 arch/mips/alchemy/gpr/init.c
>>  create mode 100644 arch/mips/alchemy/gpr/platform.c
>>  create mode 100644 arch/mips/configs/gpr_defconfig
>>
>> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
>> index 0b9c01a..6b81b9f 100644
>> --- a/arch/mips/Makefile
>> +++ b/arch/mips/Makefile
>> @@ -325,6 +325,12 @@ load-$(CONFIG_MIPS_MTX1)   += 0xffffffff80100000
>>  libs-$(CONFIG_MIPS_XXS1500)    += arch/mips/alchemy/xxs1500/
>>  load-$(CONFIG_MIPS_XXS1500)    += 0xffffffff80100000
>>
>> +#
>> +# Trapeze ITS GRP board
>> +#
>> +libs-$(CONFIG_MIPS_GPR)                += arch/mips/alchemy/gpr/
>> +load-$(CONFIG_MIPS_GPR)                += 0xffffffff80100000
>> +
> 
> Have a look at the current mips-queue tree: theres a new way to hook up
> boards with Platform files.
> 
> 
>> --- a/arch/mips/include/asm/mach-au1x00/au1000.h
>> +++ b/arch/mips/include/asm/mach-au1x00/au1000.h
>> @@ -994,6 +994,8 @@ enum soc_au1200_ints {
>>
>>  #ifdef CONFIG_SOC_AU1550
>>  #define UART0_ADDR             0xB1100000
>> +#define UART1_ADDR             0xB1200000
>> +#define UART3_ADDR             0xB1400000
> 
> Please don't add those back, I'm trying to get rid of them.  Use something
> like "KSEG1ADDR(UART1_PHYS_ADDR)" in the init code where you enable
> uarts 1 and 3.

I just re-sent v2 which is now based on the linux-queue git tree.

Thanks,

Wolfgang.
