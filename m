Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2011 19:33:26 +0100 (CET)
Received: from gateway08.websitewelcome.com ([69.56.170.25]:49822 "HELO
        gateway08.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1490957Ab1ADSdX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jan 2011 19:33:23 +0100
Received: (qmail 28074 invoked from network); 4 Jan 2011 18:32:51 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway08.websitewelcome.com with SMTP; 4 Jan 2011 18:32:51 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=MBSdT+E6CMUU0qZxxCeafgqxIJQUfrgZ4ZHJ+sI1pA1OE4voVmBQl3NpIWlHGPnsYG0DD11Luv+uMcqn8TNqCSULIc7m/WZrIEshnFA4uXBd0xUWJEbh1CW7ovIAKLKU;
Received: from [216.239.45.4] (port=41407 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PaBh6-00051n-86; Tue, 04 Jan 2011 12:33:16 -0600
Message-ID: <4D2367EE.7000702@paralogos.com>
Date:   Tue, 04 Jan 2011 10:33:18 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Anoop P A <anoop.pa@gmail.com>
CC:     STUART VENTERS <stuart.venters@adtran.com>,
        "Anoop P.A." <Anoop_P.A@pmc-sierra.com>, linux-mips@linux-mips.org
Subject: Re: SMTC support status in latest git head.
References: <8F242B230AD6474C8E7815DE0B4982D7179FB88F@EXV1.corp.adtran.com>      <1293470392.27661.202.camel@paanoop1-desktop>   <1293524389.27661.210.camel@paanoop1-desktop>   <4D19A31E.1090905@paralogos.com>        <1293798476.27661.279.camel@paanoop1-desktop>   <4D1EE913.1070203@paralogos.com>        <1294067561.27661.293.camel@paanoop1-desktop>   <4D21F5D3.50604@paralogos.com>  <1294082426.27661.330.camel@paanoop1-desktop>   <4D22D7B3.2050609@paralogos.com>        <1294146165.27661.361.camel@paanoop1-desktop>   <1294151822.27661.375.camel@paanoop1-desktop>   <4D235717.1000603@paralogos.com> <1294163657.27661.386.camel@paanoop1-desktop>
In-Reply-To: <1294163657.27661.386.camel@paanoop1-desktop>
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
X-archive-position: 28823
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

On 01/04/11 09:54, Anoop P A wrote:
> On Tue, 2011-01-04 at 09:21 -0800, Kevin D. Kissell wrote:
>> I'm trying to figure out a reason why your change below should help, and
>> offhand, modulo tool bugs, I don't see it.  I'm assuming that your diff
>> below is a diff relative to the pre-patch stackframe.h.   I wouldn't
> Yes patch created against stock code .
>
>> bless it as an alternative because it moves code and comments
>> unnecessarily - all you should really have to do is to move the
>>
>>
>>    190                 mfc0    v1, CP0_STATUS
>>    191                 LONG_S  $2, PT_R2(sp)
>>
>> to be just after the #endif /* CONFIG_MIPS_MT_SMTC */ at around line 201.
> Actually I just moved code under CONFIG_MIPS_MT_SMTC to previous block
> of code ( which store $0 ) . git diff did the rest on behalf of me :)
>
>> If moving the save of zero to PT_R0(sp) actually makes a difference,
>> it's evidence that you've got problems in your toolchain (or, heaven
>> forbid, your pipeline)!
> In previous version of patch usage of V0 was creating issue. I have
> verified this with previous version of code ( working code before
> David's instruction rearrangement patch.) .

Argh.  It's not very clearly commented, but it looks as if the system 
call trap handler has an implicit assumption that v0 has never been 
changed by SAVE_SOME, TRACE_IRQS_ON_RELOAD, or STI.  So yeah, moving the 
code around to fix the v1 conflict ends up being better than using v0 - 
otherwise, we'd need to add a LONG_L v0, PT_R2(sp) somewhere after the 
LONG_S v0, PT_TCSTATUS(sp) of the original patch.

             Regards,

             Kevin K.
