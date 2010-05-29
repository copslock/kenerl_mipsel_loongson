Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2010 20:13:46 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:63917 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492033Ab0E2SNm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 May 2010 20:13:42 +0200
Received: by pwi2 with SMTP id 2so1104147pwi.36
        for <multiple recipients>; Sat, 29 May 2010 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=i9D7pQb7+IWK8Js47myxnX1xob36GZ87QAghBq61L/A=;
        b=F92JcVSbTN8u0wTPlYIWlIHbWdg0IW4MztbOsg5TvTUDuLPAI25GDQqelncqWbZ/gB
         ZMRJ6VknF2iAm8cRnzx4a/OXAJz+bjeR294A4U5TCKEdK+L0nRsxE3yx6OcJW4ORKRnK
         rD0aFBNsu6GLBy61ooykNn0Z2tztNaxL5Tlkg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=i1KLNhQkWEEPiWhbYM2RMNAp9zihtZKn58dLtjBhTGhyj4ECHSIaBH4LzYfZHhcrnb
         BYeBaj2PmdtoOw/c5obKDKmJY5WpsXbm1Ku3uBqgvObAs3eoBSuK+LtAkpQCyBg9LeCI
         xV6xPcI9ui46gkKr355FKHCB8ZAVQfFYaO5J0=
Received: by 10.115.115.39 with SMTP id s39mr1683921wam.119.1275156813665;
        Sat, 29 May 2010 11:13:33 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-127-190-169.dsl.pltn13.pacbell.net [67.127.190.169])
        by mx.google.com with ESMTPS id b6sm31491967wam.9.2010.05.29.11.13.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 11:13:32 -0700 (PDT)
Message-ID: <4C015949.4060106@gmail.com>
Date:   Sat, 29 May 2010 11:13:29 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc11 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        a.p.zijlstra@chello.nl, paulus@samba.org, mingo@elte.hu,
        acme@redhat.com, jamie.iles@picochip.com, will.deacon@arm.com
Subject: Re: [PATCH v5 06/12] MIPS: add support for hardware performance events
 (mipsxx)
References: <1274965420-5091-1-git-send-email-dengcheng.zhu@gmail.com>  <1274965420-5091-7-git-send-email-dengcheng.zhu@gmail.com>      <4BFEF5D7.4050502@gmail.com> <AANLkTim22Di_l7pM_qGA79MA0xejpi0Lo1OTZqCvP7-L@mail.gmail.com>
In-Reply-To: <AANLkTim22Di_l7pM_qGA79MA0xejpi0Lo1OTZqCvP7-L@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

On 05/28/2010 08:10 PM, Deng-Cheng Zhu wrote:
> 2010/5/28 David Daney<david.s.daney@gmail.com>:
>    
>> General comments:
>>
>> Can you separate the code that reads and writes the performance counter
>> registers from the definitions of the various counters themselves?
>>      
> [DC]:
> 1) Do you mean to move M_PERFCTL_* stuff out into pmu.h (or mipsregs.h)?
> If yes, that's OK. Again (my reply for [1/12] mentions this for the 1st
> time): After making Oprofile use Perf-events as backend (patches 8~12 do
> this), register definitions and read/write functions will locate in pmu.h
> (or mipsregs.h) and perf_event_$cpu.c, respectively.
> 2) According to your reply to [7/12], do you mean the perf counter
> read/write functions (such as mipsxx_pmu_read_counter()) are generic
> support functions? No, they are specific for mipsxx CPUs.
>
>    


Basically what I had in mind is that for all MIPS CPUs that have this 
style of performance counters, the counters are all read in the same 
manner (by reading the c0_PerfCnt registers).  However each CPU type has 
its own set of events that can be counted.

So I was thinking to separate the common code that accesses the 
registers from the CPU specific code that deals with the specific names 
and properties of the various events.


David Daney
