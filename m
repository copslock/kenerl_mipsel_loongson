Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 20:21:16 +0200 (CEST)
Received: from gateway02.websitewelcome.com ([67.18.53.20]:35397 "HELO
        gateway02.websitewelcome.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1491160Ab1INSVJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2011 20:21:09 +0200
Received: (qmail 30190 invoked from network); 14 Sep 2011 17:20:30 -0000
Received: from ham.websitewelcome.com (HELO ham01.websitewelcome.com) (173.192.111.52)
  by gateway02.websitewelcome.com with SMTP; 14 Sep 2011 17:20:30 -0000
Received: by ham01.websitewelcome.com (Postfix, from userid 666)
        id 4EF98CE93B9B2; Wed, 14 Sep 2011 13:20:19 -0500 (CDT)
Received: from gator750.hostgator.com (gator750.hostgator.com [174.132.194.2])
        by ham01.websitewelcome.com (Postfix) with ESMTP id 15248CE93B918
        for <linux-mips@linux-mips.org>; Wed, 14 Sep 2011 13:20:19 -0500 (CDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:X-Enigmail-Version:Content-Type:Content-Transfer-Encoding:X-BWhitelist:X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:X-Email-Count:X-Source-Cap;
        b=FmH9JnQ/XEI4TJyt0u/7/LMh8XSrDD4TKA523R1w1hFWyDKeUSnsbDymdaOn4JLP2lLbRUE9jZDyEgi4e7HeVVkDF/9ZQLXw6y/HRcK/NuVau5cCiqlQ/RFT1yI+7XSQ;
Received: from [216.239.45.4] (port=61985 helo=kkissell.mtv.corp.google.com)
        by gator750.hostgator.com with esmtpa (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1R3u47-0007G1-DR; Wed, 14 Sep 2011 13:20:12 -0500
Message-ID: <4E70F055.9020807@paralogos.com>
Date:   Wed, 14 Sep 2011 11:20:05 -0700
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Thunderbird/3.1.13
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: SMTC: Correct saving of CP0_STATUS
References: <20110829232029.GA15763@zapo> <4E5C2490.6040203@cavium.com> <4E5C26D4.3000906@paralogos.com> <4E5C2B62.9040007@cavium.com> <4E5C3060.70302@paralogos.com> <20110830111603.GB14243@edde.se.axis.com> <4E5D15DD.2020201@paralogos.com> <20110914151227.GA13290@linux-mips.org>
In-Reply-To: <20110914151227.GA13290@linux-mips.org>
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
X-Source-Sender: 216-239-45-4.google.com (kkissell.mtv.corp.google.com) [216.239.45.4]:61985
X-Source-Auth: kevink@kevink.net
X-Email-Count: 1
X-Source-Cap: a2tpc3NlbGw7a2tpc3NlbGw7Z2F0b3I3NTAuaG9zdGdhdG9yLmNvbQ==
X-archive-position: 31081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7347

On 09/14/11 08:12, Ralf Baechle wrote:
> On Tue, Aug 30, 2011 at 09:54:53AM -0700, Kevin D. Kissell wrote:
>
>> It could very well have been a QEMU issue.  At the time, I did spend
>> a while staring at the diffs between the working and non-working
>> kernel sources and I was unable to spot anything obviously suspect.
>>> It makes me wonder, what is the state of SMTC kernels? Are they widely
>>> used and considered stable?
>>> Or is the SMP mode (1 TC per VPE) the common choice?
>> The virtual SMP mode is far more common.  SMTC has the advantage
>> that it allows the maximum throughput to be extracted from a 34K
>> core - depending on the application/benchmark, the "sweet spot"
>> may be more than 2 concurrent threads - but it's less well maintained.
> Not to mention that SMTC was developed for a single 34K core.  It has
> never been pimped up to support multi-core systems such as the 1004K
> which would add some considerable complexity.
SMTC was only *run* on single 34K cores, but the design was
done keeping in mind the possibility that a multi-MT-core
configuration might be built.  The main thing that would need
to be done would be to add startup code that would make the
first TC/VPE of the second (and subsequent) cores recognize
that they are secondary CPUs and follow the same code path
as the non-zeroth TC/VPE in the single-core configuration.  One
would also need to do "real" IPIs between cores, which is anyway
what the actual production parts with 34Ks in them do (as opposed
to what we had to do on the FPGA prototypes).

The 1004K, as I understand it, was designed with exactly 2 VPEs
and 2 TCs, and unless there's an option in the core configuration
to synthesize it with more TCs per VPE (>2 TCs or <2 VPEs), SMTC
would not be meaningful.  Even if you could build a single-VPE
1004K with 2 TCs, the area savings would be relatively small
and would have to be balanced against the small per-TC
kernel performance hit of going to SMTC.  SMTC rocks when
you  can put 3 or 4 TCs in a single VPE, so that the better
utilization of functional units has a chance to more than
make up for the SMTC efficiency hit in kernel mode.

            Regards,

            Kevin K.
