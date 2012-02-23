Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2012 17:25:31 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:46797 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903631Ab2BWQZ0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 23 Feb 2012 17:25:26 +0100
Message-ID: <4F466867.2070800@phrozen.org>
Date:   Thu, 23 Feb 2012 17:25:11 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110820 Icedove/3.1.12
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     Mikael Starvik <mikael.starvik@axis.com>, raghu@mips.com,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: SMP MIPS and Linux 3.2
References: <4BEA3FF3CAA35E408EA55C7BE2E61D055C76C25948@xmail3.se.axis.com> <CAOfQC98QuBp+-9UKXt4kqnrtzmNyHqDWG+6RBzspvhgJwsps4A@mail.gmail.com>
In-Reply-To: <CAOfQC98QuBp+-9UKXt4kqnrtzmNyHqDWG+6RBzspvhgJwsps4A@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

the proposed patch will only fix this problem for SoCs with gic_present=1

i have just sent a patch [1] that makes it work on lantiq 34kc socs that
have gic_present=0

John

[1] http://www.linux-mips.org/archives/linux-mips/2012-02/msg00140.html



On 23/02/12 11:11, Deng-Cheng Zhu wrote:
> I should have contacted the author (Raghu Gandham) of a fix for this
> issue to get it into the mainline. But it slipped out of my mind...
> 
> The patch link is here:
> http://git.linux-mips.org/?p=linux-mti.git;a=commitdiff;h=5460815027d802697b879644c74f0e8365254020
> 
> Hi, Raghu
> 
> Do you know why it didn't happen?
> 
> 
> Deng-Cheng
> 
> On Wed, Feb 22, 2012 at 6:57 PM, Mikael Starvik <mikael.starvik@axis.com> wrote:
>>
>> Found it! There are no calls to scheduler_ipi() from the MIPS parts in vanilla 3.2.
>>
>> /Mikael
>>
>> -----Original Message-----
>> From: Mikael Starvik
>> Sent: den 20 februari 2012 10:34
>> To: 'linux-mips@linux-mips.org'
>> Subject: SMP MIPS and Linux 3.2
>>
>> I'm running Linux 3.2 on a MIPS 34K with two VPEs (in MT_SMP configuration). It works fine in UP but with SMP it deadlocks during bootup (both CPUs gets idle). Typically like this:
>>
>> [    0.090000] CPU revision is: 01019550 (MIPS 34Kc) [    0.090000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
>> [    0.090000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes [    0.170000] Brought up 2 CPUs <No more output>
>>
>> I have tried to enable __ARCH_WANT_INTERRUPTS_ON_CTXSW but that didn't improve anything. Anyone else got this running or have any thoughts about what the problem may be?
>>
>> Best Regards
>> /Mikael
>>
> 
> 
