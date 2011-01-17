Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 19:23:57 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:40332 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493541Ab1AQSXy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 19:23:54 +0100
Received: by iwn38 with SMTP id 38so5148185iwn.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 10:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5qQmBUpE0VoAqQ9U9o4mSN5up5UhUEswYlKbo3lb3yo=;
        b=MEHH5QkeeF2ZRdyF2MIAw2S6rYRXXtavUzNKxoNl1PN26+nh8wp4ZveKforoFBSCUN
         tagGpMlOvc3jEBvvNtvc1enG6h+44Z7Vnne5blKmDYivv5vB+iznGtiDa3a8Dk7xFDFk
         sztrMVB/EhzgFtoirAruGK9IjtC20xvARZ+ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mKe8MbsRitaKk5b1b5r+Q+U/VexDIrLALse18Sq2wcqzJTkzIw6dQXwvPXLixr47lP
         mo0CYlIoXJRNpbXuyCDG8MUn3NoY6x2oerWntYtKXo5geiGQ4WU8MUP/UjlTUISEfarl
         2iwdbsLXoBYw32WwsQPL/D3zyYeQuj7GBP2Bk=
MIME-Version: 1.0
Received: by 10.42.225.137 with SMTP id is9mr4804017icb.264.1295288633570;
 Mon, 17 Jan 2011 10:23:53 -0800 (PST)
Received: by 10.42.221.136 with HTTP; Mon, 17 Jan 2011 10:23:53 -0800 (PST)
In-Reply-To: <AANLkTimrKjk4FPSOhKBXZocG-ezH6eYR2mFzMUfiSVTS@mail.gmail.com>
References: <1295255224-19408-1-git-send-email-xiangfu@sharism.cc>
        <AANLkTimrKjk4FPSOhKBXZocG-ezH6eYR2mFzMUfiSVTS@mail.gmail.com>
Date:   Mon, 17 Jan 2011 20:23:53 +0200
Message-ID: <AANLkTim7kVjSpm2Td0QH4177o=M60GSJdUEjOHUa-jZn@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add U-boot uImage build target to arch Makefile
From:   Sergey Kvachonok <ravenexp@gmail.com>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Xiangfu Liu <xiangfu@sharism.cc>, linux-mips@linux-mips.org,
        lars@metafoo.de
Content-Type: text/plain; charset=UTF-8
Return-Path: <ravenexp@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ravenexp@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Jan 17, 2011 at 6:34 PM, wu zhangjin <wuzhangjin@gmail.com> wrote:

> Just a friendly reminder: no need to add the algo options in Kconfig
> for we already have them in init/Kconfig, you can search LZMA, BZIP2
> ... there.

No, I don't have these since my platform (jz4740) does not define
SYS_SUPPORTS_ZBOOT. I don't know whether SFX-style compressed kernels
work on it, probably nobody tried.
U-boot uses it's own decompressor, so it's completely independent of
zboot framework (piggy.o building, in-kernel algos). That's why I'm
reluctant to merge vmlinuz and uImage build stages: these do
completely different things. U-boot may support compression algos not
included in the kernel and vice versa. Or some evil perverted person
might want to build (un)compressed u-boot image from vmlinuz kernel,
and it will probably work. ;)

Should I create SYS_SUPPORTS_UBOOT then?
Like this:

arch/mips/Kconfig:

+config SYS_SUPPORTS_UBOOT
+        bool
+        select HAVE_KERNEL_GZIP
+        select HAVE_KERNEL_BZIP2
+        select HAVE_KERNEL_LZMA
+        select HAVE_KERNEL_LZO

arch/mips/Makefile:

+all-$(CONFIG_SYS_SUPPORTS_UBOOT)+= uImage

...

+# u-boot
+uImage: vmlinux.bin FORCE
+       $(Q)$(MAKE) $(build)=arch/mips/boot/u-boot \
+         VMLINUX=$(vmlinux-32) VMLINUXBIN=arch/mips/boot/vmlinux.bin \
+         VMLINUX_LOAD_ADDRESS=$(load-y) arch/mips/boot/u-boot/$@

Of course install and clean targets will be added as well.
This will prevent vmlinuz from building and build uImage with chosen
compression algo instead.

I intend to keep u-boot/Makefile separate still. Of course it creates
some code duplication, but I believe proper functional decoupling is
more important in this case.
u-boot/Makefile is (almost) architecture independent and can be easily
adopted by other arch if such need arises.

Comments and suggestions welcome.

Regards,
Sergey
