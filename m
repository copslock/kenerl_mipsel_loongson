Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jan 2011 04:21:19 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:44945 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490947Ab1ARDVQ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Jan 2011 04:21:16 +0100
Received: by wyf22 with SMTP id 22so5604874wyf.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 19:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ikBV3JoeO/AVLGMoeyfa2bbLC29JdcaM4oep3biedSk=;
        b=RyQcs5EsIi8z6RooXeozBM/3cbAnPmVCf++DO8jsqDBsOPDcMYfkLbkl78YA+6qUPr
         uHV+lT9KwBhaXS8eI+l67R10vOdfP90ZV2kjWft4wDrzxGrgYBP6ufihzeNuMD4Goqgn
         aBioDs50cTeMCc5qqIcN0RhNzSUdiClPp00ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dv4yVAeF4eU+yFjJqhTnkDQ64LsTo/b8CZNK8EfcWqSv9RjXKJy4F0GCfJ7sCCdrpJ
         93/d1O5y3scaKdoms0ofH2FNValCs4zRhXRpHeVfJaFY4PdJlJoepLdWuOGB4BAGSWu8
         OnDTyLWwB3xvZjMNaMCEIRRm6uIm+r0QpyyxE=
MIME-Version: 1.0
Received: by 10.216.87.131 with SMTP id y3mr672826wee.3.1295320870594; Mon, 17
 Jan 2011 19:21:10 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Mon, 17 Jan 2011 19:21:10 -0800 (PST)
In-Reply-To: <AANLkTim7kVjSpm2Td0QH4177o=M60GSJdUEjOHUa-jZn@mail.gmail.com>
References: <1295255224-19408-1-git-send-email-xiangfu@sharism.cc>
        <AANLkTimrKjk4FPSOhKBXZocG-ezH6eYR2mFzMUfiSVTS@mail.gmail.com>
        <AANLkTim7kVjSpm2Td0QH4177o=M60GSJdUEjOHUa-jZn@mail.gmail.com>
Date:   Tue, 18 Jan 2011 11:21:10 +0800
Message-ID: <AANLkTi=YPXy-cfd3jP-quGmiX2+4uKqoVUPoRzC9h933@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add U-boot uImage build target to arch Makefile
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Sergey Kvachonok <ravenexp@gmail.com>
Cc:     Xiangfu Liu <xiangfu@sharism.cc>, linux-mips@linux-mips.org,
        lars@metafoo.de
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Tue, Jan 18, 2011 at 2:23 AM, Sergey Kvachonok <ravenexp@gmail.com> wrote:
> On Mon, Jan 17, 2011 at 6:34 PM, wu zhangjin <wuzhangjin@gmail.com> wrote:
>
>> Just a friendly reminder: no need to add the algo options in Kconfig
>> for we already have them in init/Kconfig, you can search LZMA, BZIP2
>> ... there.
>
> No, I don't have these since my platform (jz4740) does not define
> SYS_SUPPORTS_ZBOOT. I don't know whether SFX-style compressed kernels
> work on it, probably nobody tried.

Perhaps you can get a try, as I know uImage does have some problem on
U-boot for U-boot allocates fixed-size memory for the decompressed
kernel image, then, the max size of the vmlinux.bin is limited to the
max size(seems it is only 8M by default), but it may be still safe for
perhaps nobody will get such a big kernel image.

SFX-style doesn't have the above problem for it considers this problem
before linking, but it requires the bootloader to parse the ELF header
to get the right entry point. A known problem of the current vmlinuz
support is some bootloader may don't parse the right entry point from
the ELF header but just load them to a fixed address: the $(load-y)
value defined in arch/mips/Makefile or arch/mips/*/Platform, this will
be fixed asap and the solution is already in my mind.

> U-boot uses it's own decompressor,

Yeah, your new config SYS_SUPPORTS_UBOOT does solve this problem.

> so it's completely independent of
> zboot framework (piggy.o building, in-kernel algos). That's why I'm
> reluctant to merge vmlinuz and uImage build stages: these do
> completely different things. U-boot may support compression algos not
> included in the kernel and vice versa. Or some evil perverted person
> might want to build (un)compressed u-boot image from vmlinuz kernel,
> and it will probably work. ;)

Adding uImage target to arch/mips/boot/compressed/Makefile doesn't
need the building of vmlinuz, it depends on If you have selected
SYS_SUPPORTS_ZBOOT for your board, just as your reply shows below,
your board can still only select SYS_SUPPORTS_UBOOT without building
the vmlinuz ;-)

>
> Should I create SYS_SUPPORTS_UBOOT then?
> Like this:
>
> arch/mips/Kconfig:
>
> +config SYS_SUPPORTS_UBOOT
> +        bool
> +        select HAVE_KERNEL_GZIP
> +        select HAVE_KERNEL_BZIP2
> +        select HAVE_KERNEL_LZMA
> +        select HAVE_KERNEL_LZO

Yep, this does solve the problem "U-boot uses it's own decompressor,"

>
> arch/mips/Makefile:
>
> +all-$(CONFIG_SYS_SUPPORTS_UBOOT)+= uImage
>

That's it ;-)

> ...
>
> +# u-boot
> +uImage: vmlinux.bin FORCE
> +       $(Q)$(MAKE) $(build)=arch/mips/boot/u-boot \
> +         VMLINUX=$(vmlinux-32) VMLINUXBIN=arch/mips/boot/vmlinux.bin \
> +         VMLINUX_LOAD_ADDRESS=$(load-y) arch/mips/boot/u-boot/$@
>
> Of course install and clean targets will be added as well.
> This will prevent vmlinuz from building and build uImage with chosen
> compression algo instead.

If CONFIG_SYS_SUPPORTS_ZBOOT is false, vmlinuz will not be compiled
either for we have this line:

all-$(CONFIG_SYS_SUPPORTS_ZBOOT)+= vmlinuz

>
> I intend to keep u-boot/Makefile separate still. Of course it creates
> some code duplication, but I believe proper functional decoupling is
> more important in this case.

Ok, no problem, but why not share the same source code If we can do it
easily and with smaller patch ;-)

> u-boot/Makefile is (almost) architecture independent and can be easily
> adopted by other arch if such need arises.

Yeah, then, the boards can select them like ZBOOT does.

config BOARD_NAME
          ....
          select SYS_SUPPORTS_UBOOT

Then, the other boards will still be independent.

Regards,
Wu Zhangjin

>
> Comments and suggestions welcome.
>
> Regards,
> Sergey
>
