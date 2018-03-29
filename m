Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 02:24:51 +0200 (CEST)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:43313
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994609AbeC2AYoCaq0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 02:24:44 +0200
Received: by mail-pf0-x242.google.com with SMTP id j2so1984361pff.10;
        Wed, 28 Mar 2018 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=1aHvF+/o9u7qLZBbapy+0C3MfWrHZUjomN2+wy/GqQs=;
        b=cBzpUlxeIz0yaLavx7VMt6I8SOXRgLDnHq7D+LU+Sm9aJsf1nrftAZylyALMLaIlrV
         M8Es6Lo9dutJiB6TWhne/BQJEaj1ORmgeDjPM5zalgx9GoZQu67HnMdaGNacQCouY2tk
         y31KehkJwkk4SUuElPYG8tBx2VmTI0v2+Z9WVNRrbb4ea6Wq77exe5UNTC4ZvGus9mTz
         ZuwVx2sKEz+USB+tAS1hXRzEnNCaIpJXbtMRLAYW1Q3sels8pV+GXGbaPwl+2dWX0CH5
         1iPC7R/AbznQ4dOuV07+dQW7Od+qz7TXIiebDDzai+y7r6nXeNnb7uVdnj7cNhPr/1ac
         /x7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=1aHvF+/o9u7qLZBbapy+0C3MfWrHZUjomN2+wy/GqQs=;
        b=UTsoQ/zfFCkW/vaMbPQ5i+0mJ1TEKundUVDtRQkPzynTxzlm1c7maoy3dYoVUYm9C+
         TxolrjysexeWSNH+kbfFfZrNJw8hAm811JOUd+FUTqpQWdOzCKxWw7ud3HGWXdoqbGwY
         f5oalO8Tk16vBH+VRzxfFTVflj5IOmsVFnYCawwsmjSPZVpxCGRO1/tHsbrumjyZUPe5
         LVwBkrvwWaA1e3iPE32B4fgSr6LB2ocNLlMzzKpGHINYfVkYHMlhLrh9JWwgQNfMaKkz
         /B4awmFHJNZ7sw6+fHC+z/xRGgEwZ9gDaPtBu0pakle4SiR7YAqmEehsvrN0xlQwab/P
         AUfw==
X-Gm-Message-State: AElRT7Hh9uIrOaV5hWKw+IVBY8aDIU3kgWmF8fLp6x+cBd3/Tjcl4Uyi
        dY+tgaLjP9VM5c4/Tw/0bfA=
X-Google-Smtp-Source: AIpwx48hzNQ+MLw+gacB7OdQlR82up9ybkIamX1AdwJfzQ5vwYP/k6rsD1tHrC2aq025xRP3mirpnA==
X-Received: by 10.99.135.199 with SMTP id i190mr3940018pge.2.1522283076292;
        Wed, 28 Mar 2018 17:24:36 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-70-78.tpgi.com.au. [59.102.70.78])
        by smtp.gmail.com with ESMTPSA id s4sm8189641pgp.29.2018.03.28.17.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 17:24:35 -0700 (PDT)
Date:   Thu, 29 Mar 2018 10:23:33 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Oliver <oohall@gmail.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Rob Landley <rob@landley.net>, Shea Levy <shea@shealevy.com>,
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
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
Message-ID: <20180329102333.6aa542b9@roar.ozlabs.ibm.com>
In-Reply-To: <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
References: <20180325221853.10839-1-shea@shealevy.com>
        <20180328152714.6103-1-shea@shealevy.com>
        <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
        <20180328164813.GA3888@n2100.armlinux.org.uk>
        <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
        <20180328221401.GA14084@n2100.armlinux.org.uk>
        <CAOSf1CG8gQjoL5rDMRMcZp=D8jBEQ9JBSG68=CiXnitC+4Kjvg@mail.gmail.com>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <npiggin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: npiggin@gmail.com
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

On Thu, 29 Mar 2018 09:37:52 +1100
Oliver <oohall@gmail.com> wrote:

> On Thu, Mar 29, 2018 at 9:14 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:  
> >>
> >>
> >> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:  
> >> > On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:  
> >> >> On 03/28/2018 10:26 AM, Shea Levy wrote:  
> >> >>> Now only those architectures that have custom initrd free requirements
> >> >>> need to define free_initrd_mem.  
> >> >> ...  
> >> >>> --- a/arch/arc/mm/init.c
> >> >>> +++ b/arch/arc/mm/init.c
> >> >>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
> >> >>>  {
> >> >>>   free_initmem_default(-1);
> >> >>>  }
> >> >>> -
> >> >>> -#ifdef CONFIG_BLK_DEV_INITRD
> >> >>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
> >> >>> -{
> >> >>> - free_reserved_area((void *)start, (void *)end, -1, "initrd");
> >> >>> -}
> >> >>> -#endif
> >> >>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> >>> index 3f972e83909b..19d1c5594e2d 100644
> >> >>> --- a/arch/arm/Kconfig
> >> >>> +++ b/arch/arm/Kconfig
> >> >>> @@ -47,6 +47,7 @@ config ARM
> >> >>>   select HARDIRQS_SW_RESEND
> >> >>>   select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
> >> >>>   select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> >> >>> + select HAVE_ARCH_FREE_INITRD_MEM
> >> >>>   select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> >> >>>   select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
> >> >>>   select HAVE_ARCH_MMAP_RND_BITS if MMU  
> >> >>
> >> >> Isn't this why weak symbols were invented?  
> >> >
> >> > Weak symbols means that we end up with both the weakly-referenced code
> >> > and the arch code in the kernel image.  That's fine if the weak code
> >> > is small.  
> >>
> >> The kernel's been able to build with link time garbage collection since 2016:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d
> >>
> >> Wouldn't that remove the unused one?  
> >
> > Probably, if anyone bothered to use that, which they don't.
> >
> > LD_DEAD_CODE_DATA_ELIMINATION is a symbol without a prompt, and from
> > what I can see, nothing selects it.  Therefore, the symbol is always
> > disabled, and so the feature never gets used in mainline kernels.
> >
> > Brings up the obvious question - why is it there if it's completely
> > unused?  (Maybe to cause confusion, and allowing a justification
> > for __weak ?)  

Well weak symbols have been used long before it was added.

> IIRC Nick had some patches to do the arch enablement for powerpc, but
> I'm not sure what happened to them though. I suspect it just fell down
> Nick's ever growing TODO list.

Yeah I had started some patches for powerpc and x86 that have ended up
on the back burner. There's been some MIPS people playing with it too.

For the kernel, LD_DEAD_CODE_DATA_ELIMINATION is not great. It can save
a little, but you get issues like any exception table entry or bug table
entry in a function will create a reference back to the function, so the
linker can't trim it away even if nothing else references it.

I'll try to take another look at it within the next few months and
remove it if I can't make progress.

Nicolas Pitre has been doing some much better work on dead code using
real LTO.

Thanks,
Nick
