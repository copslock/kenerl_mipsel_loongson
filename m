Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2013 16:03:56 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:33423 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824004Ab3ICODpZdWXu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Sep 2013 16:03:45 +0200
Message-ID: <5225EC3B.1070701@imgtec.com>
Date:   Tue, 3 Sep 2013 15:03:39 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: ath79: Avoid using unitialized 'reg' variable
References: <1377082042-4219-1-git-send-email-markos.chandras@imgtec.com> <20130903133839.GA10563@linux-mips.org>
In-Reply-To: <20130903133839.GA10563@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_09_03_15_03_39
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37744
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

On 09/03/13 14:38, Ralf Baechle wrote:
> On Wed, Aug 21, 2013 at 11:47:22AM +0100, Markos Chandras wrote:
>
>> Fixes the following build error:
>> arch/mips/include/asm/mach-ath79/ath79.h:139:20: error: 'reg' may be used
>> uninitialized in this function [-Werror=maybe-uninitialized]
>> arch/mips/ath79/common.c:62:6: note: 'reg' was declared here
>> In file included from arch/mips/ath79/common.c:20:0:
>> arch/mips/ath79/common.c: In function 'ath79_device_reset_clear':
>> arch/mips/include/asm/mach-ath79/ath79.h:139:20:
>> error: 'reg' may be used uninitialized in this function
>> [-Werror=maybe-uninitialized]
>> arch/mips/ath79/common.c:90:6: note: 'reg' was declared here
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>> Changes since v1:
>> http://www.linux-mips.org/archives/linux-mips/2013-08/msg00126.html
>> - Remove BUG(). panic() is enough.
>> http://www.linux-mips.org/archives/linux-mips/2013-08/msg00133.html
>> - Change panic() message to be more accurate.
>> http://www.linux-mips.org/archives/linux-mips/2013-08/msg00164.html
>> ---
>>   arch/mips/ath79/common.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
>> index eb3966c..6d7a9d4 100644
>> --- a/arch/mips/ath79/common.c
>> +++ b/arch/mips/ath79/common.c
>> @@ -75,7 +75,7 @@ void ath79_device_reset_set(u32 mask)
>>   	else if (soc_is_qca955x())
>>   		reg = QCA955X_RESET_REG_RESET_MODULE;
>>   	else
>> -		BUG();
>> +		panic("Reset register not defined for this SOC");
>>
>>   	spin_lock_irqsave(&ath79_device_reset_lock, flags);
>>   	t = ath79_reset_rr(reg);
>> @@ -103,7 +103,7 @@ void ath79_device_reset_clear(u32 mask)
>>   	else if (soc_is_qca955x())
>>   		reg = QCA955X_RESET_REG_RESET_MODULE;
>>   	else
>> -		BUG();
>> +		panic("Reset register not defined for this SOC");
>>
>>   	spin_lock_irqsave(&ath79_device_reset_lock, flags);
>>   	t = ath79_reset_rr(reg);
>
> Looks more like the implementation of BUG() is wrong and gcc doesn't
> notice that BUG() won't return.
>
> Was this triggered by CONFIG_BUG=n?
>
>    Ralf
>

Hi Ralf,

Yes it was triggered by CONFIG_BUG=n
