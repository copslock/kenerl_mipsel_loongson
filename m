Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 20:59:59 +0200 (CEST)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:51851 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007982AbbFBS75ARMV4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 20:59:57 +0200
Received: from resomta-ch2-14v.sys.comcast.net ([69.252.207.110])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id bWyL1q0072PT3Qt01WzmtL; Tue, 02 Jun 2015 18:59:46 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-14v.sys.comcast.net with comcast
        id bWzk1q00A42s2jH01Wzk8q; Tue, 02 Jun 2015 18:59:46 +0000
Message-ID: <556DFD1A.7070802@gentoo.org>
Date:   Tue, 02 Jun 2015 14:59:38 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        markos.chandras@imgtec.com, macro@linux-mips.org,
        Steven.Hill@imgtec.com, alexander.h.duyck@redhat.com,
        davem@davemloft.net
Subject: Re: [PATCH 0/3] MIPS: SMP memory barriers: lightweight sync, acquire-release
References: <20150602000818.6668.76632.stgit@ubuntu-yegoshin> <556D6C31.3070500@gentoo.org> <20150602095920.GD29986@linux-mips.org>
In-Reply-To: <20150602095920.GD29986@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433271586;
        bh=ZzbAeqSvGj4tmfKSYC/OuN9A9vGhPum/iIhDSGnT6l0=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=YyRiTEGw4K7jN7dcW7gIcdPL5haBvEk1+tI9bDJceFYRhpRt/FQ3wyix+sXw2fNB7
         wRtrgQ/mQcOmFswLdlzmKrbinXnp6tPwQuugWUqyEomgM8qecSLAddBeZqPI0p3pPJ
         K3r3KSZLX60R7YrIpyPRjoAcqMWSPQgiwkCgy5rcwaMVhKA7WrrisLUmCVytDlewou
         UkTExwBkN8CSUnxiYFpuCXthOr33S68Y1R/EoE4U3ZAOHEODy/8jvyW2VSVxph5CEL
         jU8lxHD/9OUsq0/goNxb0HL4JKku+P7AEQe/kJPghhABoTuV3EzhVhdgtTmFNPeBt9
         BvJqU1tlTDi7w==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 06/02/2015 05:59, Ralf Baechle wrote:
> On Tue, Jun 02, 2015 at 04:41:21AM -0400, Joshua Kinard wrote:
> 
>> On 06/01/2015 20:09, Leonid Yegoshin wrote:
>>> The following series implements lightweight SYNC memory barriers for SMP Linux
>>> and a correct use of SYNCs around atomics, futexes, spinlocks etc LL-SC loops -
>>> the basic building blocks of any atomics in MIPS.
>>>
>>> Historically, a generic MIPS doesn't use memory barriers around LL-SC loops in
>>> atomics, spinlocks etc. However, Architecture documents never specify that LL-SC
>>> loop creates a memory barrier. Some non-generic MIPS vendors already feel
>>> the pain and enforces it. With introduction in a recent out-of-order superscalar
>>> MIPS processors an aggressive speculative memory read it is a problem now.
>>>
>>> The generic MIPS memory barrier instruction SYNC (aka SYNC 0) is something
>>> very heavvy because it was designed for propogating barrier down to memory.
>>> MIPS R2 introduced lightweight SYNC instructions which correspond to smp_*()
>>> set of SMP barriers. The description was very HW-specific and it was never
>>> used, however, it is much less trouble for processor pipelines and can be used
>>> in smp_mb()/smp_rmb()/smp_wmb() as is as in acquire/release barrier semantics.
>>> After prolonged discussions with HW team it became clear that lightweight SYNCs
>>> were designed specifically with smp_*() in mind but description is in timeline
>>> ordering space.
>>>
>>> So, the problem was spotted recently in engineering tests and it was confirmed
>>> with tests that without memory barrier load and store may pass LL/SC
>>> instructions in both directions, even in old MIPS R2 processors.
>>> Aggressive speculation in MIPS R6 and MIPS I5600 processors adds more fire to
>>> this issue.
>>>
>>> 3 patches introduces a configurable control for lightweight SYNCs around LL/SC
>>> loops and for MIPS32 R2 it was allowed to choose an enforcing SYNCs or not
>>> (keep as is) because some old MIPS32 R2 may be happy without that SYNCs.
>>> In MIPS R6 I chose to have SYNC around LL/SC mandatory because all of that
>>> processors have an agressive speculation and delayed write buffers. In that
>>> processors series it is still possible the use of SYNC 0 instead of
>>> lightweight SYNCs in configuration - just in case of some trouble in
>>> implementation in specific CPU. However, it is considered safe do not implement
>>> some or any lightweight SYNC in specific core because Architecture requires
>>> HW map of unimplemented SYNCs to SYNC 0.
>>
>> How useful might this be for older hardware, such as the R10k CPUs?  Just
>> fallbacks to the old sync insn?
> 
> The R10000 family is strongly ordered so there is no SYNC instruction
> required in the entire kernel even though some Origin hardware documentation
> incorrectly claims otherwise.

So no benefits even in the speculative execution case on noncoherent hardware
like IP28 and IP32?

--J
