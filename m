Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Apr 2018 12:13:26 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:42374 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990431AbeDEKNN2sbk0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Apr 2018 12:13:13 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Thu, 05 Apr 2018 10:13:04 +0000
Received: from [192.168.155.41] (192.168.155.41) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Thu, 5 Apr
 2018 03:13:15 -0700
Subject: Re: [PATCH] MIPS: vmlinuz: Fix compiler intrinsics location and build
 directly
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>
References: <20180403160728.GB3275@saruman>
 <1522833502-28007-1-git-send-email-matt.redfearn@mips.com>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <b05a0ec9-d052-49c7-3e8f-2ba233d84f03@mips.com>
Date:   Thu, 5 Apr 2018 11:13:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522833502-28007-1-git-send-email-matt.redfearn@mips.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1522923184-452059-5278-50327-1
X-BESS-VER: 2018.4.1-r1804041913
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191706
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
X-archive-position: 63416
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

Hi James,

Actually, this patch would be better inserted as patch 3 in the series 
since it can pull in the generic ashldi3 before the MIPS one is removed 
in the final patch. Here's an updated commit message:

MIPS: vmlinuz: Use generic ashldi3 and build directly 

 

In preparation for removing some of the MIPS compiler intrinsics from 

arch/mips/lib, first update the build of vmlinuz to use the generic 

ashldi3 from lib. 

 

Both ashldi3 and bswapsi objects need to be built with different CFLAGS 

for inclusion to vmlinuz rather than simply including the object built 

for the main kernel image. But the current copy of the source C file to 

arch/mips/boot/compressed can be avoided by simply calling cmd,cc_o_c to 

build the object from the source directly. This also removes the need 

for the .gitignore file to ignore the copied files, and the extra-y rule 

to clean them.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Matt



On 04/04/18 10:18, Matt Redfearn wrote:
> Since commit "MIPS: use generic GCC library routines from lib/", MIPS
> now uses the generic lib/ashldi3.c, but bswapsi.c still comes from
> arch/mips/lib. The rules for including these into vmlinuz need updating
> to reflect these locations.
> Both objects need to be built with different CFLAGS for inclusion to
> vmlinuz rather than simply including the object built for the main
> kernel image. But the copy of the source C file can be avoided by simply
> calling cmd,cc_o_c to build the object from the source directly. This
> also removes the need for the .gitignore file to ignore the copied
> files, and the extra-y rule to clean them.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---
> 
>   arch/mips/boot/compressed/.gitignore | 2 --
>   arch/mips/boot/compressed/Makefile   | 8 ++++----
>   2 files changed, 4 insertions(+), 6 deletions(-)
>   delete mode 100644 arch/mips/boot/compressed/.gitignore
> 
> diff --git a/arch/mips/boot/compressed/.gitignore b/arch/mips/boot/compressed/.gitignore
> deleted file mode 100644
> index ebae133f1d00..000000000000
> --- a/arch/mips/boot/compressed/.gitignore
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -ashldi3.c
> -bswapsi.c
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index adce180f3ee4..8f04d659a915 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -46,10 +46,10 @@ $(obj)/uart-ath79.c: $(srctree)/arch/mips/ath79/early_printk.c
>   
>   vmlinuzobjs-$(CONFIG_KERNEL_XZ) += $(obj)/ashldi3.o $(obj)/bswapsi.o
>   
> -extra-y += ashldi3.c bswapsi.c
> -$(obj)/ashldi3.o $(obj)/bswapsi.o: KBUILD_CFLAGS += -I$(srctree)/arch/mips/lib
> -$(obj)/ashldi3.c $(obj)/bswapsi.c: $(obj)/%.c: $(srctree)/arch/mips/lib/%.c
> -	$(call cmd,shipped)
> +$(obj)/ashldi3.o: $(srctree)/lib/ashldi3.c
> +	$(call cmd,cc_o_c)
> +$(obj)/bswapsi.o: $(srctree)/arch/mips/lib/bswapsi.c
> +	$(call cmd,cc_o_c)
>   
>   targets := $(notdir $(vmlinuzobjs-y))
>   
> 
