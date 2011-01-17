Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 16:58:33 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:54063 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493495Ab1AQP6a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 16:58:30 +0100
Received: by wyf22 with SMTP id 22so5153933wyf.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FcM3DFeRLsSijTYKspeg948AiuDu/Vp0V3MP707GEyg=;
        b=ocHsvR54DEqGYrYybU5KuJuR2XElYOjayd5OT27w+pZWXcfJ3tQs0J59fGECW2FqIP
         6UjbMi5aleXZ1uQowM5QG/bBaYqzxG22B4sQRn5zNxwioGLfEJhULk2peNXMemCF9TSY
         rDxKoq/UB6jLE7X8E3qWvUAznPHpMQ3e9HojU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=alUQXBoib+nkMW2PgDGmodSCFtalW/pK/62r7+TBSGfpjEp/59aOet79a2qzvwH/m9
         gAVpHVPRUO0GnSvDgHqilvwKXtZvABh2faJGuyWLFUHVS7l80JQkQLwIFwl7QEPg8J26
         6dmngl2k8gMUipjjSzzQ9ziOGxObrUkMO4fDs=
MIME-Version: 1.0
Received: by 10.216.180.76 with SMTP id i54mr20045wem.33.1295279877954; Mon,
 17 Jan 2011 07:57:57 -0800 (PST)
Received: by 10.216.93.137 with HTTP; Mon, 17 Jan 2011 07:57:57 -0800 (PST)
In-Reply-To: <AANLkTinMEFjXQZapVTZ=LgdXhNEEpYqpr7Pb1ong7_cp@mail.gmail.com>
References: <1295255224-19408-1-git-send-email-xiangfu@sharism.cc>
        <AANLkTimN4mTxSJiBD2cNs-pOTQBTHysFQYyYiU5ZSBsQ@mail.gmail.com>
        <AANLkTinMEFjXQZapVTZ=LgdXhNEEpYqpr7Pb1ong7_cp@mail.gmail.com>
Date:   Mon, 17 Jan 2011 23:57:57 +0800
Message-ID: <AANLkTiksML_H7aBfWp2cZ4PBtQ0ZnaFg3pkA4u=W14yp@mail.gmail.com>
Subject: Re: [PATCH] MIPS: add U-boot uImage build target to arch Makefile
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Sergey Kvachonok <ravenexp@gmail.com>
Cc:     Xiangfu Liu <xiangfu@sharism.cc>, linux-mips@linux-mips.org,
        lars@metafoo.de
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28943
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, Sergey

On Mon, Jan 17, 2011 at 10:43 PM, Sergey Kvachonok <ravenexp@gmail.com> wrote:
[...]
>>
>> Perhaps add more compression algos support and make them configurable
>> will be better. lzma/xz has higher compression rate, lzo has faster
>> decompression speed. and bzip2 is between lzo and gzip.
>>
>
> Ok, I'll try to make compression algo into Kconfig option then.

Just a friendly reminder: no need to add the algo options in Kconfig
for we already have them in init/Kconfig, you can search LZMA, BZIP2
... there.

With "make menuconfig", you can find them like this:

$ make menuconfig

General setup  --->
Kernel compression mode (LZMA)  --->

and then, like the Makefile of vmlinuz under
arch/mips/boot/compressed/, you can simply use the following method to
choose the compression tools:

tool_$(CONFIG_KERNEL_GZIP)    = gzip
tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
tool_$(CONFIG_KERNEL_LZMA)    = lzma
tool_$(CONFIG_KERNEL_LZO)     = lzo

But to avoid adding this again, we can simply share this for uImage
and move the content from arch/mips/boot/u-boot/Makefile to
arch/mips/boot/compressed/Makefile for vmlinuz also need to compress
the vmlinux.bin, so, they can share the same vmlinux.bin.z.

and to add the uImage target, we can simply add it in
arch/mips/Makefile like this:

 # boot/compressed
-vmlinuz vmlinuz.bin vmlinuz.ecoff vmlinuz.srec: $(vmlinux-32) FORCE
+vmlinuz vmlinuz.bin vmlinuz.ecoff vmlinuz.srec uImage: $(vmlinux-32) FORCE
        $(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
           VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $@

But we may need to check if this is compatible for the uImage target
in your old patch.

> And maybe unify with existing avr32 u-boot target, e.g. make use of
> scripts/mkuboot.sh.

Yeah, scripts/mkuboot.sh have checked the existence of the 'mkimage'
tool, so, it should be better.

> Will resubmit directly to this list when (if) it's done.

Welcome and thanks very much for your effort.

Regards,
Wu Zhangjin

>
> Regards,
> Sergey
>
