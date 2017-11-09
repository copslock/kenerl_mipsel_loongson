Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 10:17:20 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:52435 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990493AbdKIJRGd0xjw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 10:17:06 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 09 Nov 2017 09:16:47 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 9 Nov 2017
 01:16:46 -0800
Subject: Re: [PATCH AUTOSEL for-4.4 39/39] MIPS: Use Makefile.postlink to
 insert relocations into vmlinux
To:     "Levin, Alexander (Sasha Levin)" <alexander.levin@one.verizon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20171108205027.27525-1-alexander.levin@verizon.com>
 <20171108205027.27525-39-alexander.levin@verizon.com>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <fc334f42-f3ca-b03c-d8de-ce7d9ffdf5e3@mips.com>
Date:   Thu, 9 Nov 2017 09:16:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171108205027.27525-39-alexander.levin@verizon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1510219006-321457-5685-46572-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186748
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60796
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



On 08/11/17 20:50, Levin, Alexander (Sasha Levin) wrote:
> From: Matt Redfearn <matt.redfearn@imgtec.com>
>
> [ Upstream commit 44079d3509aee89c58f3e4fd929fa53ab2299019 ]
>
> When relocatable support for MIPS was merged, there was no support for
> an architecture to add a postlink step for vmlinux. This meant that only
> invoking a target within the boot directory, such as uImage, caused the
> relocations to be inserted into vmlinux. Building just the vmlinux
> target would result in a relocatable kernel with no relocation
> information present.
>
> Commit fbe6e37dab97 ("kbuild: add arch specific post-link Makefile")

Hi,

This patch depends on upstream commit fbe6e37dab97 ("kbuild: add arch 
specific post-link Makefile") which was introduced in v4.9.

This patch is an improvement to the build flow and I would not consider 
it for backporting - certainly not to v4.8 or earlier which is missing 
the dependency. Applying it will not break anything, however, it will 
perform no function either without the supporting dependency.

Thanks,
Matt


> recified this situation, so MIPS can now define a postlink step to add
> relocation information into vmlinux, and remove the additional steps
> tacked onto boot targets.
>
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> Tested-by: Steven J. Hill <steven.hill@cavium.com>
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> Patchwork: https://patchwork.linux-mips.org/patch/14554/
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
> ---
>   arch/mips/Makefile.postlink | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 arch/mips/Makefile.postlink
>
> diff --git a/arch/mips/Makefile.postlink b/arch/mips/Makefile.postlink
> new file mode 100644
> index 000000000000..b0ddf0701a31
> --- /dev/null
> +++ b/arch/mips/Makefile.postlink
> @@ -0,0 +1,35 @@
> +# ===========================================================================
> +# Post-link MIPS pass
> +# ===========================================================================
> +#
> +# 1. Insert relocations into vmlinux
> +
> +PHONY := __archpost
> +__archpost:
> +
> +include include/config/auto.conf
> +include scripts/Kbuild.include
> +
> +CMD_RELOCS = arch/mips/boot/tools/relocs
> +quiet_cmd_relocs = RELOCS $@
> +      cmd_relocs = $(CMD_RELOCS) $@
> +
> +# `@true` prevents complaint when there is nothing to be done
> +
> +vmlinux: FORCE
> +	@true
> +ifeq ($(CONFIG_RELOCATABLE),y)
> +	$(call if_changed,relocs)
> +endif
> +
> +%.ko: FORCE
> +	@true
> +
> +clean:
> +	@true
> +
> +PHONY += FORCE clean
> +
> +FORCE:
> +
> +.PHONY: $(PHONY)
