Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2016 06:44:05 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:58189 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025499AbcDTEoCqKGF6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Apr 2016 06:44:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=JXnHLLKm0riNKGXbNJgL6KKITADbaypuc6fL89k82Pg=; b=cAE9lVdcNIUqU2k0IJpNFuMADq
        GRx2ytaRmrLRf6aH2HP3Z2Lb1rt+9fj9VpPi/4kwKqDlTBl0p+tuw6kfkbk4I1onj87sEgIez+MIp
        h78qwQcKYx7wObfCN3jkI3Q17SEtDNhmjqnvPlK3l1ANkwWyPLPKY1TcMKKpbl4Q2gyfF+SvAMbim
        /UAgTlXmKi/S0KUyVqg9DSwuF3ECnWyJqFKNSI7Z3BjHDLmt7k/L3manHbxoqI1Puds6jWicOD9Gz
        P5kZ/yRwl/sIse8LeGBWKWHuSmYgF7AJ3PVlumDKhzeb18mR0oFcFoPALEGmu8XLysWjxqmgDKtKm
        Q3j4tNZw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54036 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1asjzU-000cge-1A; Wed, 20 Apr 2016 04:43:54 +0000
Subject: Re: next: fuloong2e qemu boot failure due to 'MIPS: Loongson:
 AddLoongson-3A R2 basic support'
To:     =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
References: <20160420025454.GA17200@roeck-us.net>
 <tencent_5BBD94596E55516D1B4FED5F@qq.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-next <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5717090E.2050004@roeck-us.net>
Date:   Tue, 19 Apr 2016 21:43:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <tencent_5BBD94596E55516D1B4FED5F@qq.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 04/19/2016 08:37 PM, 陈华才 wrote:
> Hi,
>
> Could you please remove the line "#define cpu_hwrena_impl_bits    0xc0000000" in arch/mips/include/asm/mach-loongson64/cpu-feature-overrides.h and try again?Thanks.
>

That fixes the problem.

Does this need to be addressed in qemu or in the Linux kernel ?

Thanks,
Guenter

> Huacai
>
> ------------------ Original ------------------
> From:  "Guenter Roeck"<linux@roeck-us.net>;
> Date:  Wed, Apr 20, 2016 10:54 AM
> To:  "Huacai Chen"<chenhc@lemote.com>;
> Cc:  "Ralf Baechle"<ralf@linux-mips.org>; "linux-mips"<linux-mips@linux-mips.org>; "linux-next"<linux-next@vger.kernel.org>; "linux-kernel"<linux-kernel@vger.kernel.org>;
> Subject:  next: fuloong2e qemu boot failure due to 'MIPS: Loongson: AddLoongson-3A R2 basic support'
>
> Hi,
>
> qemu fails to boot in -next for machine fulong2e with configuration
> fuloong2e_defconfig. Bisect points to commit 'MIPS: Loongson: Add
> Loongson-3A R2 basic support'. qemu hangs in boot, after displaying
> "Inode-cache hash table entries: 16384 (order: 3, 131072 bytes)".
>
> Bisect log is attached.
>
> Guenter
>
> ---
> # bad: [1bd7a2081d2c7b096f75aa934658e404ccaba5fd] Add linux-next specific files for 20160418
> # good: [bf16200689118d19de1b8d2a3c314fc21f5dc7bb] Linux 4.6-rc3
> git bisect start 'HEAD' 'v4.6-rc3'
> # bad: [493ac92ff65ec4c4cd4c43870e778760a012951d] Merge remote-tracking branch 'ipvs-next/master'
> git bisect bad 493ac92ff65ec4c4cd4c43870e778760a012951d
> # bad: [20ca3ae9c517eee9b2f1bd0fb2a06e2d14153792] Merge remote-tracking branch 'btrfs-kdave/for-next'
> git bisect bad 20ca3ae9c517eee9b2f1bd0fb2a06e2d14153792
> # good: [c454e65fb9ade11d0f84718d06a6888e2c92804d] Merge remote-tracking branch 'omap/for-next'
> git bisect good c454e65fb9ade11d0f84718d06a6888e2c92804d
> # good: [6f5c70fb9b4fc0534157bfa40cea9b402e6f2506] Merge remote-tracking branch 'microblaze/next'
> git bisect good 6f5c70fb9b4fc0534157bfa40cea9b402e6f2506
> # bad: [7f053cd68fd14243c8f202b4086d7dd75c409e6f] MIPS: Loongson-3: Introduce CONFIG_LOONGSON3_ENHANCEMENT
> git bisect bad 7f053cd68fd14243c8f202b4086d7dd75c409e6f
> # good: [e9aacdd7f0b66c4ace17e5950c48e7cc61a253c8] MIPS: Allow RIXI to be used on non-R2 or R6 cores
> git bisect good e9aacdd7f0b66c4ace17e5950c48e7cc61a253c8
> # good: [d1e8b9a8dc6c7fa9add5dfa7083e035ce037e56d] MAINTAINERS: add Loongson1 architecture entry
> git bisect good d1e8b9a8dc6c7fa9add5dfa7083e035ce037e56d
> # good: [13ff6275bb389c3669082d3ef8483592a31eb0ea] MIPS: Fix siginfo.h to use strict posix types
> git bisect good 13ff6275bb389c3669082d3ef8483592a31eb0ea
> # good: [66e74bdd51e617023fa2e79a807b704fb3eed8aa] MIPS: Enable ptrace hw watchpoints on MIPS R6
> git bisect good 66e74bdd51e617023fa2e79a807b704fb3eed8aa
> # good: [f7cabc2dac8adf5986dbc700584bc3b8fe493d4d] MIPS: Loongson-3: Adjust irq dispatch to speedup processing
> git bisect good f7cabc2dac8adf5986dbc700584bc3b8fe493d4d
> # bad: [4978c8477e96fb9e9d870d8f42328dcabf1a65e9] MIPS: Loongson-3: Set cache flush handlers to cache_noop
> git bisect bad 4978c8477e96fb9e9d870d8f42328dcabf1a65e9
> # bad: [04a35922c1dac1b4864b8b366a37474e9e51d8c0] MIPS: Loongson: Add Loongson-3A R2 basic support
> git bisect bad 04a35922c1dac1b4864b8b366a37474e9e51d8c0
> # first bad commit: [04a35922c1dac1b4864b8b366a37474e9e51d8c0] MIPS: Loongson: Add Loongson-3A R2 basic support
>
