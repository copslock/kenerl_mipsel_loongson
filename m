Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2014 15:29:10 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:54067 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010478AbaJBN3HsbpCt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Oct 2014 15:29:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=WoAA1w37VG1xh32TRD3BqYmoHXkZpHmAqNmf2NpTa7k=;
        b=VOLBvov6M20nyOq3o3f8HLUrVNcURQNoFKAx7BYoQtQ6lE8NOfc1I4r7KbXijjW9dAxjZL++blCh3Yz3DU/rxwEFIaKkUiE3ma0JD0NcmWrxpoTSp3F6wzxuSbcPlZd5wmudHTXUo1GcsJXOGw7Ts2qQb8HV6b5w4NVFK2B50co=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XZgRJ-000Xfw-5f
        for linux-mips@linux-mips.org; Thu, 02 Oct 2014 13:29:01 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:49260 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XZgPZ-000We3-D4; Thu, 02 Oct 2014 13:27:14 +0000
Message-ID: <542D52AC.3040009@roeck-us.net>
Date:   Thu, 02 Oct 2014 06:27:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     David Vrabel <david.vrabel@citrix.com>,
        linux-kernel@vger.kernel.org
CC:     linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sh@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [Xen-devel] [RFC PATCH 14/16] x86/xen: support poweroff through
 poweroff handler call chain
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net> <1412100056-15517-15-git-send-email-linux@roeck-us.net> <542D1EC4.10100@citrix.com>
In-Reply-To: <542D1EC4.10100@citrix.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Suspect
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020207.542D531D.007F,ss=2,re=0.000,recu=0.000,reip=0.000,cl=2,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 13
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
X-archive-position: 42929
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

On 10/02/2014 02:45 AM, David Vrabel wrote:
> On 30/09/14 19:00, Guenter Roeck wrote:
>> The kernel core now supports a poweroff handler call chain
>> to remove power from the system. Call it if pm_power_off
>> is set to NULL.
>>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: H. Peter Anvin <hpa@zytor.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   arch/x86/xen/enlighten.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
>> index c0cb11f..645d00f 100644
>> --- a/arch/x86/xen/enlighten.c
>> +++ b/arch/x86/xen/enlighten.c
>> @@ -1322,6 +1322,8 @@ static void xen_machine_power_off(void)
>>   {
>>   	if (pm_power_off)
>>   		pm_power_off();
>> +	else
>> +		do_kernel_poweroff();
>
> Why isn't this if (pm_power_off) check in do_kernel_poweroff()?
>
> That way when you finally remove pm_power_off you need only update one
> place.  A quick skim of the other archs suggest this would work for them
> too.
>

Good idea. I'll do that for the next version of the patch set.

Guenter
