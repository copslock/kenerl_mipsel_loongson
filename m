Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Dec 2010 16:17:13 +0100 (CET)
Received: from gateway03.websitewelcome.com ([69.93.223.19]:35759 "HELO
        gateway03.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491136Ab0LYPRK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Dec 2010 16:17:10 +0100
Received: (qmail 4117 invoked from network); 25 Dec 2010 15:16:32 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway03.websitewelcome.com with SMTP; 25 Dec 2010 15:16:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=HMdMBmmMnDGtlJmyE4eiPzoHagsnMSwzAEGkeAdwVucEK/RwqfKv1ilMzpRBFhoTVk4K36jBwSueBDV2dpqm679d7aMEeaXCspMtDz0nHUJdEI6j1V9ETcNWFp/9JE2D;
Received: from [88.123.214.42] (port=49651 helo=kkissell-macbookpro.local)
        by gator750.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PWVrk-0003HC-EM; Sat, 25 Dec 2010 09:17:05 -0600
Message-ID: <4D160AEF.7000203@paralogos.com>
Date:   Sat, 25 Dec 2010 07:17:03 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88D@EXV1.corp.adtran.com>      <4D1492E0.5090407@paralogos.com>        <1293201545.27661.55.camel@paanoop1-desktop>    <4D14B3FA.5080304@paralogos.com>        <1293206536.27661.63.camel@paanoop1-desktop>    <4D152DFA.5090504@paralogos.com> <1293262341.27661.188.camel@paanoop1-desktop>
In-Reply-To: <1293262341.27661.188.camel@paanoop1-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 12/24/10 11:32 PM, Anoop P A wrote:
> On Fri, 2010-12-24 at 15:34 -0800, Kevin D. Kissell wrote:
>> Ah, well, at least we have a stackframe.h fix that preserves David's
>> performance tweak for the deeper pipelined processors.  In looking for
>> this, I did notice that someone did some modification to the SMTC clock
>> tick logic that I was skeptical had ever been tested.  If you've still
>> got that kernel binary handy, you might check to see if it boots with
>> maxtcs=1 maxvpes=1, maxtcs=2 maxvpes=1, and/or maxtcs=2 maxvpes=2.
> Yes I have tried with various combinations of tcs and vpes. with
> maxvpes=1 I can boot with a max of 4 TCS ( VPE0 has 4 TCs) .
> However setting maxpes=2 and maxtcs=2 hangs pretty early.
>
> Clock rate set to 600000000
> console [ttyS0] enabled
> Calibrating delay loop... 398.33 BogoMIPS (lpj=796672)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 512
> Limit of 2 VPEs set
> Limit of 2 TCs set
> TLB of 64 entry pairs shared by 2 VPEs
> VPE 0: TC 0, VPE 1: TC 1
> IPI buffer pool of 32 buffers
> CPU revision is: 00019548 ((null))
> TC 1 going on-line as CPU 1
> Brought up 2 CPUs
>
> One strange observation is with maxtcs=3 and maxvpes=2 kernel boots all
> the way.
>
> Again with maxtcs=5 and maxvpes=2 it hangs after switching to MIPS
> clocksource.
>
> I strongly suspect some issue with locking. I will dig the code early
> next week.
If locking is screwed up, I'd expect more problems with 4 TC "CPUs" in 
the same VPE. It also suggests that the basic distribution via local 
low-latency IPI within a VPE is functioning, but that something is 
broken in the cross-VPE evengt propagation.  I strongly suspect that 
your maxtcs=3, maxvpes=2 case would hang sooner or later, but by luck of 
the draw none of the init threads got scheduled on VPE 1 long enough to 
get stuck.

I note that there were some changes made under the rubric "MIPS: SMTC: 
Avoid queueing multiple reschedule IPIs" in October and November of last 
year that make me nervous.  I wouldn't have coded things that way 
myself, but they might be OK. Still, the first bisection I'd make if I 
was trouble-shooting this would be to roll back to just before they went in.

             Ho, ho, ho,

             Kevin K.
