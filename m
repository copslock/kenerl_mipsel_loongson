Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 11:00:22 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:54749
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990430AbdJQJALWSzsM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 11:00:11 +0200
Received: by mail-oi0-x243.google.com with SMTP id a132so1556946oih.11;
        Tue, 17 Oct 2017 02:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RExSqoPddB/vjsc31gH7119TEq/Ozvw3H0vRWotR6Yo=;
        b=AgMGbzgUjiI9p5JwImddvYsx/8lY13nVnFiWYUmRrURHdq2V/h2eHQv5AUHhRM0lAQ
         L0PRSm8KLywtqk+wiMT4mXtpfDUn1ujJx76hXWz/vaXoQ7ZpgtpjMc7BCBLQ7x/YNYo5
         WNWNYBr0zM6X20g1oQOco7eOayWwMSWLBVryOnRwb7puN7zmNXykAnPixLrPWL1nnsnc
         WXub6ZxElusPdIOQz8s9Tkv0j9WbTy1BBgq37yFstjtNFfqsYJcDWxHA823CtBILVelk
         3E8Jxh9WtsJJIW7oiq7fhYXbl0CJLLM4GNUG1T1tMc5HuFUSeQN7B69sBVbA3sVEcG1I
         J0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RExSqoPddB/vjsc31gH7119TEq/Ozvw3H0vRWotR6Yo=;
        b=ZIDIPs0xkigc19P1vLzMn76nYsGOOaU3xgRP0TrojrOqApxGGcYDrnxgSC0VNrHpyk
         XBBootv1mEZUVNt4jwLbG/P7IqCC441TSvG3jwjJm0VL3pKqmyqxR/B7i6jtSOg8iKUT
         PzNGQSz1Gu72ajfVTnARRp+8q3ZezFl5kGc3p4lVY6uRAZyjzSXenncdbi9En7eVritA
         LRMStRXPUTDXYsFalAkpdlBeuThJsXq4kPe/0uKEQLMjHgYtEus/U2Q6RPZkM1a7B9l3
         cvCXZjQhZRIFfzG3ero0ELZGBFVgpaXhC+tEqBXncdEa5AqRkssXzzJx69LEXvLxOg9r
         FAgQ==
X-Gm-Message-State: AMCzsaU8sGCNEa320ETnFF6mMh21DSfYbIQE1BXEPzDvuc70axBD5ZE2
        ayBVe68yYPYn1gTJ04OsEL6M+xOkS9RCYZ2VhJw=
X-Google-Smtp-Source: ABhQp+Se6WaiwEAkHhQAjXJMW7VDUQUqSfAkQkWaYpbkm7EBsx+H+jygNrki9zj06tfWI4SnBZUPYfCZ/u76SjjD+rM=
X-Received: by 10.157.66.45 with SMTP id q45mr1706398ote.150.1508230804934;
 Tue, 17 Oct 2017 02:00:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.28.152 with HTTP; Tue, 17 Oct 2017 02:00:04 -0700 (PDT)
