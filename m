Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 May 2016 13:28:11 +0200 (CEST)
Received: from mga04.intel.com ([192.55.52.120]:45037 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029292AbcELL2G4wxYn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 May 2016 13:28:06 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP; 12 May 2016 04:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,609,1455004800"; 
   d="scan'208";a="978304053"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.36])
  by fmsmga002.fm.intel.com with ESMTP; 12 May 2016 04:27:57 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-mips@linux-mips.org, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.seppala@gmail.com,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        Felipe Balbi <balbi@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gregory Herrero <gregory.herrero@intel.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] usb: dwc2: fix regression on big-endian PowerPC/ARM systems
In-Reply-To: <1463050104-2788693-1-git-send-email-arnd@arndb.de>
References: <1463050104-2788693-1-git-send-email-arnd@arndb.de>
User-Agent: Notmuch/0.22+11~g124a67e (http://notmuchmail.org) Emacs/25.0.93.2 (x86_64-pc-linux-gnu)
Date:   Thu, 12 May 2016 14:25:49 +0300
Message-ID: <8760ujecw2.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <felipe.balbi@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: felipe.balbi@linux.intel.com
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


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> A patch that went into Linux-4.4 to fix big-endian mode on a Lantiq
> MIPS system unfortunately broke big-endian operation on PowerPC
> APM82181 as reported by Christian Lamparter, and likely other
> systems.
>
> It actually introduced multiple issues:
>
> - it broke big-endian ARM kernels: any machine that was working
>   correctly with a little-endian kernel is no longer using byteswaps
>   on big-endian kernels, which clearly breaks them.
> - On PowerPC the same thing must be true: if it was working before,
>   using big-endian kernels is now broken. Unlike ARM, 32-bit PowerPC
>   usually uses big-endian kernels, so they are likely all broken.
> - The barrier for dwc2_writel is on the wrong side of the __raw_writel(),
>   so the MMIO no longer synchronizes with DMA operations.
> - On architectures that require specific CPU instructions for MMIO
>   access, using the __raw_ variant may turn this into a pointer
>   dereference that does not have the same effect as the readl/writel.
>
> This patch is a simple revert for all architectures other than MIPS,
> in the hope that we can more easily backport it to fix the regression
> on PowerPC and ARM systems without breaking the Lantiq system again.
>
> We should follow this up with a more elaborate change to add runtime
> detection of endianess, to make sure it also works on all other
> combinations of architectures and implementations of the usb-dwc2
> device. That patch however will be fairly large and not appropriate
> for backports to stable kernels.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 95c8bc360944 ("usb: dwc2: Use platform endianness when accessing registers")
> ---
>  drivers/usb/dwc2/core.h | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index 3c58d633ce80..1f8ed149a40f 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -64,12 +64,24 @@
>  	DWC2_TRACE_SCHEDULER_VB(pr_fmt("%s: SCH: " fmt),		\
>  				dev_name(hsotg->dev), ##__VA_ARGS__)
>  
> +
> +#ifdef CONFIG_MIPS
> +/*
> + * There are some MIPS machines that can run in either big-endian
> + * or little-endian mode and that use the dwc2 register without
> + * a byteswap in both ways.
> + * Unlike other architectures, MIPS does not require a barrier
> + * before the __raw_writel() to synchronize with DMA but does
> + * require the barrier after the writel() to serialize a series
> + * of writes. This set of operations was added specifically for
> + * MIPS and should only be used there.
> + */
>  static inline u32 dwc2_readl(const void __iomem *addr)
>  {
>  	u32 value = __raw_readl(addr);
>  
> -	/* In order to preserve endianness __raw_* operation is used. Therefore
> -	 * a barrier is needed to ensure IO access is not re-ordered across
> +	/* in order to preserve endianness __raw_* operation is used. therefore
> +	 * a barrier is needed to ensure io access is not re-ordered across
>  	 * reads or writes
>  	 */
>  	mb();
> @@ -81,15 +93,32 @@ static inline void dwc2_writel(u32 value, void __iomem *addr)
>  	__raw_writel(value, addr);
>  
>  	/*
> -	 * In order to preserve endianness __raw_* operation is used. Therefore
> -	 * a barrier is needed to ensure IO access is not re-ordered across
> +	 * in order to preserve endianness __raw_* operation is used. therefore
> +	 * a barrier is needed to ensure io access is not re-ordered across
>  	 * reads or writes
>  	 */
>  	mb();
> -#ifdef DWC2_LOG_WRITES
> -	pr_info("INFO:: wrote %08x to %p\n", value, addr);
> +#ifdef dwc2_log_writes
> +	pr_info("info:: wrote %08x to %p\n", value, addr);
>  #endif
>  }
> +#else

I still think this is something that should be handled at MIPS side, no ?

How many more drivers will we have to 'fix' like this ?

-- 
balbi
