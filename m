Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2018 18:40:07 +0200 (CEST)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:39521
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990409AbeC2QkAtqmid (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Mar 2018 18:40:00 +0200
Received: by mail-it0-x244.google.com with SMTP id e98-v6so8609224itd.4
        for <linux-mips@linux-mips.org>; Thu, 29 Mar 2018 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mq8f+vRkP/mZyB5Eo6imYFEVjikyvk4d+b7tSEe0lXw=;
        b=USRe/m95HfaznOOYKySsVJPMHecIC+WE7kxSyCxwp0RIzHarrSKdl4SPIcv0aZqlLH
         wNEcUGNZvawbCNQwiNqpN7drX4m/ZU38UBIiH71ejgRLt4VohItefhy/w+AFOLJs26jm
         gIwuJXOczl1hOgO/8KOPhzwLBqLwNBSH993Pnt8G5V3RgpmDE2p7aT4t5BcxYB5Tfgmu
         sd7UC2ADU/k/6Hta8ySwLEeMJuZbeD4Bg/W2fhEb9QMKS6UkD2VHeFhUgUsS1DfjDeGM
         FiA/YP0y8aCLgB2fu6pbd8eyt4FdH5Xrrh0b/GQks0iItXOhrWnUp9gVuBmW8jGoIO2C
         jmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mq8f+vRkP/mZyB5Eo6imYFEVjikyvk4d+b7tSEe0lXw=;
        b=XLKevwI3nHCcLy92U7AowlIsRWCcGp7OflIpwI43E86QXO05RQrrgIKMiZ/TJkGg+8
         A4z/+16EgUt2I3TzXAIykx9XH0ojkUF5nHLiq92bDYaCMdJaCfmRLUQj6mkvY1lOAmCU
         9N7axXE7kNgMMwgme372I2W7uqeS4HzjWcYfS67Go/2cmL+dHoFxGN0HOiZqg+ISs/5Z
         kk1IsTa/7mWbbYakrMFPEMF+unVnBnAFn6rRM58EHBhG8oEF+W2DKH4UzTpHJxfmp8Zd
         5x1gpaUizyPwAd6YPqDW3eA+Ch3bK5iZtKD1p2oaxf1ruPidMaKEkqEtQ19CbQzVna6Y
         TP3g==
X-Gm-Message-State: AElRT7Go8BwFtwYJ6XnCa+kEpoePWgm/FRik/0LkL2OW89+daVJOM7JV
        qwShYNtlPFOrwRxOlINBxe93bA==
X-Google-Smtp-Source: AIpwx48TX1JV6yxbQdkvSpBeYkQ5dWOJjV/U+XXEGy4UNdwiKu0dddYJQCEbDNmHsRJ+nrSDr2PlPw==
X-Received: by 2002:a24:b605:: with SMTP id g5-v6mr8256708itf.83.1522341594385;
        Thu, 29 Mar 2018 09:39:54 -0700 (PDT)
Received: from [192.168.42.90] ([172.58.143.62])
        by smtp.googlemail.com with ESMTPSA id n7sm1309097ioo.43.2018.03.29.09.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Mar 2018 09:39:53 -0700 (PDT)
Subject: Re: [PATCH] Extract initrd free logic from arch-specific code.
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
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
        Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        linux-xtensa@linux-xtensa.org
References: <20180325221853.10839-1-shea@shealevy.com>
 <20180328152714.6103-1-shea@shealevy.com>
 <05620fee-e8b5-0668-77b8-da073dc78c40@landley.net>
 <20180328164813.GA3888@n2100.armlinux.org.uk>
 <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
 <20180328221401.GA14084@n2100.armlinux.org.uk>
From:   Rob Landley <rob@landley.net>
Message-ID: <c91e8781-5f31-70e8-e7ef-1a80bd5d9454@landley.net>
Date:   Thu, 29 Mar 2018 11:39:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328221401.GA14084@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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



On 03/28/2018 05:14 PM, Russell King - ARM Linux wrote:
> On Wed, Mar 28, 2018 at 02:04:22PM -0500, Rob Landley wrote:
>>
>>
>> On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
>>> On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
>>>> On 03/28/2018 10:26 AM, Shea Levy wrote:
>>>>> Now only those architectures that have custom initrd free requirements
>>>>> need to define free_initrd_mem.
>>>> ...
>>>>> --- a/arch/arc/mm/init.c
>>>>> +++ b/arch/arc/mm/init.c
>>>>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>>>>>  {
>>>>>  	free_initmem_default(-1);
>>>>>  }
>>>>> -
>>>>> -#ifdef CONFIG_BLK_DEV_INITRD
>>>>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>>>>> -{
>>>>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>>>> -}
>>>>> -#endif
>>>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>>>> index 3f972e83909b..19d1c5594e2d 100644
>>>>> --- a/arch/arm/Kconfig
>>>>> +++ b/arch/arm/Kconfig
>>>>> @@ -47,6 +47,7 @@ config ARM
>>>>>  	select HARDIRQS_SW_RESEND
>>>>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>>>>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>>>>> +	select HAVE_ARCH_FREE_INITRD_MEM
>>>>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>>>>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>>>>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>>>>
>>>> Isn't this why weak symbols were invented?
>>>
>>> Weak symbols means that we end up with both the weakly-referenced code
>>> and the arch code in the kernel image.  That's fine if the weak code
>>> is small.
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

It looks like there are per-architecture linker scripts that need to be updated?
So if an architecture supports it, it's always done (well, it probes for the
toolchain supporting the flag). And if the architecture doesn't support it, the
linker script needs to be updated to mark sections with "I know nothing seems to
reference this at the ELF level but keep it anyway, we're pulling an assembly
trick".

> Brings up the obvious question - why is it there if it's completely
> unused?  (Maybe to cause confusion, and allowing a justification
> for __weak ?)

Presumably it will become the default on architectures as their linker scripts
are converted. Once they're all converted the config symbol can go away. (Given
the move to requiring gcc 4.7 or whatever it is, there can't be an architecture
depending on a toolchain that _doesn't_ support it after that point. I doubt you
can pair gcc 4.7 with a >12 year old binutils and expect good things...)

Rob