In-Reply-To: <59e53a9c.0a98df0a.acf5c.fc96@mx.google.com>
References: <59e53a9c.0a98df0a.acf5c.fc96@mx.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 17 Oct 2017 11:00:04 +0200
X-Google-Sender-Auth: 89rqgObqCAE_9ZQHtujruttXOxA
Message-ID: <CAK8P3a1Qk+H3zp23zR=3Wsh-Yp3YOZ0bF6BNcFHjnEHd9XnCjA@mail.gmail.com>
Subject: Re: next/master build: 214 builds: 29 failed, 185 passed, 29 errors,
 68 warnings (next-20171016)
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Sterba <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Tue, Oct 17, 2017 at 1:02 AM, kernelci.org bot <bot@kernelci.org> wrote:
>
> next/master build: 214 builds: 29 failed, 185 passed, 29 errors, 68 warnings (next-20171016)
> Full Build Summary: https://kernelci.org/build/next/branch/master/kernel/next-20171016/
> Tree: next
> Branch: master
> Git Describe: next-20171016
> Git Commit: babb43f85f5fc03482aafa461bdc2d38b9345361
> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> Built: 4 unique architectures
>
> Build Failures Detected:
>
> arm: gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05)
> allmodconfig FAIL
> mips: gcc version 6.3.0 (GCC)
> bigsur_defconfig FAIL
> bmips_be_defconfig FAIL
> bmips_stb_defconfig FAIL
> cavium_octeon_defconfig FAIL
> ip27_defconfig FAIL
> loongson3_defconfig FAIL
> malta_defconfig FAIL
> malta_kvm_defconfig FAIL
> maltaaprp_defconfig FAIL
> maltasmvp_defconfig FAIL
> maltasmvp_eva_defconfig FAIL
> maltaup_defconfig FAIL
> maltaup_xpa_defconfig FAIL
> mips_paravirt_defconfig FAIL
> msp71xx_defconfig FAIL
> nlm_xlp_defconfig FAIL
> nlm_xlr_defconfig FAIL
> pistachio_defconfig FAIL
> sb1250_swarm_defconfig FAIL
> xway_defconfig FAIL
> x86: gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4)
> allmodconfig FAIL
> allmodconfig+CONFIG_OF=n FAIL
> defconfig+CONFIG_KASAN=y FAIL
> defconfig+CONFIG_LKDTM=y FAIL
> defconfig+CONFIG_OF_UNITTEST=y FAIL
> defconfig+kselftest FAIL
> i386_defconfig FAIL
> x86_64_defconfig FAIL
>
> Errors summary:
> 20 arch/mips/include/asm/smp.h:32:29: error: 'CONFIG_MIPS_NR_CPU_NR_MAP' undeclared here (not in a function)

These are all caused by commit e79824d71155 ("MIPS: Allow
__cpu_number_map to be larger than NR_CPUS"), which was
apparently incomplete. I'm not sending a patch since I don't
know what the intention was here. Reverting that commit
avoids the problem.

> 7 drivers/gpu/drm/i915/i915_gem.c:3092:54: error: 'flags' undeclared (first use in this function)

A mismerge in today's linux-next, I assume it will be resolved in the
following linux-next

> 1 ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

I haven't reproduced this one yet, will have a look.

> 1 /bin/sh: 1: /home/buildslave/workspace/kernel-single-defconfig-builder/defconfig/defconfig+CONFIG_LKDTM=y/label/builder/build-x86/tools/objtool//fixdep: Permission denied

This is an old build problem with objtool. It only shows up sometimes
when we hit a certain race. Josh Poimboef suggested a workaround but
can't reproduce the problem here locally, so I haven't some a patch.

> Warnings summary:
> 16 fs/xfs/xfs_fsmap.c:480:1: warning: '__xfs_getfsmap_rtdev' defined but not used [-Wunused-function]
> 16 fs/xfs/xfs_fsmap.c:372:1: warning: 'xfs_getfsmap_rtdev_rtbitmap_helper' defined but not used [-Wunused-function]

I sent a patch a few days ago, should get merged soon. This also happens
in mainline.

> 7 include/linux/typecheck.h:11:18: warning: comparison of distinct pointer types lacks a cast
> 5 fs/f2fs/node.c:1654:5: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
> 5 fs/f2fs/node.c:1556:5: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
> 5 fs/f2fs/node.c:1443:5: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
> 5 fs/f2fs/node.c:1289:5: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
> 5 fs/f2fs/checkpoint.c:322:5: warning: suggest parentheses around assignment used as truth value [-Wparentheses]

This came up today, I just sent a patch.

> 2 fs/btrfs/tree-checker.c:186:4: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Wformat=]
> 1 fs/btrfs/tree-checker.c:186:70: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Wformat=]

I sent a patch a few days ago, Dave Sterba reviewed it, but it hasn't
gone in yet.

> 1 fs/binfmt_elf_fdpic.c:1501:17: warning: unused variable 'addr' [-Wunused-variable]

Al Viro applied my patch, but it hasn't made it into linux-next yet.

         Arnd
