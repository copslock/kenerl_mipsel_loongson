Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 May 2010 16:26:25 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:64400 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491766Ab0EZO0V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 May 2010 16:26:21 +0200
Received: by fxm15 with SMTP id 15so4768581fxm.36
        for <multiple recipients>; Wed, 26 May 2010 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=yn1DGcWo1dnLLyUU8PjdwPdtwy6ym+UmqUv94XtB7S4=;
        b=GlBCtRQnaHxm2OaIlH2tcrSFmYwYXonH98pxXzMws0YB3JRGbAN3kDv7GGZiAioNYE
         7/E0cBAY0Z5/pwxHJ+sb3DwITQV5fXm+HFn9cwTFF+SdUqiPVced5cDSnWc7WkWq8H27
         f2w6m85g8u4FXGIcGkT5Q35Qi4Ld3csJ7ZNYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FpsNSDSm/yqZdFLWOSfHK20loakO3BJMYOYhDsTKxT6SdThAIoeDR152cXxbvXryhq
         43QaXPF2Km+SQOdeFwQ7AgfE+fyEM4ANki1tguTquDxEkcIfXTJUgUcm36pEu3PYgAv2
         FqMT1MJfYMNK94gklAGeQ1uatQ5kuMw64/v+8=
MIME-Version: 1.0
Received: by 10.223.99.156 with SMTP id u28mr7741406fan.53.1274883974252; Wed, 
        26 May 2010 07:26:14 -0700 (PDT)
Received: by 10.223.104.209 with HTTP; Wed, 26 May 2010 07:26:14 -0700 (PDT)
In-Reply-To: <1274879482.4bfd1dfa91e70@www.inmano.com>
References: <1274711094.4bfa8c3675983@www.inmano.com>
         <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>
         <20100525131341.GA26500@linux-mips.org>
         <1274795905.4bfbd781a17fa@www.inmano.com>
         <20100525144400.GA30900@linux-mips.org>
         <1274879482.4bfd1dfa91e70@www.inmano.com>
Date:   Wed, 26 May 2010 17:26:14 +0300
Message-ID: <AANLkTikbZmTWh8X4KOKLAUaJxKS5-PO39hmiTVICB5Zm@mail.gmail.com>
Subject: Re: Cross compiling MIPS kernel under x86
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     octane indice <octane@alinto.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, May 26, 2010 at 4:11 PM, octane indice <octane@alinto.com> wrote:
> Sorry to bother you another time, but it's a FAIL :-(

Just checked that the following steps result in a successful build of
a vanilla 2.6.34 vmlinux:

cd /work/tmp/zoo/src
wget http://ftp.gnu.org/gnu/binutils/binutils-2.20.1.tar.bz2
cd ../build
../src/binutils-2.20.1/configure --prefix=/work/tmp/zoo
--target=mips64-unknown-linux-gnu
make
export PATH=/work/tmp/zoo/bin:$PATH
rm -rf *
cd ../src/
wget http://ftp.gnu.org/gnu/gcc/gcc-4.4.4/gcc-core-4.4.4.tar.bz2
tar jxf gcc-core-4.4.4.tar.bz2
cd ../build
../src/gcc-4.4.4/configure --target=mips64-unknown-linux-gnu
--prefix=/work/tmp/zoo --disable-threads --disable-shared
--disable-multilib --disable-libgcc --disable-libmudflap
--disable-libssp --disable-libgomp
make
make install
cd ../src
wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.34.tar.bz2
tar jxf linux-2.6.34.tar.bz2
cd linux-2.6.34/
make ARCH=mips cavium-octeon_defconfig
make ARCH=mips CROSS_COMPILE=/work/tmp/zoo/bin/mips64-unknown-linux-gnu- vmlinux

Hope that helps.

Dmitri
