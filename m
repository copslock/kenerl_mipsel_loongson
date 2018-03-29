Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 17:44:01 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:37945
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeC2PnyoHo4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 17:43:54 +0200
Received: by mail-qk0-x244.google.com with SMTP id 132so6414047qkd.5;
        Thu, 29 Mar 2018 08:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NHAZZEXjkRfAu0OaItrJR1Fls26X0hu/wuX9yKcQkw8=;
        b=KsYle7dhbWXZB61S7KxYb1JLVNF/QvYOIFM/Rjd9mCI/rbulCQ2wQU26U0SnI8tCkF
         PHvayrx7urq45FoPJ3rHq++ySDl5TNcYwxJt/hpXaCfiXwy41DHdAVM2JAwAzREN6aiU
         FZP+3HGSJt7gzKv82EL+SCqoTgFwHVsPZzaFOMpZ+DtxwA+JFYv7ZlCYT430/jR8rxZH
         EwlNFGNfuVxBwjTxsMEFL/gG0eK8b+O9Ip4U7g2eX1NPcDbISWHGB/zLdwlFi0y8tVqz
         SJCkW355Np9Ed9Ht3CnyI6/UV1G/8VMHznQkXAdIqP0RoMM4IIZCHF8c+i/y7KyX1mR8
         d9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NHAZZEXjkRfAu0OaItrJR1Fls26X0hu/wuX9yKcQkw8=;
        b=BU9MpiDAKxIC4+RRMEQKPYPSA4CRF+jxDAOxNAtHCQ8RozlMgQFJ5Acu3pGoDHwfwT
         EFW6MCbMV1lJ4dNr9KpUVcgeP3NKzHSUOwyQidzWG1bIgfPezb/TMExww9ej7EOjYeRU
         5mDOWnvXjC+YK8jqP+ArMIkdFy5lmBwrysTXVcncr0wIe3S7kDJ7weDIyazRGnfW6NC2
         77w6xcJhw6Bv4MchEHNgPEyjhK/T9kScL+zS5sU0HFNd3dgvp0mGAfviSg9Q3BT41PuM
         S/rN8o5w7DM7CggONVn/bUismvBfbPyHKg2Se6+c7Wq07M0faiMxc9i7kbl2aBq+YWdG
         WR/Q==
X-Gm-Message-State: ALQs6tD7RBw8CICxVuodGILd+1tUqiXCXHukYfPAOkHtafHyrt7Zi5je
        o3VJpM8ShIFxm8MV4xPV4q9Pwcq5Os0SkgIHqXQ=
X-Google-Smtp-Source: AIpwx49JBd3+SBMgHXCH8d7Idg12FurIjLqmPTmIhI/z7T+oUxi95TuzVNqjMJDng2+WbzjQYp6HlMO+wJtMk4xMh60=
X-Received: by 10.55.8.147 with SMTP id 141mr11797210qki.228.1522338228247;
 Thu, 29 Mar 2018 08:43:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.54.147 with HTTP; Thu, 29 Mar 2018 08:43:47 -0700 (PDT)
In-Reply-To: <20180329152749.GC16141@n2100.armlinux.org.uk>
References: <20180325221853.10839-1-shea@shealevy.com> <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net> <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net> <20180328221401.GA14084@n2100.armlinux.org.uk>
 <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com> <20180329152749.GC16141@n2100.armlinux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 29 Mar 2018 17:43:47 +0200
X-Google-Sender-Auth: XR_k5aiSoT5iFZQuDvDX6ovvWKU
Message-ID: <CAMuHMdXAckNiUQKT2WU6xaJjbECrifmH6fg_mET+h3iXf_RgDQ@mail.gmail.com>
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Oliver <oohall@gmail.com>, Rob Landley <rob@landley.net>,
        Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "moderated list:PANASONIC MN10300..." <linux-am33-list@redhat.com>,
        nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        uml-devel <user-mode-linux-devel@lists.sourceforge.net>,
        uml-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-xtensa@linux-xtensa.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Thu, Mar 29, 2018 at 5:27 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Mar 29, 2018 at 09:37:52AM +1100, Oliver wrote:
>> On Thu, Mar 29, 2018 at 9:14 AM, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>> > On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
>> >> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
>> >> > On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
>> >> >> On 03/28/2018 10:26 AM, Shea Levy wrote:
>> >> >>> Now only those architectures that have custom initrd free requirements
>> >> >>> need to define free_initrd_mem.
>> >> >> ...
>> >> >>> --- a/arch/arc/mm/init.c
>> >> >>> +++ b/arch/arc/mm/init.c
>> >> >>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>> >> >>>  {
>> >> >>>   free_initmem_default(-1);
>> >> >>>  }
>> >> >>> -
>> >> >>> -#ifdef CONFIG_BLK_DEV_INITRD
>> >> >>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>> >> >>> -{
>> >> >>> - free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> >> >>> -}
>> >> >>> -#endif
>> >> >>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> >> >>> index 3f972e83909b..19d1c5594e2d 100644
>> >> >>> --- a/arch/arm/Kconfig
>> >> >>> +++ b/arch/arm/Kconfig
>> >> >>> @@ -47,6 +47,7 @@ config ARM
>> >> >>>   select HARDIRQS_SW_RESEND
>> >> >>>   select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>> >> >>>   select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>> >> >>> + select HAVE_ARCH_FREE_INITRD_MEM
>> >> >>>   select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>> >> >>>   select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>> >> >>>   select HAVE_ARCH_MMAP_RND_BITS if MMU
>> >> >>
>> >> >> Isn't this why weak symbols were invented?
>> >> >
>> >> > Weak symbols means that we end up with both the weakly-referenced code
>> >> > and the arch code in the kernel image.  That's fine if the weak code
>> >> > is small.
>> >>
>> >> The kernel's been able to build with link time garbage collection since 2016:
>> >>
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
>> >>
>> >> Wouldn't that remove the unused one?
>> >
>> > Probably, if anyone bothered to use that, which they don't.
>> >
>> > LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
>> > what I can see, nothing selects it.  Therefore, the symbol is always
>> > disabled, and so the feature never gets used in mainline kernels.
>> >
>> > Brings up the obvious question - why is it there if it's completely
>> > unused?  (Maybe to cause confusion, and allowing a justification
>> > for __weak ?)
>>
>> IIRC Nick had some patches to do the arch enablement for powerpc, but
>> I'm not sure what happened to them though. I suspect it just fell down
>> Nick's ever growing TODO list.
>
> I've given it a go on ARM, marking every linker-built table with KEEP()
> and comparing the System.map files.  The resulting kernel is around
> 150k smaller, which seems good.
>
> However, it doesn't boot - and I don't know why.  Booting the kernel
> under kvmtool in a VM using virtio-console, I can find no way to get
> any kernel messages out of it.  Using lkvm debug, I can see that the
> PC is stuck inside die(), and that's the only information I have.
> It dies before bringing up the other CPUs, so it's a very early death.
>
> I don't think other console types are available under ARM64.

earlycon?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
