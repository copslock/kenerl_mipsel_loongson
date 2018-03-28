Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2018 21:04:55 +0200 (CEST)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:35866
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbeC1TEsX0Upz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Mar 2018 21:04:48 +0200
Received: by mail-it0-x241.google.com with SMTP id c1-v6so4950745itj.1
        for <linux-mips@linux-mips.org>; Wed, 28 Mar 2018 12:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsww98XQlMaNSmVYGKNwLCezcXkLKeBGQ9idADJewTA=;
        b=o5dilxzqzV6KnPrd37oA/t5ikhzAoaQEn38cC6FUKUWDlLF7J26VG3J8vvoQjpE9v4
         sX+kJ+yMU/+XJniI7IHI+XVvTI3HOpi/FGIe0gNpgHompj53bCp3NmQxXFpuEFwZvKYG
         MwhP6oyamSta84VY/0bjNlMr9e7cy//1VmLHFbNmQtjZNDcOpOZbOicsuEJ80yjPLVnf
         y77Ir1JQwh+bQMTiH9rsXpc/BejOdjFOO6dp9ByseZzxZbYzuQXb8gby3Tp6fCn8CZOW
         hhKkL4EJuKb2LilYNL9O03He8lOdibOCyd7K5otpCUgITdxfP9zVFBpUuxhAqIybYqBQ
         7pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsww98XQlMaNSmVYGKNwLCezcXkLKeBGQ9idADJewTA=;
        b=Mdx6s1nxgKhdv48T0bpOzEQWou4vCT8mCE9OAgNYsf82f3IPxtPlDpDOk5a1lnU2ZE
         kSnnJEU6uxutTVo7EZ8D/WbgS0TWatiIKFeBHBY0ShTmaK7/5l725DBcdsya9lQ5wxhP
         J4pO84a+1EyVy8Pbruo89IrYADwkJK2ah44/9ZXYShpAJHPguJt56hluOxO5npahKzSk
         02XnQOxNdUY87+6ecLwVE5Nq2vrrQXgbQNHmlGLxzAvFn7MIj0NDrg3f/F9dn9M4CXek
         NxKo0csLhUcYIv0dfKw6mVPNLlW3Xa1mL2UwM7muXuH5sLuD9ie1Ej9+b0YXjAXdtVK8
         A/3A==
X-Gm-Message-State: ALQs6tBzbDRNlcbxb+saAUshNeTtCV0J5MykREAx5P33R5TzDrn9O9Y/
        Xn2EEXvRY8e1bLyJoA2lofTQPw==
X-Google-Smtp-Source: AIpwx4/c3srh0pDtFCNBi9vz7kcNkO/xIaKar/eM0VFokeFeVAXY+zQsaV9+49SYu9uvE3vMjbAtMA==
X-Received: by 2002:a24:ad1a:: with SMTP id c26-v6mr4638384itf.152.1522263882059;
        Wed, 28 Mar 2018 12:04:42 -0700 (PDT)
Received: from [192.168.42.97] ([172.58.139.228])
        by smtp.googlemail.com with ESMTPSA id c101sm2993790iod.26.2018.03.28.12.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Mar 2018 12:04:41 -0700 (PDT)
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
From:   Rob Landley <rob@landley.net>
Message-ID: <de092e7f-0bc9-bb06-9798-12784930a6bd@landley.net>
Date:   Wed, 28 Mar 2018 14:04:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328164813.GA3888@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63301
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



On 03/28/2018 11:48 AM, Russell King - ARM Linux wrote:
> On Wed, Mar 28, 2018 at 10:58:51AM -0500, Rob Landley wrote:
>> On 03/28/2018 10:26 AM, Shea Levy wrote:
>>> Now only those architectures that have custom initrd free requirements
>>> need to define free_initrd_mem.
>> ...
>>> --- a/arch/arc/mm/init.c
>>> +++ b/arch/arc/mm/init.c
>>> @@ -229,10 +229,3 @@ void __ref free_initmem(void)
>>>  {
>>>  	free_initmem_default(-1);
>>>  }
>>> -
>>> -#ifdef CONFIG_BLK_DEV_INITRD
>>> -void __init free_initrd_mem(unsigned long start, unsigned long end)
>>> -{
>>> -	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>> -}
>>> -#endif
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index 3f972e83909b..19d1c5594e2d 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -47,6 +47,7 @@ config ARM
>>>  	select HARDIRQS_SW_RESEND
>>>  	select HAVE_ARCH_AUDITSYSCALL if (AEABI && !OABI_COMPAT)
>>>  	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
>>> +	select HAVE_ARCH_FREE_INITRD_MEM
>>>  	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
>>>  	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>>>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
>>
>> Isn't this why weak symbols were invented?
> 
> Weak symbols means that we end up with both the weakly-referenced code
> and the arch code in the kernel image.  That's fine if the weak code
> is small.

The kernel's been able to build with link time garbage collection since 2016:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b67067f1176d

Wouldn't that remove the unused one?

Rob
