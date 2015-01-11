Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 02:19:33 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:45266 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010460AbbAKBTcCWkqQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 02:19:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=aP0+Sz3dvkfw0zIG18PS2V4xranDc0/nJ8GeYtkMSRE=;
        b=smWQJLdnOludslCX8Al08kRQSwYL3eF+Q3HM8ACnidCQF17URG4z9HDjoykZDZ+XzbijN8Jh3lsNBhPJKT20/2fC6tRxaBuON2NtlXj3odfEhh/XDnpKa6IkllorJXB6uISzCLjbY/6tyYNoW73+nAhrIPnhsCv8gEK8wlWf/rU=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YA7Be-004LUJ-FH
        for linux-mips@linux-mips.org; Sun, 11 Jan 2015 01:19:26 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52225 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YA7Bd-004LOj-CN; Sun, 11 Jan 2015 01:19:25 +0000
Message-ID: <54B1CF9B.3060606@roeck-us.net>
Date:   Sat, 10 Jan 2015 17:19:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] MIPS: Use do_kernel_restart() as the default restart
 handler
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <yw1xh9vyflfw.fsf@unicorn.mansr.com>
In-Reply-To: <yw1xh9vyflfw.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020202.54B1CF9D.00F4,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
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
X-archive-position: 45057
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

On 01/10/2015 12:08 PM, Måns Rullgård wrote:
> Lars-Peter Clausen <lars@metafoo.de> writes:
>
>> Use the recently introduced do_kernel_restart() function as the default restart
>> handler if the platform did not explicitly provide a restart handler. This
>> allows use restart handler that have been registered by device drivers to
>> restart the machine.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>   arch/mips/kernel/reset.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
>> index 07fc524..36cd80c 100644
>> --- a/arch/mips/kernel/reset.c
>> +++ b/arch/mips/kernel/reset.c
>> @@ -19,7 +19,7 @@
>>    * So handle all using function pointers to machine specific
>>    * functions.
>>    */
>> -void (*_machine_restart)(char *command);
>> +void (*_machine_restart)(char *command) = do_kernel_restart;
>>   void (*_machine_halt)(void);
>>   void (*pm_power_off)(void);
>
> There is already a similar patch posted by Kevin Cernekee:
> http://www.linux-mips.org/archives/linux-mips/2014-12/msg00410.html
>
Personally I prefer the earlier patch, though I guess that is personal preference.

Guenter
