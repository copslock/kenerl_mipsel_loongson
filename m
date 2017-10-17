Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 11:15:13 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.233]:53146 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbdJQJPETjN1M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 11:15:04 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 17 Oct 2017 09:14:41 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 17 Oct
 2017 02:12:38 -0700
Subject: Re: next/master build: 214 builds: 29 failed, 185 passed, 29 errors,
 68 warnings (next-20171016)
To:     Arnd Bergmann <arnd@arndb.de>, kernelci.org bot <bot@kernelci.org>
CC:     Kernel Build Reports Mailman List 
        <kernel-build-reports@lists.linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "Carlos Munoz" <cmunoz@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@linaro.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        David Sterba <dsterba@suse.cz>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <59e53a9c.0a98df0a.acf5c.fc96@mx.google.com>
 <CAK8P3a1Qk+H3zp23zR=3Wsh-Yp3YOZ0bF6BNcFHjnEHd9XnCjA@mail.gmail.com>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <a24ab94e-5c67-14e1-adf8-74d1b0a80e74@mips.com>
Date:   Tue, 17 Oct 2017 10:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1Qk+H3zp23zR=3Wsh-Yp3YOZ0bF6BNcFHjnEHd9XnCjA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1508231603-321459-8135-69442-6
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186050
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60422
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Hi


On 17/10/17 10:00, Arnd Bergmann wrote:
> On Tue, Oct 17, 2017 at 1:02 AM, kernelci.org bot <bot@kernelci.org> wrote:
>> next/master build: 214 builds: 29 failed, 185 passed, 29 errors, 68 warnings (next-20171016)
>> Full Build Summary: https://kernelci.org/build/next/branch/master/kernel/next-20171016/
>> Tree: next
>> Branch: master
>> Git Describe: next-20171016
>> Git Commit: babb43f85f5fc03482aafa461bdc2d38b9345361
>> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>> Built: 4 unique architectures
>>
>> Build Failures Detected:
>>
>> arm: gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05)
>> allmodconfig FAIL
>> mips: gcc version 6.3.0 (GCC)
>> bigsur_defconfig FAIL
>> bmips_be_defconfig FAIL
>> bmips_stb_defconfig FAIL
>> cavium_octeon_defconfig FAIL
>> ip27_defconfig FAIL
>> loongson3_defconfig FAIL
>> malta_defconfig FAIL
>> malta_kvm_defconfig FAIL
>> maltaaprp_defconfig FAIL
>> maltasmvp_defconfig FAIL
>> maltasmvp_eva_defconfig FAIL
>> maltaup_defconfig FAIL
>> maltaup_xpa_defconfig FAIL
>> mips_paravirt_defconfig FAIL
>> msp71xx_defconfig FAIL
>> nlm_xlp_defconfig FAIL
>> nlm_xlr_defconfig FAIL
>> pistachio_defconfig FAIL
>> sb1250_swarm_defconfig FAIL
>> xway_defconfig FAIL
>> x86: gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.4)
>> allmodconfig FAIL
>> allmodconfig+CONFIG_OF=n FAIL
>> defconfig+CONFIG_KASAN=y FAIL
>> defconfig+CONFIG_LKDTM=y FAIL
>> defconfig+CONFIG_OF_UNITTEST=y FAIL
>> defconfig+kselftest FAIL
>> i386_defconfig FAIL
>> x86_64_defconfig FAIL
>>
>> Errors summary:
>> 20 arch/mips/include/asm/smp.h:32:29: error: 'CONFIG_MIPS_NR_CPU_NR_MAP' undeclared here (not in a function)
> These are all caused by commit e79824d71155 ("MIPS: Allow
> __cpu_number_map to be larger than NR_CPUS"), which was
> apparently incomplete. I'm not sending a patch since I don't
> know what the intention was here. Reverting that commit
> avoids the problem.

There is a pending patch https://patchwork.linux-mips.org/patch/17400/ 
to fix this - it just needs applying.

Thanks,
Matt


>
>> 7 drivers/gpu/drm/i915/i915_gem.c:3092:54: error: 'flags' undeclared (first use in this function)
> A mismerge in today's linux-next, I assume it will be resolved in the
> following linux-next
>
>> 1 ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
> I haven't reproduced this one yet, will have a look.
>
>> 1 /bin/sh: 1: /home/buildslave/workspace/kernel-single-defconfig-builder/defconfig/defconfig+CONFIG_LKDTM=y/label/builder/build-x86/tools/objtool//fixdep: Permission denied
> This is an old build problem with objtool. It only shows up sometimes
> when we hit a certain race. Josh Poimboef suggested a workaround but
> can't reproduce the problem here locally, so I haven't some a patch.
>
>> Warnings summary:
>> 16 fs/xfs/xfs_fsmap.c:480:1: warning: '__xfs_getfsmap_rtdev' defined but not used [-Wunused-function]
>> 16 fs/xfs/xfs_fsmap.c:372:1: warning: 'xfs_getfsmap_rtdev_rtbitmap_helper' defined but not used [-Wunused-function]
> I sent a patch a few days ago, should get merged soon. This also happens
> in mainline.
>
>> 7 include/linux/typecheck.h:11:18: warning: comparison of distinct pointer types lacks a cast
>> 5 fs/f2fs/node.c:1654:5: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
>> 5 fs/f2fs/node.c:1556:5: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
>> 5 fs/f2fs/node.c:1443:5: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
>> 5 fs/f2fs/node.c:1289:5: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
>> 5 fs/f2fs/checkpoint.c:322:5: warning: suggest parentheses around assignment used as truth value [-Wparentheses]
> This came up today, I just sent a patch.
>
>> 2 fs/btrfs/tree-checker.c:186:4: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Wformat=]
>> 1 fs/btrfs/tree-checker.c:186:70: warning: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Wformat=]
> I sent a patch a few days ago, Dave Sterba reviewed it, but it hasn't
> gone in yet.
>
>> 1 fs/binfmt_elf_fdpic.c:1501:17: warning: unused variable 'addr' [-Wunused-variable]
> Al Viro applied my patch, but it hasn't made it into linux-next yet.
>
>           Arnd
>
