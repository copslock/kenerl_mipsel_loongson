Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2013 12:11:53 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:35266 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817237Ab3IBKLuXjW8Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Sep 2013 12:11:50 +0200
Message-ID: <52246461.1010808@imgtec.com>
Date:   Mon, 2 Sep 2013 11:11:45 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: powertv: Drop BOOTLOADER_DRIVER Kconfig symbol
References: <1377075213-22398-1-git-send-email-markos.chandras@imgtec.com> <52237C76.4010608@phrozen.org>
In-Reply-To: <52237C76.4010608@phrozen.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.130]
X-SEF-Processed: 7_3_0_01192__2013_09_02_11_11_44
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 09/01/13 18:42, John Crispin wrote:
> On 21/08/13 10:53, Markos Chandras wrote:
>> The kbldr.h header file required for this was neither committed in the
>> original submission in a3a0f8c8ed2e2470f4dcd6da95020d41fed84747
>> "MIPS: PowerTV: Base files for Cisco PowerTV platform"
>> nor it was ever present in the git tree so this option never worked.
>> Fixes the following build problem:
>> arch/mips/powertv/reset.c:25:36: fatal error:
>> asm/mach-powertv/kbldr.h: No such
>> file or directory
>> compilation terminated.
>>
>> Signed-off-by: Markos Chandras<markos.chandras@imgtec.com>
>> Acked-by: Steven J. Hill<Steven.Hill@imgtec.com>
>> ---
>> This patch is for the upstream-sfr/mips-for-linux-next tree
>> ---
>>   arch/mips/Kconfig                     |  1 +
>>   arch/mips/powertv/Kconfig             |  9 +--------
>>   arch/mips/powertv/asic/asic_devices.c | 15 +++------------
>>   arch/mips/powertv/init.c              |  4 ----
>>   arch/mips/powertv/reset.c             | 12 ------------
>>   5 files changed, 5 insertions(+), 36 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>> index e12764c..d08a3a6 100644
>> --- a/arch/mips/Kconfig
>> +++ b/arch/mips/Kconfig
>> @@ -416,6 +416,7 @@ config PMC_MSP
>>   config POWERTV
>>       bool "Cisco PowerTV"
>>       select BOOT_ELF32
>> +    select BOOTLOADER_FAMILY
>>       select CEVT_R4K
>>       select CPU_MIPSR2_IRQ_VI
>>       select CPU_MIPSR2_IRQ_EI
>
> Hi,
>
> BOOTLOADER_FAMILY is a string causing the select to spew this error
>
> -> arch/mips/Kconfig:420:warning: 'BOOTLOADER_FAMILY' has wrong type.
> 'select' only accept arguments of boolean and tristate type
>
>      John

Hi John,

Hmm strange I haven't seen this problem when I tested this patch. I will 
double check and submit a new patch.
