Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 00:38:11 +0200 (CEST)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:39751
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994588AbeC1Wh7TF0Wx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 00:37:59 +0200
Received: by mail-it0-x242.google.com with SMTP id e98-v6so5560248itd.4;
        Wed, 28 Mar 2018 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nnpD6Ps7J34/xAmwZTUnUReer7G77oJS7ENxTSotV08=;
        b=aigf+O1PgjS3dxJyOf8t7Lm0ZgPdYHQlMdePggMWsJ/jdg9MZzRGlgJarLSCYVxP+K
         n7dnrIYm1joyITDwwSPkDum2kYTAn7hLzD9Gu5sjQu3qkYMDpMXmFfkoprRm7lXS63jI
         8YWWjLpf50VAfZZwScEPcEVdRbf8fdPgm6q7RJdbJ7QFGIZac6prr0c7PNkjceTwRzkZ
         Bkr9qgrwbKhd6OPkr+GF6wkX+GJz8hiNvVieAXSGgTU2ptbRNzuxEx6EpTZgC3eei0lc
         JIfTSlfRZ+TotFQFZAsb8HNwA/5ytWXgUI6TjXhob8XGv74TH8pltFflwOAq635rGdu0
         USoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nnpD6Ps7J34/xAmwZTUnUReer7G77oJS7ENxTSotV08=;
        b=ZIDpC14rpdWODdOtilH3wAU2mVTWxjVkk3XVuy3CpDN3XoR1ADU+OnDa3bUZid4Ixx
         tFofzKj4x2k5EKoIhSISQxNsbbuRp5sFrsT1J3UmoqBZLVLK/zV+W0yAnrUELoj/ys7l
         qyb2/0lPR9jeeOXO2G4CeLYT49gh09TfSFHLEV8cBRTT5NPa+ieTjm5YXbtXv4X2JfeM
         g9SDB9e882P7FjzU6W42Nj5qpcuDkZU9hSSV7mvzimZbGhglyqz8xEldM5AfDNiO12Bp
         bmB6EQaaw8sH6Oraxw0d6lMY7CdrlGS7DNe+jfuUvBYE03fpAFcfCVfMMPzYGauWja3s
         IZcQ==
X-Gm-Message-State: AElRT7FavbMJRdgOo2Z6fuNw/FldcaLE5DpsAPGE6VwVUZ2WXPzHr/Pq
        UHR+XUTVKMIpMXexKoEly6PRK+RAp3s2q6E3GNY=
X-Google-Smtp-Source: AIpwx49Tp5WOtIT8plg8EStL/Cdmar1UzEeBs4CuNuZHJkUufEESEMcUIZSsckiYwV/tePND2F0fGdU+RZ4AHKcml90=
X-Received: by 2002:a24:1bc4:: with SMTP id 187-v6mr5228042its.4.1522276672854;
 Wed, 28 Mar 2018 15:37:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.243.4 with HTTP; Wed, 28 Mar 2018 15:37:52 -0700 (PDT)
In-Reply-To: <20180328221401.GA14084@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com> <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net> <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net> <20180328221401.GA14084@n2100.armlinux.org.uk>
From:   Oliver <oohall@gmail.com>
Date:   Thu, 29 Mar 2018 09:37:52 +1100
Message-ID: <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Rob Landley <rob@landley.net>, Shea Levy <shea@shealevy.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <jhogan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Balbir Singh <bsingharora@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Perches <joe@perches.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <oohall@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63322
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oohall@gmail.com
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

On Thu, Mar 29, 2018 at 9:14 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
>>
>>
>> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
>> > On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
>> >> On 03/28/2018 10:26 AM, Shea Levy wrote:
>> >>> Now only those architectures that have custom initrd free requirements
>> >>> need to define free_initrd_mem.
>> >> ...
>> >>> --- a/arch/arc/mm/init.c
>> >>> +++ b/arch/arc/mm/init.c
>> >>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>> >>>  {
>> >>>   free_initmem_default(-1);
>> >>>  }
>> >>> -
>> >>> -#ifdef CONFIG_BLK_DEV_INITRD
>> >>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>> >>> -{
>> >>> - free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> >>> -}
>> >>> -#endif
>> >>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> >>> index 3f972e83909b..19d1c5594e2d 100644
>> >>> --- a/arch/arm/Kconfig
>> >>> +++ b/arch/arm/Kconfig
>> >>> @@ -47,6 +47,7 @@ config ARM
>> >>>   select HARDIRQS_SW_RESEND
>> >>>   select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>> >>>   select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>> >>> + select HAVE_ARCH_FREE_INITRD_MEM
>> >>>   select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>> >>>   select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>> >>>   select HAVE_ARCH_MMAP_RND_BITS if MMU
>> >>
>> >> Isn't this why weak symbols were invented?
>> >
>> > Weak symbols means that we end up with both the weakly-referenced code
>> > and the arch code in the kernel image.  That's fine if the weak code
>> > is small.
>>
>> The kernel's been able to build with link time garbage collection since 2016:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
>>
>> Wouldn't that remove the unused one?
>
> Probably, if anyone bothered to use that, which they don't.
>
> LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
> what I can see, nothing selects it.  Therefore, the symbol is always
> disabled, and so the feature never gets used in mainline kernels.
>
> Brings up the obvious question - why is it there if it's completely
> unused?  (Maybe to cause confusion, and allowing a justification
> for __weak ?)

IIRC Nick had some patches to do the arch enablement for powerpc, but
I'm not sure what happened to them though. I suspect it just fell down
Nick's ever growing TODO list.
