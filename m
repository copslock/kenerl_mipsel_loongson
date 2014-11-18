Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2014 01:11:43 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20573 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013887AbaKRALmIywAT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Nov 2014 01:11:42 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B8B3C98A69F9D;
        Tue, 18 Nov 2014 00:11:31 +0000 (GMT)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 18 Nov
 2014 00:11:35 +0000
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by klmail02.kl.imgtec.org
 (10.40.60.222) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 18 Nov
 2014 00:11:35 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 17 Nov
 2014 16:11:31 -0800
Message-ID: <546A8EB3.3040504@imgtec.com>
Date:   Mon, 17 Nov 2014 16:11:31 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@codesourcery.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: MIPS: c-r4k.c: Fix the 74K D-cache alias erratum workaround
References: <546A56C9.4060608@imgtec.com> <alpine.DEB.1.10.1411172321110.2881@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.1.10.1411172321110.2881@tp.orcam.me.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 11/17/2014 03:29 PM, Maciej W. Rozycki wrote:
> On Mon, 17 Nov 2014, Leonid Yegoshin wrote:
>
>>> Fix the 74K D-cache alias erratum workaround so that it actually works.
>>> Our current code sets MIPS_CACHE_VTAG for the D-cache, but that flag
>>> only has any effect for the I-cache.  Additionally MIPS_CACHE_PINDEX is
>>> set for the D-cache if CP0.Config7.AR is also set for an affected
>>> processor, leading to confusing information in the bootstrap log (the
>>> flag isn't used beyond that).
>>> So delete the setting of MIPS_CACHE_VTAG and rely on MIPS_CACHE_ALIASES,
>>> set in a common place, removing I-cache coherency issues seen in GDB
>>> testing with software breakpoints, gdbserver and ptrace(2), on affected
>>> systems.
>>> While at it add a little piece of explanation of what CP0.Config6.SYND
>>> is so that people do not have to chase documentation.
>> This shift to MIPS_CACHE_ALIASES is not needed, a use of MIPS_CACHE_VTAG in
>> dcache is actually a way how to prevent some very specific situations in
>> 74K(E77)/1074K(E17) cache handling. It is not a case of cache aliasing and
>> name VTAG is used because it is related with virtual address conversion
>> tagging. I reused MIPS_CACHE_VTAG just to save some spare bits in
>> cpu_info.options and because D-cache never had virtual tagging like I-cache.
>>
>> The setting d-cache aliases then CPU hasn't it is a significant performance
>> loss and should be avoided.
>>
>> Please don't use this patch.
>   I repeat, there is no use in the current kernel of the MIPS_CACHE_VTAG
> flag for the D-cache, there's no single piece of code throughout the
> kernel that would check the presence of this flag once it has been set
> and this erratum workaround piece is the only place where the flag is
> set for the D-cache.  The flag is completely ignored for the D-cache and
> the only existing uses of this flag are for the I-cache.

Please look into http://patchwork.linux-mips.org/patch/8459/
Look into cpu_has_vtag_dcache usage.
It is a second or 2rd (or 3rd etc) attempt to put using of that 
information upstream for last 1.5 year.

>
>   Leonid, I spent several hours chasing cache coherency issues util I
> realised the workaround in its current form does not do anything, so
> unless you propose an alternative fix, this change is the only way known
> to bring systems affected to sanity.

You may ask me, I work last 3 years in MIPS (now IMG) on it and did a 
most of coherency fixes all that time.

- Leonid.

>
>   Ralf, please apply the change for now, if Leonid provides us with a
> better fix later on, then my patch can be reverted.  Thanks.
>
>    Maciej
