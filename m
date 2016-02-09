Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 08:01:14 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:42418 "EHLO
        mail.bmw-carit.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010545AbcBIHBMZwtZq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 08:01:12 +0100
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:25494 helo=mail.bmw-carit.de)
        by mail.bmw-carit.de with esmtps (TLSv1:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Daniel.Wagner@bmw-carit.de>)
        id 1aT2II-0006iA-2I; Tue, 09 Feb 2016 08:01:02 +0100
Received: from handman.bmw-carit.intra (192.168.101.8) by
 Exchange2010.bmw-carit.intra (192.168.100.28) with Microsoft SMTP Server
 (TLS) id 14.3.123.3; Tue, 9 Feb 2016 08:01:02 +0100
X-CTCH-RefID: str=0001.0A0C0202.56B98EAE.02B4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Subject: Re: [PATCH v3 1/3] mips: Use arch specific auxvec.h instead of
 generic-asm version
To:     "Maciej W. Rozycki" <macro@imgtec.com>
References: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk>
 <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de>
 <1454946278-13859-2-git-send-email-daniel.wagner@bmw-carit.de>
 <alpine.DEB.2.00.1602081705470.15885@tp.orcam.me.uk>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
X-Enigmail-Draft-Status: N1110
Message-ID: <56B98EAE.9080505@bmw-carit.de>
Date:   Tue, 9 Feb 2016 08:01:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.00.1602081705470.15885@tp.orcam.me.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <daniel.wagner@bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

Good Morning,

On 02/08/2016 06:19 PM, Maciej W. Rozycki wrote:
> On Mon, 8 Feb 2016, Daniel Wagner wrote:
> 
>> The generic auxvec.h is used instead the arch specific version.
>> This happens when cross compiling the kernel.
>>
>> mips64-linux-gnu-gcc (GCC) 5.2.1 20151104 (Red Hat Cross 5.2.1-4)
>>
>> arch/mips/kernel/../../../fs/binfmt_elf.c: In function ‘create_elf_tables’:
>> ./arch/mips/include/asm/elf.h:425:14: error: ‘AT_SYSINFO_EHDR’ undeclared (first use in this function)
> 
>  There must be something wrong with your setup, or maybe a bug somewhere 
> in our build machinery you just happened to trigger.  Most of us routinely 
> use a cross-compiler to build the kernel and you're the first one to 
> report the problem.

Yeah, I thought so too and I would also bet on the toolchain. After
'fixing' this small problem I got a nice and shiny binary without any
other warnings or errors.

>  Can you report the compiler invocation that has lead to this error?  

 /usr/bin/mips64-linux-gnu-gcc -Wp,-MD,fs/.binfmt_elf.o.d  -nostdinc -isystem /usr/lib/gcc/mips64-linux-gnu/5.2.1/include -I./arch/mips/include -Iarch/mips/include/generated/uapi -Iarch/mips/include/generated  -Iinclude -I./arch/mips/include/uapi -Iarch/mips/include/generated/uapi -I./include/uapi -Iinclude/generated/uapi -include ./include/linux/kconfig.h -D__KERNEL__ -DVMLINUX_LOAD_ADDRESS=0xffffffff88002000 -DDATAOFFSET=0 -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-declaration -Wno-format-security -std=gnu89 -mno-check-zero-division -mabi=32 -G 0 -mno-abicalls -fno-pic -pipe -msoft-float -DGAS_HAS_SET_HARDFLOAT -Wa,-msoft-float -ffreestanding -march=r5000 -Wa,--trap -I./arch/mips/include/asm/mach-ip22 -I./arch/mips/include/asm/mach-generic -fno-delete-null-pointer-checks -O2 --param=allow-store-data-races=0 -Wframe-larger-than=1024 -fno-stack-protector -Wno-unused-but-set-variable -fomit-frame-pointer -fno-var-tracking
-assignments -Wdeclaration-after-statement -Wno-pointer-sign -fno-strict-overflow -fconserve-stack -Werror=implicit-int -Werror=strict-prototypes -Werror=date-time -DCC_HAVE_ASM_GOTO    -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(binfmt_elf)"  -D"KBUILD_MODNAME=KBUILD_STR(binfmt_elf)" -c -o fs/.tmp_binfmt_elf.o fs/binfmt_elf.c

> Have you used a default config or a custom one?

I used the default one per 'make defconfig ARCH=mips
CROSS_COMPILE=/usr/bin/mips64-linux-gnu-' with Fedora 23 MIPS cross
toolchain.

>> diff --git a/arch/mips/include/asm/auxvec.h b/arch/mips/include/asm/auxvec.h
>> new file mode 100644
>> index 0000000..fbd388c
>> --- /dev/null
>> +++ b/arch/mips/include/asm/auxvec.h
>> @@ -0,0 +1 @@
>> +#include <uapi/asm/auxvec.h>
> 
>  You're not supposed to require a header in asm/ merely to include a 
> header of the same name from uapi/asm/ as there are normally 
> -I./arch/mips/include and -I./arch/mips/include/uapi options present both 
> at once, in this order, on the compiler's invocation line.  So:
> 
> #include <asm/auxvec.h>
> 
> will pull the header from uapi/asm/ if none is present in asm/.

Okay, thanks for the explanation. I was pretty confused by the build
machinery and saw this include for ARM arch which provides also a their
own uapi/asm/auxvec.h

Also I looked at the cpp output and saw that there was no uapi/asm/auxvec.h
included instead it pulls arch/mips/include/generated/uapi/asm/auxvec.h

Not working version:

# 1 "arch/mips/include/generated/uapi/asm/auxvec.h" 1
# 1 "./include/uapi/asm-generic/auxvec.h" 1
# 1 "arch/mips/include/generated/uapi/asm/auxvec.h" 2
# 5 "include/uapi/linux/auxvec.h" 2
# 5 "include/linux/auxvec.h" 2
# 12 "./arch/mips/include/asm/elf.h" 2
# 1 "include/linux/fs.h" 1

working version:

# 1 "./arch/mips/include/asm/auxvec.h" 1
# 1 "./arch/mips/include/uapi/asm/auxvec.h" 1
# 1 "./arch/mips/include/asm/auxvec.h" 2
# 5 "include/uapi/linux/auxvec.h" 2
# 5 "include/linux/auxvec.h" 2
# 12 "./arch/mips/include/asm/elf.h" 2
# 1 "include/linux/fs.h" 1

I've uploaded the cpp output and the config just in case:

https://www.monom.org/data/mips/auxvec/

I am still pretty confused about what should happen in which order. 
Maybe I should call the Confuse-A-Cat squat team.

cheers,
daniel
