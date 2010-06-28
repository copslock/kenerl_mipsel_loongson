Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jun 2010 04:08:52 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:59513 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490989Ab0F1CIm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jun 2010 04:08:42 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o5S28YFY008120;
        Sun, 27 Jun 2010 19:08:34 -0700 (PDT)
Received: from [128.224.162.222] ([128.224.162.222]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Sun, 27 Jun 2010 19:08:33 -0700
Message-ID: <4C280421.5050201@windriver.com>
Date:   Mon, 28 Jun 2010 10:08:33 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
MIME-Version: 1.0
To:     Zhuang Yuyao <mlistz@gmail.com>
CC:     linux-mips@linux-mips.org, ddaney@caviumnetworks.com
Subject: Re: [BUG] Cavium OCTEON strange illegal instruction
References: <AANLkTinD3HC-kzTVC0wImsLzXxyZhsF9x2HIyYeU9Ki2@mail.gmail.com>
In-Reply-To: <AANLkTinD3HC-kzTVC0wImsLzXxyZhsF9x2HIyYeU9Ki2@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Jun 2010 02:08:34.0111 (UTC) FILETIME=[CFED6CF0:01CB1666]
X-archive-position: 27266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18356

Zhuang Yuyao 写道:
> Hi,
>
> I compiled octeon openssl engine libocteon.so based on
> OCTEON-CRYPTO-CORE-1.9.0-60 and OCTEON-ENGINE-LINUX-0.5.0-18.
>
> it works fine under linux-2.6.32.15, but while I upgraded the kernel
> to 2.6.33.5 or 2.6.34, running openssl speed test gives me the
> following error:
>
> ~ # openssl speed -engine octeon rsa1024
> Octeon_init success
> engine "octeon" set.
> Illegal instruction
>
> ~ # openssl speed -engine octeon -evp des
> Octeon_init success
> engine "octeon" set.
> Doing des-cbc for 3s on 16 size blocks: Illegal instruction
>   

This should be caused by MIPS CU2 exception handler. You can try 
Jesper's patch sumbitted one week ago, see below:

Breaking here dropped us to the default code which always sends
a SIGILL to the current process, no matter what the CU2 notifier says.

Signed-off-by: Jesper Nilsson <jesper@jni.nu>
---
 traps.c <mailbox:///home/yshi/.mozilla-thunderbird/caj8i8s5.default/Mail/Local%20Folders/linux-mips?number=11063936#traps.c> |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

traps.c
=======================================

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 8bdd6a6..8527808 100644

--- a/arch/mips/kernel/traps.c

+++ b/arch/mips/kernel/traps.c

@@ -976,8 +976,8 @@

976asmlinkage·void·do_cpu(struct·pt_regs·*regs)
977
978» case·2:
979» » raw_notifier_call_chain(&cu2_chain,·CU2_EXCEPTION,·regs);
-980» » break;
+980» » return;
981
982» case·3:
983» » break;


Yang

> Here is the compiling output:
>
> make[1]: Entering directory `/root/octcrypto/applications/linux_engine/sample'
> make[1]: Leaving directory `/root/octcrypto/applications/linux_engine/sample'
> mips64-octeon-linux-gnu-gcc -I/root/octcrypto/target/include -Iconfig
> -DUSE_RUNTIME_MODEL_CHECKS=1 -DCVMX_ENABLE_PARAMETER_CHECKING=0
> -DCVMX_ENABLE_CSR_ADDRESS_CHECKING=0 -DCVMX_ENABLE_POW_CHECKS=0 -g
> -DOCTEON_MODEL=OCTEON_CN56XX_PASS2 -DOCTEON_TARGET=linux_64 -mabi=64
> -march=octeon -msoft-float -Dmain=appmain
> -I/opt/netone/buildfarm/build_mips64_glibc/linux-2.6.33.5x-mips64-o60h/arch/mips/include
> -MD -c -o mul_lin.o mul_lin.S
> mips64-octeon-linux-gnu-gcc  -I.
> -I/opt/netone/buildfarm/build_mips64_glibc/openssl-0.9.8n//include
> -I/root/octcrypto/components/crypto-api/core/cryptolinux
> -I/root/octcrypto/executive -O3 -Wall
> -I/root/octcrypto/target/include -Iconfig
> -DUSE_RUNTIME_MODEL_CHECKS=1 -DCVMX_ENABLE_PARAMETER_CHECKING=0
> -DCVMX_ENABLE_CSR_ADDRESS_CHECKING=0 -DCVMX_ENABLE_POW_CHECKS=0
> -DOCTEON_MODEL=OCTEON_CN56XX_PASS2 -DOCTEON_TARGET=linux_64 -mabi=64
> -march=octeon -msoft-float -Dmain=appmain -MD -c -o e_octeon.o
> e_octeon.c
> mips64-octeon-linux-gnu-gcc -I/root/octcrypto/target/include -Iconfig
> -DUSE_RUNTIME_MODEL_CHECKS=1 -DCVMX_ENABLE_PARAMETER_CHECKING=0
> -DCVMX_ENABLE_CSR_ADDRESS_CHECKING=0 -DCVMX_ENABLE_POW_CHECKS=0
> -DOCTEON_MODEL=OCTEON_CN56XX_PASS2 -DOCTEON_TARGET=linux_64 -mabi=64
> -march=octeon -msoft-float -Dmain=appmain -shared -o libocteon.so
> mul_lin.o e_octeon.o
> -L/opt/netone/buildfarm/build_mips64_glibc/openssl-0.9.8n/ -lcrypto
>
>
> What's happened in the kernel?
>
> thanks very much.
>
> Best regards,
> Zhuang Yuyao
>
>
>   
