Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2018 15:41:05 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:43552 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994571AbeEGNk6pwMTm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 May 2018 15:40:58 +0200
Subject: Re: [PATCH] watchdog: ath79: fix maximum timeout
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
References: <20180507131642.11440-1-john@phrozen.org>
 <319719c3-eeec-c75f-68c1-b6d15cf884c5@roeck-us.net>
From:   John Crispin <john@phrozen.org>
Message-ID: <3c24c84f-baa1-2eef-4b5c-85d0e5803e7b@phrozen.org>
Date:   Mon, 7 May 2018 15:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <319719c3-eeec-c75f-68c1-b6d15cf884c5@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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



On 07/05/18 15:34, Guenter Roeck wrote:
> On 05/07/2018 06:16 AM, John Crispin wrote:
>> If the userland tries to set a timeout higher than the max_timeout,
>> then we should fallback to max_timeout.
>>
>
> We don't do that for drivers using the watchdog core, so we should not
> do it here either for consistency.
>
> Guenter

Hi,
thanks for the quick feedback. I'll mark the patch as "rejected by 
upstream due to subsystem consistency" inside OpenWrt.
     John
>
>> Signed-off-by: John Crispin <john@phrozen.org> > ---
>>   drivers/watchdog/ath79_wdt.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
>> index e2209bf5fa8a..c2fc6c3d0092 100644
>> --- a/drivers/watchdog/ath79_wdt.c
>> +++ b/drivers/watchdog/ath79_wdt.c
>> @@ -115,10 +115,14 @@ static inline void ath79_wdt_disable(void)
>>     static int ath79_wdt_set_timeout(int val)
>>   {
>> -    if (val < 1 || val > max_timeout)
>> +    if (val < 1)
>>           return -EINVAL;
>>   -    timeout = val;
>> +    if (val > max_timeout)
>> +        timeout = max_timeout;
>> +    else
>> +        timeout = val;
>> +
>>       ath79_wdt_keepalive();
>>         return 0;
>>
>
>
