Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Apr 2016 16:05:15 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51596 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27024907AbcDBOFN6Lm9V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Apr 2016 16:05:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=utvXcWhArxUK9QWeW/uwcHq5SIQFeDgCvTOPNXZg2s0=; b=p80T4QK82lDIQXzOBmeuUn6GO0
        JzeuJhYqWCsMzTANwc0pW7Y3cPGZTsuCLWFOlOrgT9Y4W+vqqF3dUFg2PtM0qjoquteQ42Irdzby7
        MtvQwnW0YqsaFA7kVQBCLSaWn2ei3K2TMq9hCyDSNLy8/Sl/SzHX1yy33hMWXFrOJIMMTiIweDqPr
        wfpUduo+wpajXFFoWQFT8WLAOmxzlnnL9o5JiTIl/w8uuKTV+X219X9Tyv6BzxiLG9gZN1f0WO0Sh
        GKZtFVaAEFOHRO0ujSqQbylqpvvNMdKTE6dBXfsjAbaqaEgo6FsH8spiyoKx41U10jVXPekEBWNik
        fs2Es1kg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37854 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1amMAh-002XjN-7U; Sat, 02 Apr 2016 14:05:03 +0000
Subject: Re: [PATCH] MIPS: Fix broken malta qemu
To:     Qais Yousef <qsyousef@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>, ralf@linux-mips.org
References: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
 <20160401124852.GA5145@NP-P-BURTON> <56FFB8B7.8050607@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <56FFD191.70606@roeck-us.net>
Date:   Sat, 2 Apr 2016 07:05:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56FFB8B7.8050607@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 04/02/2016 05:19 AM, Qais Yousef wrote:
> Hi Paul,
>
> On 01/04/2016 13:48, Paul Burton wrote:
>> On Thu, Mar 17, 2016 at 09:08:09PM +0000, Qais Yousef wrote:
>>> Malta defconfig compiles with GIC on. Hence when compiling for SMP it causes the
>>> new IPI code to be activated. But on qemu malta there's no GIC causing a
>>> BUG_ON(!ipidomain) to be hit in mips_smp_ipi_init().
>>>
>>> Since in that configuration one can only run a single core SMP (!), skip IPI
>>> initialisation if we detect that this is the case. It is a sensible behaviour
>>> to introduce and should keep such possible configuration to run rather than die
>>> hard unnecessarily.
>> Hi Qais/Ralf,
>>
>> This patch is insufficient I'm afraid. It's entirely possible to use SMP
>> with multiple VPEs in a single core on Malta boards that don't have a
>> GIC - we have code handling IPIs in that case guarded by #ifdef
>> CONFIG_MIPS_MT_SMP in arch/mips/mti-malta/malta-int.c. I think the
>> BUG_ON needs to be removed entirely, unless that single-core multi-VPE
>> IPI code is also converted to use an IPI irqdomain.
>>
>
> I was under the impression that SMP is only supported under GIC and older forms of SMP are deprecated.
>
> I think the problem you're describing is different to the one this is trying to fix. The right fix for your issue is to make CONFIG_GENERIC_IRQ_IPI selected when CONFIG_MIPS_GIC && !CONFIG_MIPS_MT_SMP.
>
Didn't Paul say that his system doesn't have a GIC ? Are you saying that he can not
(or no longer) run an image built for SMP on his system ?

Guenter
