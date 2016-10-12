Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Oct 2016 13:09:50 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:58449 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992354AbcJLLJkoQT4P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Oct 2016 13:09:40 +0200
Received: from [10.200.120.53] (unknown [94.186.205.99])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 90B44100036;
        Wed, 12 Oct 2016 13:09:39 +0200 (CEST)
Subject: Re: [PATCH v3 4/4] MIPS: Deprecate VPE Loader
To:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1476193356-1350-1-git-send-email-matt.redfearn@imgtec.com>
 <1476193356-1350-5-git-send-email-matt.redfearn@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-remoteproc@vger.kernel.org,
        lisa.parratt@imgtec.com, linux-kernel@vger.kernel.org,
        olaf.wachendorf@intel.com, hauke.mehrtens@intel.com
From:   Hauke Mehrtens <hauke@hauke-m.de>
X-Enigmail-Draft-Status: N1110
Message-ID: <c4d01a54-7a68-c9ee-bc5c-ac01743f7269@hauke-m.de>
Date:   Wed, 12 Oct 2016 13:09:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <1476193356-1350-5-git-send-email-matt.redfearn@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

This interface is currently used by the Intel / Lantiq voice Firmware.
This firmware is used by all Intel / Lantiq MIPS SoCs when they should
support analog voice.

What is the proposed timeline for the removal of this interface?

Hauke

On 10/11/2016 03:42 PM, Matt Redfearn wrote:
> The MIPS remote processor driver (CONFIG_MIPS_RPROC) provides a more
> standard mechanism for using one or more VPs as coprocessors running
> separate firmware.
> 
> Here we deprecate this mechanism before it is removed.
> 
> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  arch/mips/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index fd2468e71e63..3e767c373c7b 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2264,7 +2264,7 @@ comment "MIPS R2-to-R6 emulator is only available for UP kernels"
>  	depends on SMP && CPU_MIPSR6
>  
>  config MIPS_VPE_LOADER
> -	bool "VPE loader support."
> +	bool "VPE loader support (DEPRECATED)"
>  	depends on SYS_SUPPORTS_MULTITHREADING && MODULES
>  	select CPU_MIPSR2_IRQ_VI
>  	select CPU_MIPSR2_IRQ_EI
> @@ -2273,6 +2273,9 @@ config MIPS_VPE_LOADER
>  	  Includes a loader for loading an elf relocatable object
>  	  onto another VPE and running it.
>  
> +	  Unless you have a specific need, you should use CONFIG_MIPS_RPROC
> +          instead of this.
> +
>  config MIPS_VPE_LOADER_CMP
>  	bool
>  	default "y"
> 
