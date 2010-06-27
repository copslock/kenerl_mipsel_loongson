Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 27 Jun 2010 08:53:18 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:49154 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491123Ab0F0GxN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 27 Jun 2010 08:53:13 +0200
Received: by qwe4 with SMTP id 4so353324qwe.36
        for <linux-mips@linux-mips.org>; Sat, 26 Jun 2010 23:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=Ikesdfs/zKcMKY7r/Vl3AeoimBLpQCMYIAyna+NGgNQ=;
        b=TfwUApFRECSW9n1alLld/udVnDM1GW8eiCdKGXyXR4EHw9qrz4BW4flUXVUVQ8rVgc
         2C5x/LxL81+BRuI8anD7CEPfQo7f/RjWU3/8GoWr8z+H6efu8wD52SW62XJF2uefEUaW
         TT4AdWwTX8jlUtkQC3OVAClAdqXNvTA8Ehq0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=NuxEVJ7zAsikjw6QO/WKo6Ymg+SfZzUgKxQcrn5D+EOvSV6mWZmqKCuCrCMYiA6XDy
         LhinaeeRb4rbkDkYZUEWeFp86zi3kHu18uXWzs9zcpxC2ijUhwGOuR8TFqmuI7MTYp1m
         BGYrnUvIrphiYNMwQYiKQ9OdQzPBMHGMls1LA=
MIME-Version: 1.0
Received: by 10.224.78.41 with SMTP id i41mr2063299qak.176.1277621587130; Sat, 
        26 Jun 2010 23:53:07 -0700 (PDT)
Received: by 10.229.3.131 with HTTP; Sat, 26 Jun 2010 23:53:06 -0700 (PDT)
Date:   Sun, 27 Jun 2010 14:53:06 +0800
Message-ID: <AANLkTinD3HC-kzTVC0wImsLzXxyZhsF9x2HIyYeU9Ki2@mail.gmail.com>
Subject: [BUG] Cavium OCTEON strange illegal instruction
From:   Zhuang Yuyao <mlistz@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ddaney@caviumnetworks.com
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27256
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlistz@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18075

Hi,

I compiled octeon openssl engine libocteon.so based on
OCTEON-CRYPTO-CORE-1.9.0-60 and OCTEON-ENGINE-LINUX-0.5.0-18.

it works fine under linux-2.6.32.15, but while I upgraded the kernel
to 2.6.33.5 or 2.6.34, running openssl speed test gives me the
following error:

~ # openssl speed -engine octeon rsa1024
Octeon_init success
engine "octeon" set.
Illegal instruction

~ # openssl speed -engine octeon -evp des
Octeon_init success
engine "octeon" set.
Doing des-cbc for 3s on 16 size blocks: Illegal instruction

Here is the compiling output:

make[1]: Entering directory `/root/octcrypto/applications/linux_engine/sample'
make[1]: Leaving directory `/root/octcrypto/applications/linux_engine/sample'
mips64-octeon-linux-gnu-gcc -I/root/octcrypto/target/include -Iconfig
-DUSE_RUNTIME_MODEL_CHECKS=1 -DCVMX_ENABLE_PARAMETER_CHECKING=0
-DCVMX_ENABLE_CSR_ADDRESS_CHECKING=0 -DCVMX_ENABLE_POW_CHECKS=0 -g
-DOCTEON_MODEL=OCTEON_CN56XX_PASS2 -DOCTEON_TARGET=linux_64 -mabi=64
-march=octeon -msoft-float -Dmain=appmain
-I/opt/netone/buildfarm/build_mips64_glibc/linux-2.6.33.5x-mips64-o60h/arch/mips/include
-MD -c -o mul_lin.o mul_lin.S
mips64-octeon-linux-gnu-gcc  -I.
-I/opt/netone/buildfarm/build_mips64_glibc/openssl-0.9.8n//include
-I/root/octcrypto/components/crypto-api/core/cryptolinux
-I/root/octcrypto/executive -O3 -Wall
-I/root/octcrypto/target/include -Iconfig
-DUSE_RUNTIME_MODEL_CHECKS=1 -DCVMX_ENABLE_PARAMETER_CHECKING=0
-DCVMX_ENABLE_CSR_ADDRESS_CHECKING=0 -DCVMX_ENABLE_POW_CHECKS=0
-DOCTEON_MODEL=OCTEON_CN56XX_PASS2 -DOCTEON_TARGET=linux_64 -mabi=64
-march=octeon -msoft-float -Dmain=appmain -MD -c -o e_octeon.o
e_octeon.c
mips64-octeon-linux-gnu-gcc -I/root/octcrypto/target/include -Iconfig
-DUSE_RUNTIME_MODEL_CHECKS=1 -DCVMX_ENABLE_PARAMETER_CHECKING=0
-DCVMX_ENABLE_CSR_ADDRESS_CHECKING=0 -DCVMX_ENABLE_POW_CHECKS=0
-DOCTEON_MODEL=OCTEON_CN56XX_PASS2 -DOCTEON_TARGET=linux_64 -mabi=64
-march=octeon -msoft-float -Dmain=appmain -shared -o libocteon.so
mul_lin.o e_octeon.o
-L/opt/netone/buildfarm/build_mips64_glibc/openssl-0.9.8n/ -lcrypto


What's happened in the kernel?

thanks very much.

Best regards,
Zhuang Yuyao
