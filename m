Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jun 2010 02:13:06 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7499 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491892Ab0FKANC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jun 2010 02:13:02 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c117fa00000>; Thu, 10 Jun 2010 17:13:20 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 10 Jun 2010 17:12:59 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 10 Jun 2010 17:12:59 -0700
Message-ID: <4C117F86.5090408@caviumnetworks.com>
Date:   Thu, 10 Jun 2010 17:12:54 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Himanshu Chauhan <hschauhan@nulltrace.org>
CC:     ralf@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: KProbes support v0.1
References: <1275928440-21052-1-git-send-email-hschauhan@nulltrace.org> <1275928440-21052-2-git-send-email-hschauhan@nulltrace.org> <4C0D4B82.6020002@caviumnetworks.com> <20100608175118.GA2262@hschauhan-desktop>
In-Reply-To: <20100608175118.GA2262@hschauhan-desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2010 00:12:59.0516 (UTC) FILETIME=[D99073C0:01CB08FA]
X-archive-position: 27118
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7694

On 06/08/2010 10:51 AM, Himanshu Chauhan wrote:
> Hi David,
>
> Thanks for taking a look.
>
[...]
>>> +
>>> +#define BREAKPOINT_INSTRUCTION		0x0000000d
>>> +
>>> +/*
>>> + * We do not have hardware single-stepping on MIPS.
>>> + * So we implement software single-stepping with breakpoint
>>> + * trap 'break 5'.
>>> + */
>>> +#define BREAKPOINT_INSTRUCTION_2	0x0000014d
>>
>> The BREAK codes are defined in asm/break.h  This should be added
>> there instead.
>>
>> Why do you use codes (0 and 5) that are already kind of reserved for
>> user space debuggers?
>
> As said ealier, this patch was based on some very older patch of 2.6.16 from
> Sony Corp, I didn't make much changes like this. But anyways, I wan't aware of
> this either. What would be the best code then?
>

How about allocating them after BRK_MEMU?  Say 515 and 516 or something 
like that.

David Daney
