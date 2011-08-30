Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2011 18:55:58 +0200 (CEST)
Received: from gateway04.websitewelcome.com ([67.18.125.4]:50512 "HELO
        gateway04.websitewelcome.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1491820Ab1H3Qzx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2011 18:55:53 +0200
Received: (qmail 30176 invoked from network); 30 Aug 2011 16:54:13 -0000
Received: from ham.websitewelcome.com (173.192.100.229)
  by gateway04.websitewelcome.com with SMTP; 30 Aug 2011 16:54:13 -0000
Received: by ham.websitewelcome.com (Postfix, from userid 666)
        id C08BB6D3EF12; Tue, 30 Aug 2011 11:55:04 -0500 (CDT)
Received: from gator750.hostgator.com (gator750.hostgator.com [174.132.194.2])
        by ham.websitewelcome.com (Postfix) with ESMTP id A787C6D3DCC2
        for <linux-mips@linux-mips.org>; Tue, 30 Aug 2011 11:54:54 -0500 (CDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type:Content-Transfer-Encoding:X-BWhitelist:X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:X-Email-Count:X-Source-Cap;
        b=cIpIATD0Sh/BHGlhRCj8KEVIqfQIx/urxRhoRGKQyRxWgbdQhsJHFDqA9dcmt9pTBiOrt+juLODW9bnJJdiZ7D/AJhQSFc+mULbf7O6jzuLIGCn8kXa6ILphV013oAwe;
Received: from [216.239.45.4] (port=38612 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1QyRaN-0006eb-IQ; Tue, 30 Aug 2011 11:54:51 -0500
Message-ID: <4E5D15DD.2020201@paralogos.com>
Date:   Tue, 30 Aug 2011 09:54:53 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
MIME-Version: 1.0
To:     "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
CC:     David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
References: <20110829232029.GA15763@zapo> <4E5C2490.6040203@cavium.com> <4E5C26D4.3000906@paralogos.com> <4E5C2B62.9040007@cavium.com> <4E5C3060.70302@paralogos.com> <20110830111603.GB14243@edde.se.axis.com>
In-Reply-To: <20110830111603.GB14243@edde.se.axis.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-BWhitelist: no
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 216-239-45-4.google.com (kkissell.mtv.corp.google.com) [216.239.45.4]:38612
X-Source-Auth: kevink@kevink.net
X-Email-Count: 1
X-Source-Cap: a2tpc3NlbGw7a2tpc3NlbGw7Z2F0b3I3NTAuaG9zdGdhdG9yLmNvbQ==
X-archive-position: 31017
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22650

On 08/30/11 04:16, Edgar E. Iglesias wrote:
> On Mon, Aug 29, 2011 at 05:35:44PM -0700, Kevin D. Kissell wrote:
>> On 08/29/11 17:14, David Daney wrote:
>>> On 08/29/2011 04:55 PM, Kevin D. Kissell wrote:
>>>> I submitted that exact patch (David's more minimal version) in December
>>>> 2010 (and I did test it).  Did it not take?
>>> Evidently not.  Perhaps Ralf will see fit to commit it this time.
>> Looking back over the exchange and thinking about the date,
>> in all fairness to Ralf, when I submitted it, it was a diff -u and
>> not a git diff, because I was at my brother-in-law's house for
>> the holidays and had no access to my MIPS Linux git machine.
>> It got picked up by patchwork.linux-mips.org ( patch/1896 ),
>> but was only actually tested by Anoop a couple of days
>> later.  He confirmed that it solved the problem, but also that
>> there were other problems with SMTC in the then-current
>> head, apparently relating to timekeeping_notify().  Those
>> problems weren't resolved in the context of that email thread,
>> so the patch - something along the lines of which really and
>> truly is necessary - may have been ignored as a partial fix,
>> even though it is a self-contained solution to a self-contained bug.
> Interesting. Coincidentally, after getting pass the CP0_Status issue, I ran
> into some issues related to time-keeping, but I got the impression I was
> seeing a mix of problems with QEMU and possibly the kernel. I never hunted
> these issues down though. Maybe I'll give it a go some other time..
It could very well have been a QEMU issue.  At the time, I did spend
a while staring at the diffs between the working and non-working
kernel sources and I was unable to spot anything obviously suspect.
> It makes me wonder, what is the state of SMTC kernels? Are they widely
> used and considered stable?
> Or is the SMP mode (1 TC per VPE) the common choice?
The virtual SMP mode is far more common.  SMTC has the advantage
that it allows the maximum throughput to be extracted from a 34K
core - depending on the application/benchmark, the "sweet spot"
may be more than 2 concurrent threads - but it's less well maintained.

            Regards,

            Kevin K.
