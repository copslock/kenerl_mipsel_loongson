Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 14:37:54 +0100 (CET)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33697 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007604AbbB0Nhvc1LUc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 14:37:51 +0100
Received: by iecar1 with SMTP id ar1so30855942iec.0
        for <linux-mips@linux-mips.org>; Fri, 27 Feb 2015 05:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8qvFtfeSRz36ZF2KelzU5ZhdBrAlrVtAWKuOZGBnQC0=;
        b=OLXbZcNAXwvLhZnqaWPNNjYwRVSkDc/GfGflEEAIa2StXHy8E/Uw3IdPV5JbHP181S
         v1ExlIzGH5UCnDHUzgEj6R8IiXluo60/x9PL0poce73qO0wOz6cxOUT//PIYD8zftrMZ
         RR2kGa4Wv/kT2v4tizrnfkR3qqMe5QJ8BDvqq6hzo7Xp7BIqL9Id8UPIl2ciCUl3brh6
         iieeiIlaUnm8q2nAmi6wd2POzkLdCcGOW8AuSfBH5MiK19Fx8DabB53zgIbwY/v/WJG3
         Ovb0p8JQvbeN+DJfbGHnnMpaCAQaPaujRmrOUj8bKQGiDXonbCHyiykPkTJBtESaKmY5
         HspA==
MIME-Version: 1.0
X-Received: by 10.107.5.212 with SMTP id 203mr15538882iof.4.1425044264964;
 Fri, 27 Feb 2015 05:37:44 -0800 (PST)
Received: by 10.64.176.238 with HTTP; Fri, 27 Feb 2015 05:37:44 -0800 (PST)
In-Reply-To: <20150226081425.GR6655@vapier>
References: <20150219194617.GT544@vapier>
        <CAAhV-H5+kQm_qAz7DLV4Rk9EqB4xJjmu1NV7kKd46aneKFZO-A@mail.gmail.com>
        <20150226081425.GR6655@vapier>
Date:   Fri, 27 Feb 2015 21:37:44 +0800
Message-ID: <CAAhV-H7vm61G1TP53GpskhLxC6LFEUkhiVzTFDRTiXSt9-zuvg@mail.gmail.com>
Subject: Re: custom kernel on lemote-3a-itx (Loongson-3A) crashes in userspace
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Mike Frysinger <vapier@gentoo.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

We have also built good kernels with native GCC-4.6.4/4.7.2/4.8.3 (o32
binaries). So maybe this is an N32-related problems.

Huacai

On Thu, Feb 26, 2015 at 4:14 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On 26 Feb 2015 15:47, Huacai Chen wrote:
>> Please try the toolchain here:
>> http://dev.lemote.com/files/resource/toolchain/cross-compile/
>
> thanks, but that's kind of dodgy and kind of defeats what i'm going for ;)
>  - looks like binary-only
>  - they're x86_64 binaries (i'm doing everything native here, so mips/n32)
>  - is pretty old (gcc-4.5 / gcc-4.6 / binutils-2.21 / binutils-2.22)
>
> that said, i installed Debian/mipsel(o32) into a chroot.  building with the same
> sources & configs yielded a kernel that seems to be running OK -- i'm on
> mainline linux-3.19 now.  it too has an old toolchain: binutils-2.22 and
> gcc-4.6.4.  i guess there's a miscompilation / the kernel sources have problems
> with newer gcc versions.
>
> installing older binutils in Gentoo was pretty easy, but trying to do gcc-4.6
> ran into an ICE while bootstrapping.  but at least it'll be easy to rule out
> weird assembler/linker problems.
>
> might try to put together a script to rebuild the objects one-by-one with the
> newer compiler to try and narrow down the problem in the source.
> -mike
