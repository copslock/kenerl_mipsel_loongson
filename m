Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jan 2011 18:51:20 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:15111 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491773Ab1ATRvR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jan 2011 18:51:17 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3876430000>; Thu, 20 Jan 2011 09:52:03 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 20 Jan 2011 09:51:14 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 20 Jan 2011 09:51:14 -0800
Message-ID: <4D387612.5080502@caviumnetworks.com>
Date:   Thu, 20 Jan 2011 09:51:14 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dezhong Diao <dediao@cisco.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/6] MIPS: perf: Reorganize contents of perf support files.
References: <1294367707-2593-1-git-send-email-ddaney@caviumnetworks.com>        <1294367707-2593-5-git-send-email-ddaney@caviumnetworks.com> <AANLkTi=5+QxOipaTycLBuLUHr7iOGCe0nfG9mQsKADoj@mail.gmail.com>
In-Reply-To: <AANLkTi=5+QxOipaTycLBuLUHr7iOGCe0nfG9mQsKADoj@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Jan 2011 17:51:14.0795 (UTC) FILETIME=[A1D163B0:01CBB8CA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 01/20/2011 02:01 AM, Deng-Cheng Zhu wrote:
> 2011/1/7 David Daney<ddaney@caviumnetworks.com>:
>> @@ -1034,5 +1560,3 @@ init_hw_perf_events(void)
>>         return 0;
>>   }
>>   arch_initcall(init_hw_perf_events);
>> -
>> -#endif /* defined(CONFIG_CPU_MIPS32)... */
>
> arch_initcall should be now early_initcall.
>

Yes, with my current patch set, it is as you indicate.

I will try to send a new patch set later today.

David Daney
