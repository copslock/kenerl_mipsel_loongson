Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 01:07:07 +0200 (CEST)
Received: from mail-vk0-x242.google.com ([IPv6:2607:f8b0:400c:c05::242]:42934
        "EHLO mail-vk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994674AbeE3XHAe9WQQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 May 2018 01:07:00 +0200
Received: by mail-vk0-x242.google.com with SMTP id s187-v6so375344vke.9;
        Wed, 30 May 2018 16:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=07aXHtt9Oy/CtH/eFeOA82JbgRI6LuaMmZ8NxzSnisw=;
        b=vAYeJp1g8XSm04eNyxPffG0CBOvPNwvv4YhhefUxMN83K2rxgN8KJzUmp03sGRNrLO
         K+UzT0kG3vy01VVZWQdoqhoxFOvsqrhZxKx3Tmt6Wy0k6kJjyeOu2Kvy7swdEyWeZerH
         WGBvPv53OGBIoL2vMeYLcd/ta3ix3qKUtXsYax8uvsLzlifZ2cdc+9U9xQvCJi8rVRQ6
         GDTLlH9k2OJ9AEQ1Te34TzlbVVy0kVqHOIBWnAB28q2zb7O87hewxHrEmVPRXhixuhmx
         rNWDGWhXvQJBBZyawa62+QERFeGtPCT4iEusgtvsG/G9jJ5NZtBRLWdNy9ISKapXOyQX
         uYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=07aXHtt9Oy/CtH/eFeOA82JbgRI6LuaMmZ8NxzSnisw=;
        b=j7I9i6OEGKVZJl1UgTjLaPBMJ17IctdyXNrOOQhe1Tzh+WCXnI0lww+oPPMQno8sZJ
         4xlA0R6kI1yFPbFQ582vlGuVj5I2iOHqiwdzqVZIb6YxcTzrD7kEfjppYEycLqUrgmmg
         j+6ZdTEb7A6rPmbnMtLXNF050y1Foiv+Cnc9L1EKQkWO6T4oA/ddn5wh1X//V0U3fXp/
         hMqj12PypIgvPpsTxLdtQhnp1Ic41x37JlhsIgxlQ5gGwB048Rp2RT2waaIdQrMd91aR
         vUyhUaaxMdHl7MJNSlAE3LPtZYD6BNSHf+1EnptoFz+NvzvgXBeyJd5RTQ9oXIHcW2X8
         80Lg==
X-Gm-Message-State: ALKqPweoCg47LaBgt0XbnWRSiuH+siEIDJUs9dcl1zroLvvley7SsSpk
        qz6ubaFUjwZkv3rDqKS+fkxL6evTSE29KWq2YJ4=
X-Google-Smtp-Source: ADUXVKJCOZAnYMMJKDJjLPSWiuvcxdhQ3lyHgVqnp9jh/Ip4fjFUU0EeVNqmSTDY9BrpIzWkXItfZul3n9NIHf/iw/A=
X-Received: by 2002:a1f:a0d6:: with SMTP id j205-v6mr2708778vke.23.1527721614209;
 Wed, 30 May 2018 16:06:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3012:0:0:0:0:0 with HTTP; Wed, 30 May 2018 16:06:53
 -0700 (PDT)
In-Reply-To: <d47b72cc-9209-a190-38b3-969870e1bf26@suse.de>
References: <20180530204838.22079-1-luc.vanoostenryck@gmail.com> <d47b72cc-9209-a190-38b3-969870e1bf26@suse.de>
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date:   Thu, 31 May 2018 01:06:53 +0200
Message-ID: <CAMHZB6GXVPvr1uwbemuxqPPtNzYT7jeVokR6q9tz2mS_=TG6vA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add machine size to CHEKCFLAGS
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Rob Landley <rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <luc.vanoostenryck@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luc.vanoostenryck@gmail.com
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

On Thu, May 31, 2018 at 12:00 AM, Andreas Färber <afaerber@suse.de> wrote:
> Hi Luc,
>
> The typo in the subject made me curious...
>
> Am 30.05.2018 um 22:48 schrieb Luc Van Oostenryck:
>> By default, sparse assumes a 64bit machine when compiled on x86-64
>> and 32bit when compiled on anything else.
>>
>> This can of course create all sort of problems for the other archs, like
>> issuing false warnings ('shift too big (32) for type unsigned long'), or
>> worse, failing to emit legitimate warnings.
>>
>> Fix this by adding the -m32/-m64 flag, depending on CONFIG_64BIT,
>> to CHECKFLAGS in the main Makefile (and so for all archs).
>> Also, remove the now unneeded -m32/-m64 in arch specific Makefiles.
>>
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> ---
>>  Makefile             | 3 +++
>>  arch/alpha/Makefile  | 2 +-
>>  arch/arm/Makefile    | 2 +-
>>  arch/arm64/Makefile  | 2 +-
>>  arch/ia64/Makefile   | 2 +-
>>  arch/mips/Makefile   | 3 ---
>>  arch/parisc/Makefile | 2 +-
>>  arch/sparc/Makefile  | 2 +-
>>  arch/x86/Makefile    | 2 +-
>>  9 files changed, 10 insertions(+), 10 deletions(-)
>
> What about the architectures not touched by your patch that previously
> had no -m32/-m64? (arc, c6x, h8300, hexagon, m68k, microblaze, nds32,
> nios2, openrisc, powerpc, riscv, s390, sh, unicore32, xtensa)

As explained in the patch, by default sparse uses -m64 if compiled on x86-64
and 32bit on everything else (well, more recent versions use -m64 if
compiled on any 64 bit machine). I think that most ppc devs use a ppc
machine and so ppc was most probably fine (at least ppc64) but I suspect
that most of these others archs either had never sparse used on them
or had a lot of wrong warnings. IOW, it was maybe OK but most probably
incorrect for them and now it is OK.

> You forgot to CC them on this patch.

I didn't thought/knew  it was needed and the CC list is already
quite long but, if needed, no problem for me.

> Have you really checked that all their toolchains support the -m32/-m64
> flags you newly introduce for them? Apart from non-biarch architectures,
> I'm thinking of 31-bit s390 as a corner case where !64 != 32.

Hmm, there is no change to anything I call 'toolchain related', like
compiler and linker. The only change is sparse (or any other checker)
receiving now a correct and explicit -m32 or -m64.

For s390, as far as I know:
1) it has CONFIG_64BIT unconditionally definee (because the old 31bit
   is no more supported, now everything is s390x only).
2) even if the *address space* was only 31 bit, I'm very sure
   that sizeof(long) and sizeof(void*) was 4 on these machine
   hence -m32 would have been correct.

Best regards,
-- Luc
