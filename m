Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2012 17:59:55 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:64177 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902243Ab2FOP7s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jun 2012 17:59:48 +0200
Received: by dadm1 with SMTP id m1so4270866dad.36
        for <multiple recipients>; Fri, 15 Jun 2012 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=F4SzQnVrwGCPbmbh+6y5j54K9YhTrzGVIIt/tt04s18=;
        b=HgHjzz2oL6kCMnb3i8TBn8h51KpuUQVa33jBHE64LyfamKAtcSpJmEt8z/2dz7FnxK
         tKL2+mmttH8fI1gSmpvfhk9jJODFOH3xT0FjZpDhk4lmcq1gscZ89rQS+G6d7Xe4q8TQ
         oLVuDZiZS68+274ureUgPPGwp70G5/PO3OIfBo/bv0DKx+w8FxrPe326xAj+7XYdlvXC
         q2nS3FSJLF1bXesnHQOwgX/wA7acS9zuY2El/lIoBtHJvAn2H9hebQjbiCJf8sXdSnSE
         cb44Gzm7FB7tpW5gG/mOrCci7jdj1Sk1PARFOE7DVXV0E/IYWGOocfViSWoaNy+fs3T3
         7NnQ==
Received: by 10.68.130.3 with SMTP id oa3mr1139954pbb.62.1339775980876;
        Fri, 15 Jun 2012 08:59:40 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ny4sm13630020pbb.57.2012.06.15.08.59.38
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 08:59:39 -0700 (PDT)
Message-ID: <4FDB5BE9.1090303@gmail.com>
Date:   Fri, 15 Jun 2012 08:59:37 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Huacai Chen <chenhuacai@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH 01/14] MIPS: Loongson: Add basic Loongson 3 CPU support.
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com> <1339747801-28691-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1339747801-28691-2-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 06/15/2012 01:09 AM, Huacai Chen wrote:
> Loongson-3 is a multi-core MIPS family CPU, it support MIPS64R2
> fully. Loongson-3 has the same IMP field (0x6300) as Loongson-2.
>
> Loongson-3 has a hardware-maintained cache, system software doesn't
> need to maintain coherency.
>
> Loongson-3A is the first revision of Loongson-3, and it is the quad-
> core version of Loongson-2G. Loongson-3A has a simplified version named
> Loongson-2Gq, the main difference between Loongson-3A/2Gq is 3A has two
> HyperTransport controller but 2Gq has only one. HT0 is used for cross-
> chip interconnection and HT1 is used to link PCI bus. Therefore, 2Gq
> cannot support NUMA but 3A can.
>
> Exsisting Loongson family CPUs:
> Loongson-1: Loongson-1A, Loongson-1B, they are 32-bit MIPS CPUs.
> Loongson-2: Loongson-2E, Loongson-2F, Loongson-2G(including Loongson-
>              2Gq), they are 64-bit MIPS CPUs.
> Loongson-3: Loongson-3A, it is a 64-bit MIPS CPU.
>
> Signed-off-by: Huacai Chen<chenhc@lemote.com>
> Signed-off-by: Hongliang Tao<taohl@lemote.com>
> Signed-off-by: Hua Yan<yanh@lemote.com>
> ---
>   arch/mips/Kconfig                            |   13 ++++
>   arch/mips/include/asm/addrspace.h            |    6 ++
>   arch/mips/include/asm/cpu.h                  |    6 +-
>   arch/mips/include/asm/mach-loongson/spaces.h |   15 +++++
>   arch/mips/include/asm/module.h               |    2 +
>   arch/mips/include/asm/pgtable-bits.h         |    7 ++
>   arch/mips/kernel/Makefile                    |    1 +
>   arch/mips/kernel/cpu-probe.c                 |   12 +++-
>   arch/mips/lib/Makefile                       |    1 +
>   arch/mips/loongson/Kconfig                   |    4 +
>   arch/mips/loongson/Platform                  |    1 +
>   arch/mips/loongson/common/env.c              |    3 +
>   arch/mips/loongson/common/setup.c            |    6 +-
>   arch/mips/mm/Makefile                        |    1 +
>   arch/mips/mm/c-r4k.c                         |   84 ++++++++++++++++++++++++++
>   arch/mips/mm/tlb-r4k.c                       |    2 +-
>   arch/mips/mm/tlbex.c                         |    1 +
>   17 files changed, 156 insertions(+), 9 deletions(-)

This patch is too big.  It should be split up into smaller but related 
parts.

For example, the parts that add new identifier constants should be 
first.  Then a separate patch for cpu-probe.c where they are used.

And...

>   create mode 100644 arch/mips/include/asm/mach-loongson/spaces.h
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index c179461..38e460b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1544,6 +1544,16 @@ config CPU_LOONGSON2
>   	select CPU_SUPPORTS_64BIT_KERNEL
>   	select CPU_SUPPORTS_HIGHMEM
>
> +config CPU_LOONGSON3
> +	bool "Loongson 3 CPU"
> +	depends on SYS_HAS_CPU_LOONGSON3
> +	select CPU_SUPPORTS_32BIT_KERNEL
> +	select CPU_SUPPORTS_64BIT_KERNEL
> +	select CPU_SUPPORTS_HIGHMEM
> +	help
> +		The Loongson 3 processor implements the MIPS III instruction set
> +		with many extensions.
> +

This bit must be the very last patch of the entire set, not the first.

Ask yourself what would happen if someone did a build selecting 
CPU_LOONGSON3 after this patch were applied?  Would a runnable kernel 
result?  If the answer is no, then you did it in the wrong order.

David Daney
