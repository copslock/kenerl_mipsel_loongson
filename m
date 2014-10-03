Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Oct 2014 15:12:44 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:56956 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010463AbaJCNMmZ2kz7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Oct 2014 15:12:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=d6c0J8CPr7MGkIri2DMJ634t+rNbrCz2y+m+JRlUFcU=;
        b=SrEYUcmfnl4+Mni8kBY6BxtX/qK9DHH8dqxAl42VaT24huOE+dcUKRBwT4WcG5Azzbqc5Os+vIifFzJ28EKqwV83kOQuvVMxDsNDCD4K9dg1iI8BeO6e/AH+RgVlTh2Rq7Rxphg3hFnvcvZVJCV9Nuz8OUj0KvEX2hgGGW9cveA=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1Xa2ex-001AWG-Ml
        for linux-mips@linux-mips.org; Fri, 03 Oct 2014 13:12:35 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55627 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1Xa2ep-001A9K-RG; Fri, 03 Oct 2014 13:12:28 +0000
Message-ID: <542EA0B7.5040007@roeck-us.net>
Date:   Fri, 03 Oct 2014 06:12:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Will Deacon <Will.Deacon@arm.com>
Subject: Re: [RFC PATCH 05/16] arm64: support poweroff through poweroff handler
 call chain
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net> <1412100056-15517-6-git-send-email-linux@roeck-us.net> <20141003103056.GB14110@localhost>
In-Reply-To: <20141003103056.GB14110@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020201.542EA0C3.01C5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 5
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 10/03/2014 03:30 AM, Catalin Marinas wrote:
> On Tue, Sep 30, 2014 at 07:00:45PM +0100, Guenter Roeck wrote:
>> The kernel core now supports a poweroff handler call chain
>> to remove power from the system. Call it if pm_power_off
>> is set to NULL.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   arch/arm64/kernel/process.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index 398ab05..cc0c63e 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -157,6 +157,8 @@ void machine_power_off(void)
>>   	smp_send_stop();
>>   	if (pm_power_off)
>>   		pm_power_off();
>> +	else
>> +		do_kernel_poweroff();
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> As others already stated, I think we should eventually remove
> pm_power_off entirely.
>

Hi Catalin,
yes, already working on it. As suggested by others, I'll move pm_power_off
to a central location (no need to declare the same variable for each
architecture) and hide the call to it in do_kernel_poweroff() as a
first step. You'll see this in the next version of the series.
This will make it much easier to remove it later on.

Thanks,
Guenter
