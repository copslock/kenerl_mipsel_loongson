Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Aug 2010 06:01:29 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:48812 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490960Ab0H1EBV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Aug 2010 06:01:21 +0200
Received: by wyb38 with SMTP id 38so3007036wyb.36
        for <linux-mips@linux-mips.org>; Fri, 27 Aug 2010 21:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=97wDaYXRErIQatEVpxvEjhbxIBRfAoHXgdkorZf9Gvw=;
        b=epyYwEXXJVfO9ZuGy40JVkiAxFvtTxjo270vPzkBQ6rJQ6zo8YCvMhaJ4udkR+H6n+
         trXmt2DLl/AuHO4FSrNycDCTRIBCuY9cM1oPQA6/lV1dlQVlIuVNNQqLxjUGQlQFXATI
         KcveDqrOIpJyq3pA8Np/xVzcbrGz1cHjIO8CM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aqGCEmQ1usC//zvLG3pV09Xip4mSxLiVlHgHAFL9f5myqjKhexYswebgFozMPfaa+3
         VgH97jB23X2OBrSTr8oO7eh2z0sBICbRQoguAr+tm8PJRASB2pusQJZTEJnG2vyFneZ5
         kzA9Lg1P/DeUPzEFwndU9Yo6aUivXXE82WLzo=
MIME-Version: 1.0
Received: by 10.216.165.77 with SMTP id d55mr1878575wel.23.1282968072105; Fri,
 27 Aug 2010 21:01:12 -0700 (PDT)
Received: by 10.216.166.69 with HTTP; Fri, 27 Aug 2010 21:01:12 -0700 (PDT)
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D07601005C14@CORPEXCH1.na.ads.idt.com>
References: <AEA634773855ED4CAD999FBB1A66D07601005801@CORPEXCH1.na.ads.idt.com>
        <AANLkTin5_3PPUoRocZFZuWhF9kFvmThUHgz3jp5ZaXMU@mail.gmail.com>
        <AEA634773855ED4CAD999FBB1A66D07601005C14@CORPEXCH1.na.ads.idt.com>
Date:   Sat, 28 Aug 2010 12:01:12 +0800
Message-ID: <AANLkTin_2oMH9z3ttFBZLCHDwBvKCgLK0s-=AiC1QEMy@mail.gmail.com>
Subject: Re: Does Linux Mips support compressed Kernel?
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On 8/28/10, Ardelean, Andrei <Andrei.Ardelean@idt.com> wrote:
> Hi Wu,
>
> Thanks a lot for all the details.
>
> I am using MALTA board with 74K.
> From your email I understand that the bootloader must uncompress the
> Kernel before launching it, so the compressed Kernel cannot run and
> decompress itself? Could you confirm? I am asking that because in some
> book I have read that Linux can boot a compressed image and the Kernel
> was able to uncompress itself, but maybe it was my misunderstanding.
>

Geert's answer is right. for the raw compressed kernel, i.e.

$ gzip vmlinux
$ ls vmlinux.gz

You may need the bootloader to decompress it.

but for the vmlinuz, it can decompress itself, the reason is:

This vmlinuz puts the raw compressed kernel(i.e. the vmlinux.gz above)
in a section of itself and adds an extra wrapper for booting and
decompressing. it can be parsed and loaded by the bootloader(the load
address of vmlinuz is the load address of the vmlinux + the size of
vmlinux), then it saves the arguments passed by the bootloader, clears
the bss, decompresses the raw compressed kernel into the memory(start
from the load address of the raw vmlinux) and at last jump to the load
address of the raw Linux, then, the story is the same as loading
vmlinux.

Most of the working flow is shown in arch/mips/boot/compressed/head.S.
arch/mips/boot/compressed/decompress.c is a wrapper for choosing the
related decompress algorithm(bzip2, gzip, lzma, lzo),
arch/mips/boot/compressed/dbg.c is a simple serial output support for
puts() and puthex(), the real implementation of putc() can be added in
arch/mips/boot/compressed/uart-*

To calculate the load address of the vmlinuz,
arch/mips/boot/compressed/calc_vmlinuz_load_addr.c is added, and
arch/mips/boot/compressed/ld.script is a simple ld script for linking
the vmlinuz, you can get the detail layout of the vmlinuz in
ld.script.

To learn more about the difference of vmlinux, vmlinux.gz(now, we use
vmlinux.bin.z), vmlinuz, you may need to read
arch/mips/boot/compressed/Makefile for it shows you how to generate
vmlinux.bin.z from vmlinux and also how to generate vmlinuz from
vmlinux.bin.z.

Regards,
Wu Zhangjin
