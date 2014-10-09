Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 15:24:42 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:34316 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010937AbaJINYjzeYSz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 15:24:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=U94sfdSA70105YmnE1feyGPTziXsD8ztWWB7mU43L+M=;
        b=AsD05gqd8qeWWMYqQzteHBW1FEaDj52uLAZoyHowHv6WqMeWo4OTxyNsDUM+r8DIPmyz9HQSC7eG6a2ZIcsIFUi8a/Y60DR0vKoHsqvaCWtztybqoI6w4xGD5BbJN3FJnto2KbPkIzu49LDkOiy4wq1yTXRt2ykHidHRe5gbHDM=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XcDhn-000iKc-WD
        for linux-mips@linux-mips.org; Thu, 09 Oct 2014 13:24:32 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36565 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XcDha-000iGU-V1; Thu, 09 Oct 2014 13:24:19 +0000
Message-ID: <54368C7D.5040402@roeck-us.net>
Date:   Thu, 09 Oct 2014 06:24:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Pavel Machek <pavel@ucw.cz>
CC:     linux-kernel@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 03/44] hibernate: Call have_kernel_poweroff instead of
 checking pm_power_off
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net> <1412659726-29957-4-git-send-email-linux@roeck-us.net> <20141009103254.GB6787@amd>
In-Reply-To: <20141009103254.GB6787@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=0.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020202.54368C90.000D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 8
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
X-archive-position: 43128
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

On 10/09/2014 03:32 AM, Pavel Machek wrote:
> On Mon 2014-10-06 22:28:05, Guenter Roeck wrote:
>> Poweroff handlers may now be installed with register_poweroff_handler.
>> Use the new API function have_kernel_poweroff to determine if a poweroff
>> handler has been installed.
>>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Len Brown <len.brown@intel.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   kernel/power/hibernate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index a9dfa79..20353c5 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -602,7 +602,7 @@ static void power_down(void)
>>   	case HIBERNATION_PLATFORM:
>>   		hibernation_platform_enter();
>>   	case HIBERNATION_SHUTDOWN:
>> -		if (pm_power_off)
>> +		if (have_kernel_poweroff())
>>   			kernel_power_off();
>>   		break;
>
> poweroff -> power_off.
>
As mentioned in my other reply, that was on purpose to distinguish
existing functions from poweroff handler functions.

> But if you are playing with this, anyway... does it make sense to
> introduce kernel_power_off() that just works, no need to check
> have_..?
> 									Pavel

I am trying not to change existing behavior.

kernel_power_off is an existing function which does some cleanup
before calling machine_power_off which in turn calls do_kernel_poweroff
(or currently pm_power_off and may do some other machine specific stuff.

Sure, poweroff handling could be unified further. We could decide to
enter an endless loop if machine_power_off() returns, or we could decide
to dump a warning or panic in this case. But that is all separate from
the issue I am trying to solve here, which is to provide a capability to
register more than one poweroff handler. It would also not be that simple,
since some architectures call machine_power_off() directly from various
places.

Guenter
