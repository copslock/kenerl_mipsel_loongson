Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 11:09:27 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:56345 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903680Ab1KJKJU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2011 11:09:20 +0100
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id pAAA8pU9007433;
        Thu, 10 Nov 2011 02:08:52 -0800
Received: from [192.168.225.107] (192.168.225.107) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Thu, 10 Nov 2011
 02:08:46 -0800
Message-ID: <4EBBA2AA.6000901@mips.com>
Date:   Thu, 10 Nov 2011 18:08:42 +0800
From:   Deng-Cheng Zhu <dczhu@mips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 1/4] MIPS/Perf-events: update the map of unsupported events
 for 74K
References: <1319453762-12962-1-git-send-email-dczhu@mips.com> <1319453762-12962-2-git-send-email-dczhu@mips.com> <20111109204020.GB13280@linux-mips.org>
In-Reply-To: <20111109204020.GB13280@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: 5ov2F0WZdWH4lhp0ID6IVg==
X-archive-position: 31494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dczhu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9195

On 11/10/2011 04:40 AM, Ralf Baechle wrote:
> On Mon, Oct 24, 2011 at 06:55:59PM +0800, Deng-Cheng Zhu wrote:
>
>> Update the raw event info for 74K according to the latest document.
>
>> +/*
>> + * MIPS document MD00519 (MIPS32(r) 74K(tm) Processor Core Family Software
>> + * User's Manual, Revision 01.05)
>> + */
>>   #define IS_UNSUPPORTED_74K_EVENT(r, b)					\
>> -	((r) == 5 || ((r)>= 135&&  (r)<= 137) ||			\
>> -	 ((b)>= 10&&  (b)<= 12) || (b) == 22 || (b) == 27 ||		\
>> -	 (b) == 33 || (b) == 34 || ((b)>= 47&&  (b)<= 49) ||		\
>> -	 (r) == 178 || (b) == 55 || (b) == 57 || (b) == 60 ||		\
>> -	 (b) == 61 || (r) == 62 || (r) == 191 ||			\
>> -	 ((b)>= 64&&  (b)<= 127))
>> +	((r) == 5 || (r) == 135 || ((b)>= 10&&  (b)<= 12) ||		\
>> +	 (b) == 27 || (b) == 33 || (b) == 34 || (b) == 47 ||		\
>> +	 (b) == 48 || (r) == 178 || (r) == 187 || (b) == 60 ||		\
>> +	 (b) == 61 || (r) == 191 || (r) == 71 || (r) == 72 ||		\
>> +	 (b) == 73 || ((b)>= 77&&  (b)<= 127))
>
> ...
> Afair there are MIPS licensee who have modified the counters to count
> extra events so I sense some madness in that direction.

A good point. Now that the user is working with raw events, the manual 
is being used for sure. The user should have known what will be counted. 
But we should keep the mappings for event cntr_mask and range. Although 
they are also subject to changes by Arch licensees, patches will be 
needed for their CPU in that case.


Deng-Cheng
