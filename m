Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Feb 2011 02:25:00 +0100 (CET)
Received: from [12.108.191.235] ([12.108.191.235]:17486 "EHLO
        mail3.caviumnetworks.com" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491926Ab1BABY5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Feb 2011 02:24:57 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d4761190000>; Mon, 31 Jan 2011 17:25:45 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 31 Jan 2011 17:24:55 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 31 Jan 2011 17:24:55 -0800
Message-ID: <4D4760E1.9000400@caviumnetworks.com>
Date:   Mon, 31 Jan 2011 17:24:49 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Earl Chew <echew@ixiacom.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Filling in struct mips64_watch_regs from a 32 bit process
References: <4D4756B5.4010100@ixiacom.com> <4D475BCB.9050403@caviumnetworks.com> <4D475DFC.1040401@ixiacom.com>
In-Reply-To: <4D475DFC.1040401@ixiacom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2011 01:24:55.0194 (UTC) FILETIME=[D4FBE7A0:01CBC1AE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 01/31/2011 05:12 PM, Earl Chew wrote:
>>> I notice that a 32 bit process running on a 64 bit kernel is expected to
>>> know that it should fill in mips64_watch_regs --- even though it is running
>>> against a 32 bit ABI.
>>>
>>> Is this an oversight, or am I missing something ?
>>
>> It is intentional.
>
> Oh I see ... I have to call PTRACE_SET_WATCH_REGS first in order to figure
> out whether the kernel is expecting me to use pt_watch_style_mips32 or
> pt_watch_style_mips64.
>

That would be PTRACE_GET_WATCH_REGS.  It will tell you the width of the 
registers as well as how many are available (in the num_valid field) and 
the properties of each (in the watch_masks[] fields).

Fill in watchlo[] and watchhi[], write them back with 
PTRACE_SET_WATCH_REGS, then sit back and wait for SIGTRAP.

David Daney
