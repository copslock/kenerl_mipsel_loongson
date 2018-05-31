Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 02:06:54 +0200 (CEST)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:54514 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994676AbeEaAGqmYIzc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2018 02:06:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GoviHrwN7e8AO6TnnGMqUD9sqS+cFSGHgRNpjOVmB1U=; b=03fyUlrXi5SiWampbA4moD8m7l
        kzpJQQKn6Z473c8s25c4qjN69njOvmxf+mR34BP3XYFOTQeZeguDdpMT21gj2m9RbdOhI8y2uPS6s
        bNIkRanip+34rDZ38xPJ6KR5IOVTF/yLCH/fLUArlP/d5Al8WPuk5N9e+jaubu4kgiP1xBiwvjErk
        X0nbuh24Q8gc0f2S/TZlunzzrdfFPiLIDf/Nob02Kyuekx/U3ljisSKtRB5DuCbhsRlPBL+yhrx5/
        DBQgLJLjG6IPl7m9ZEaLt5GJygVtTMPIZQRakroYhNKcaWidj028soJX1C/ebTQBYa4g8AeDqfFP0
        PoFVxZKw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fOB6r-0000CW-Ib; Thu, 31 May 2018 00:06:29 +0000
Subject: Re: [PATCH] kbuild: add machine size to CHEKCFLAGS
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Rob Landley <rob@landley.net>
References: <20180530204838.22079-1-luc.vanoostenryck@gmail.com>
 <d47b72cc-9209-a190-38b3-969870e1bf26@suse.de>
 <CAMHZB6GXVPvr1uwbemuxqPPtNzYT7jeVokR6q9tz2mS_=TG6vA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <01db7e93-89f3-361a-29c6-5146cda1d745@infradead.org>
Date:   Wed, 30 May 2018 17:06:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMHZB6GXVPvr1uwbemuxqPPtNzYT7jeVokR6q9tz2mS_=TG6vA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <rdunlap@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@infradead.org
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

On 05/30/2018 04:06 PM, Luc Van Oostenryck wrote:
> On Thu, May 31, 2018 at 12:00 AM, Andreas Färber <afaerber@suse.de> wrote:
>> Hi Luc,
>>
>> The typo in the subject made me curious...
>>
>> Am 30.05.2018 um 22:48 schrieb Luc Van Oostenryck:
>>> By default, sparse assumes a 64bit machine when compiled on x86-64
>>> and 32bit when compiled on anything else.
>>>
>>> This can of course create all sort of problems for the other archs, like
>>> issuing false warnings ('shift too big (32) for type unsigned long'), or
>>> worse, failing to emit legitimate warnings.
>>>
>>> Fix this by adding the -m32/-m64 flag, depending on CONFIG_64BIT,
>>> to CHECKFLAGS in the main Makefile (and so for all archs).
>>> Also, remove the now unneeded -m32/-m64 in arch specific Makefiles.
>>>
>>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>> ---
>>>  Makefile             | 3 +++
>>>  arch/alpha/Makefile  | 2 +-
>>>  arch/arm/Makefile    | 2 +-
>>>  arch/arm64/Makefile  | 2 +-
>>>  arch/ia64/Makefile   | 2 +-
>>>  arch/mips/Makefile   | 3 ---
>>>  arch/parisc/Makefile | 2 +-
>>>  arch/sparc/Makefile  | 2 +-
>>>  arch/x86/Makefile    | 2 +-
>>>  9 files changed, 10 insertions(+), 10 deletions(-)
>>
>> What about the architectures not touched by your patch that previously
>> had no -m32/-m64? (arc, c6x, h8300, hexagon, m68k, microblaze, nds32,
>> nios2, openrisc, powerpc, riscv, s390, sh, unicore32, xtensa)
> 
> As explained in the patch, by default sparse uses -m64 if compiled on x86-64
> and 32bit on everything else (well, more recent versions use -m64 if
> compiled on any 64 bit machine). I think that most ppc devs use a ppc
> machine and so ppc was most probably fine (at least ppc64) but I suspect
> that most of these others archs either had never sparse used on them
> or had a lot of wrong warnings. IOW, it was maybe OK but most probably
> incorrect for them and now it is OK.
> 
>> You forgot to CC them on this patch.
> 
> I didn't thought/knew  it was needed and the CC list is already
> quite long but, if needed, no problem for me.

Ideally, adding linux-arch@vger.kernel.org would be sufficient, but
sadly I have doubts about that.

>> Have you really checked that all their toolchains support the -m32/-m64
>> flags you newly introduce for them? Apart from non-biarch architectures,
>> I'm thinking of 31-bit s390 as a corner case where !64 != 32.
> 
> Hmm, there is no change to anything I call 'toolchain related', like
> compiler and linker. The only change is sparse (or any other checker)
> receiving now a correct and explicit -m32 or -m64.
> 
> For s390, as far as I know:
> 1) it has CONFIG_64BIT unconditionally definee (because the old 31bit
>    is no more supported, now everything is s390x only).
> 2) even if the *address space* was only 31 bit, I'm very sure
>    that sizeof(long) and sizeof(void*) was 4 on these machine
>    hence -m32 would have been correct.


-- 
~Randy
