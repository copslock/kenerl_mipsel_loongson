Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 07:08:01 +0200 (CEST)
Received: from smtpout.microchip.com ([198.175.253.82]:17794 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27033603AbcFBFH6bZZQY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 07:07:58 +0200
Received: from [10.41.20.11] (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.181.6; Wed, 1 Jun 2016
 22:07:50 -0700
Subject: Re: [PATCH 03/11] MIPS: pic32mzda: fix getting timer clock rate.
To:     Harvey Hunt <harvey.hunt@imgtec.com>,
        <linux-kernel@vger.kernel.org>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
 <1463461560-9629-3-git-send-email-purna.mandal@microchip.com>
 <062abb47-931c-c47f-bcc1-1642db0c0def@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        Joshua Henderson <joshua.henderson@microchip.com>
From:   Purna Chandra Mandal <purna.mandal@microchip.com>
Message-ID: <574FBEB5.9090407@microchip.com>
Date:   Thu, 2 Jun 2016 10:35:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <062abb47-931c-c47f-bcc1-1642db0c0def@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <Purna.Mandal@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: purna.mandal@microchip.com
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

On 05/25/2016 09:32 PM, Harvey Hunt wrote:
> Hi Purna,
>
> On 17/05/16 06:05, Purna Chandra Mandal wrote:
>> PIC32 clock driver is now implemented as platform driver instead of
>> as part of of_clk_init(). It meants all the clock modules are available
>> quite late in the boot sequence. So request for CPU clock by clk_get_sys()
>> and clk_get_rate() to find c0_timer rate fails.
>>
>> To fix this use PIC32 specific early clock functions implemented for early
>> console support.
>>
>> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
>>
>> ---
>> Note: Please pull this complete series through the MIPS tree.
>>
>> ---
>>
>>  arch/mips/pic32/pic32mzda/time.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/mips/pic32/pic32mzda/time.c b/arch/mips/pic32/pic32mzda/time.c
>> index ca6a62b..62a0a78 100644
>> --- a/arch/mips/pic32/pic32mzda/time.c
>> +++ b/arch/mips/pic32/pic32mzda/time.c
>> @@ -11,13 +11,12 @@
>>   *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
>>   *  for more details.
>>   */
>> -#include <linux/clk.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/clocksource.h>
>>  #include <linux/init.h>
>> +#include <linux/irqdomain.h>
>>  #include <linux/of.h>
>>  #include <linux/of_irq.h>
>> -#include <linux/irqdomain.h>
>>
>>  #include <asm/time.h>
>>
>> @@ -58,16 +57,12 @@ unsigned int get_c0_compare_int(void)
>>
>>  void __init plat_time_init(void)
>>  {
>> -    struct clk *clk;
>> +    unsigned long rate = pic32_get_pbclk(7);
>
> pic32_get_pbclk() is defined in arch/mips/pic32/pic32mzda/early_clk.c. When CONFIG_EARLY_PRINTK isn't set, early_clk.c isn't compiled and so a linker error occurs.
>
> Maybe it's best to always build the early_clk.c file, or perhaps there is a better place to put pic32_get_pbclk()?
>
Thanks Harvey.

Will fix in separate patch.

> Thanks,
>
> Harvey
>
