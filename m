Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 00:37:09 +0200 (CEST)
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:4221
        "EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822681Ab3EVWhEKb0Lm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 00:37:04 +0200
Received: from mail131-ch1-R.bigfish.com (10.43.68.239) by
 CH1EHSOBE008.bigfish.com (10.43.70.58) with Microsoft SMTP Server id
 14.1.225.23; Wed, 22 May 2013 22:36:57 +0000
Received: from mail131-ch1 (localhost [127.0.0.1])      by
 mail131-ch1-R.bigfish.com (Postfix) with ESMTP id B0B48409F1;  Wed, 22 May
 2013 22:36:57 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:132.245.2.69;KIP:(null);UIP:(null);IPV:NLI;H:BN1PRD0712HT004.namprd07.prod.outlook.com;RD:none;EFVD:NLI
X-SpamScore: -4
X-BigFish: PS-4(zzbb2dI98dI9371I1432Izz1f42h1ee6h1de0h1fdah1202h1e76h1d1ah1d2ah1fc6hzz17326ah8275bh8275dhz2dh2a8h668h839h947hd25he5bhf0ah1288h12a5h12a9h12bdh137ah13b6h1441h14ddh1504h1537h153bh162dh1631h1758h1765h18e1h190ch1946h19b4h19c3h19ceh1ad9h1b0ah1d0ch1d2eh1d3fh1155h)
Received: from mail131-ch1 (localhost.localdomain [127.0.0.1]) by mail131-ch1
 (MessageSwitch) id 1369262215804633_17214; Wed, 22 May 2013 22:36:55 +0000
 (UTC)
Received: from CH1EHSMHS027.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.229])        by mail131-ch1.bigfish.com (Postfix) with ESMTP id
 BFE4F26006F;   Wed, 22 May 2013 22:36:55 +0000 (UTC)
Received: from BN1PRD0712HT004.namprd07.prod.outlook.com (132.245.2.69) by
 CH1EHSMHS027.bigfish.com (10.43.70.27) with Microsoft SMTP Server (TLS) id
 14.1.225.23; Wed, 22 May 2013 22:36:55 +0000
Received: from dl.caveonetworks.com (64.2.3.195) by pod51018.outlook.com
 (10.255.196.37) with Microsoft SMTP Server (TLS) id 14.16.311.1; Wed, 22 May
 2013 22:36:55 +0000
Message-ID: <519D4883.9050905@caviumnetworks.com>
Date:   Wed, 22 May 2013 15:36:51 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     David Daney <ddaney.cavm@gmail.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH] MIPS: Enable interrupts before WAIT instruction.
References: <CA+55aFwDGyHOzu=Qh7SJOBK6QvAwAh7pMDL6LfMUE=AW_kapAw@mail.gmail.com> <1367527692-25809-1-git-send-email-ddaney.cavm@gmail.com> <20130522223225.GH31836@blackmetal.musicnaut.iki.fi>
In-Reply-To: <20130522223225.GH31836@blackmetal.musicnaut.iki.fi>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 05/22/2013 03:32 PM, Aaro Koskinen wrote:
> Hi,
>
> On Thu, May 02, 2013 at 01:48:12PM -0700, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> As noted by Thomas Gleixner:
>>
>>     commit cdbedc61c8 (mips: Use generic idle loop) broke MIPS as I did
>>     not realize that MIPS wants to invoke the wait instructions with
>>     interrupts enabled.
>>
>> Instead of enabling interrupts in arch_cpu_idle() as Thomas' initial
>> patch does, we follow Linus' suggestion of doing it in the assembly
>> code to prevent the compiler from rearranging things.
>>
>> Signed-off-by: David Daney <david.daney@cavium.com>
>> Reported-by: EunBong Song <eunb.song@samsung.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jonas Gorski <jogo@openwrt.org>
>> ---
>>
>> This is only very lightly tested, we need more testing before
>> declaring it the definitive fix.
>
> I wonder what is the status of this patch? Or is there some alternative
> fix?
>
> I have Octeon+ board that hangs during 3.10-rc2 boot in spawn_ksoftirqd()
> without this. Also, this patch does not apply cleanly to 3.10-rc2
> anymore...
>
> A.
>

Ralf has an alternate fix here:

http://git.linux-mips.org/pub/scm/ralf/upstream-linus.git

If all goes well, it will be merged soon.

David Daney
