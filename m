Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 08:54:01 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:35433 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903646Ab2BXHx5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 08:53:57 +0100
Received: from exchdb01.mips.com (exchdb01.mips.com [192.168.36.67])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q1O7rhv9013932;
        Thu, 23 Feb 2012 23:53:43 -0800
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([::1]) with mapi id 14.01.0270.001; Thu, 23 Feb 2012
 23:53:39 -0800
From:   "Gandham, Raghu" <raghu@mips.com>
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>,
        Mikael Starvik <mikael.starvik@axis.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: SMP MIPS and Linux 3.2
Thread-Topic: SMP MIPS and Linux 3.2
Thread-Index: AcznH9lfpXUbAgVmQ5aJnfIX4n0HcAIkubIwAGd2VNAAQXpygAAcmanw
Date:   Fri, 24 Feb 2012 07:53:38 +0000
Message-ID: <437D1CB836242C4498C8A7EAC739E10301232877FB@exchdb03.mips.com>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D055C76C25948@xmail3.se.axis.com>
 <CAOfQC98QuBp+-9UKXt4kqnrtzmNyHqDWG+6RBzspvhgJwsps4A@mail.gmail.com>
In-Reply-To: <CAOfQC98QuBp+-9UKXt4kqnrtzmNyHqDWG+6RBzspvhgJwsps4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: sFkYSjAgrIFyN6BKwCHfOA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 32533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raghu@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


Hi Deng-Cheng, 

>Do you know why it didn't happen?

I must have forgotten to upload this patch along with other patches I submitted a while ago. I will verify that this patch is valid as is and submit it.

Raghu

>-----Original Message-----
>From: Deng-Cheng Zhu [mailto:dengcheng.zhu@gmail.com]
>Sent: Thursday, February 23, 2012 2:11 AM
>To: Mikael Starvik; Gandham, Raghu
>Cc: linux-mips@linux-mips.org
>Subject: Re: SMP MIPS and Linux 3.2
>
>I should have contacted the author (Raghu Gandham) of a fix for this
>issue to get it into the mainline. But it slipped out of my mind...
>
>The patch link is here:
>http://git.linux-mips.org/?p=linux-
>mti.git;a=commitdiff;h=5460815027d802697b879644c74f0e8365254020
>
>Hi, Raghu
>
>Do you know why it didn't happen?
>
>
>Deng-Cheng
>
>On Wed, Feb 22, 2012 at 6:57 PM, Mikael Starvik
><mikael.starvik@axis.com> wrote:
>>
>> Found it! There are no calls to scheduler_ipi() from the MIPS parts in
>vanilla 3.2.
>>
>> /Mikael
>>
>> -----Original Message-----
>> From: Mikael Starvik
>> Sent: den 20 februari 2012 10:34
>> To: 'linux-mips@linux-mips.org'
>> Subject: SMP MIPS and Linux 3.2
>>
>> I'm running Linux 3.2 on a MIPS 34K with two VPEs (in MT_SMP
>configuration). It works fine in UP but with SMP it deadlocks during
>bootup (both CPUs gets idle). Typically like this:
>>
>> [    0.090000] CPU revision is: 01019550 (MIPS 34Kc) [    0.090000]
>Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
>> [    0.090000] Primary data cache 32kB, 4-way, PIPT, no aliases,
>linesize 32 bytes [    0.170000] Brought up 2 CPUs <No more output>
>>
>> I have tried to enable __ARCH_WANT_INTERRUPTS_ON_CTXSW but that didn't
>improve anything. Anyone else got this running or have any thoughts
>about what the problem may be?
>>
>> Best Regards
>> /Mikael
>>
