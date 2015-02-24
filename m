Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 22:06:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24788 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007145AbbBXVGaOZxDH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 22:06:30 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id ACFFC3F5B4ADE;
        Tue, 24 Feb 2015 21:06:21 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 24 Feb
 2015 21:06:24 +0000
Received: from [192.168.65.146] (192.168.65.146) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 24 Feb
 2015 13:06:22 -0800
Message-ID: <54ECE7CE.4040407@imgtec.com>
Date:   Tue, 24 Feb 2015 13:06:22 -0800
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Zenon Fortuna <zenon.fortuna@imgtec.com>
CC:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "IMG - MIPS Linux Kernel developers" 
        <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        "Linux MIPS Mailing List" <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with non-DMA
 I/O.
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com> <54EBCC38.7000702@imgtec.com> <54EBD023.8090706@imgtec.com> <alpine.LFD.2.11.1502240224500.17311@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1502240224500.17311@eddie.linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.65.146]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45934
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

On 02/23/2015 06:33 PM, Maciej W. Rozycki wrote:
> On Mon, 23 Feb 2015, Zenon Fortuna wrote:
>
>> Does the current system-call "cacheflush(2)" works with the newer kernels?
>> As the "man cacheflush" tells, it was supposed to work only on MIPS based
>> systems.
>   It absolutely has to work, on the MIPS target GCC emits code invoking it
> to synchronise trampolines built at the run time on the stack (used for
> calling nested functions, a C language extension borrowed from Pascal,
> etc.), before passing execution there.  Verification of this syscall is
> probably implicitly covered by the GCC test suite already.
>
>    Maciej
cacheflush() syscall traps into kernel and it executes I and D caches 
flushing.

However, it's implementation in 'master' branch from Linus tree is 
wrong: if you call it in multicore environment for size > L1 cache size 
then it does it incorrectly: doesn't call IPI for index cacheops.

The correct way is ... sorry, can't find it in LMO...

- Leonid.
