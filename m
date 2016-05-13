Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2016 08:32:39 +0200 (CEST)
Received: from smtprelay2.synopsys.com ([198.182.60.111]:55557 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27028490AbcEMGcetQEMd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2016 08:32:34 +0200
Received: from us02secmta1.synopsys.com (us02secmta1.synopsys.com [10.12.235.96])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3292E10C11E9;
        Thu, 12 May 2016 23:32:27 -0700 (PDT)
Received: from us02secmta1.internal.synopsys.com (us02secmta1.internal.synopsys.com [127.0.0.1])
        by us02secmta1.internal.synopsys.com (Service) with ESMTP id 1829E4E215;
        Thu, 12 May 2016 23:32:27 -0700 (PDT)
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by us02secmta1.internal.synopsys.com (Service) with ESMTP id ABAD34E214;
        Thu, 12 May 2016 23:32:26 -0700 (PDT)
Received: from mailhost.synopsys.com (localhost [127.0.0.1])
        by mailhost.synopsys.com (Postfix) with ESMTP id 87D6D3E0;
        Thu, 12 May 2016 23:32:26 -0700 (PDT)
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id A85063D6;
        Thu, 12 May 2016 23:32:25 -0700 (PDT)
Received: from US01WEHTC1.internal.synopsys.com (10.12.239.235) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Thu, 12 May 2016 23:32:25 -0700
Received: from [10.12.65.81] (10.12.65.81) by us01wehtc1.internal.synopsys.com
 (10.12.239.231) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 12 May
 2016 23:32:19 -0700
Subject: Re: [PATCH v3] usb: dwc2: fix regression on big-endian PowerPC/ARM
 systems
To:     Arnd Bergmann <arnd@arndb.de>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
References: <1463086588-2393828-1-git-send-email-arnd@arndb.de>
From:   John Youn <John.Youn@synopsys.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "John.Youn@synopsys.com" <John.Youn@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.seppala@gmail.com" <a.seppala@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Felipe Balbi <balbi@ti.com>,
        "Douglas Anderson" <dianders@chromium.org>,
        Gregory Herrero <gregory.herrero@intel.com>,
        Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <573574F2.8010901@synopsys.com>
Date:   Thu, 12 May 2016 23:32:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <1463086588-2393828-1-git-send-email-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.12.65.81]
Return-Path: <John.Youn@synopsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: John.Youn@synopsys.com
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

On 5/12/2016 1:56 PM, Arnd Bergmann wrote:
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
> Felipe suggested a different approach, using an endianess switching
> register to always put the device into LE mode, but unfortunately
> the dwc2 hardware does not provide a generic way to do that. Also,
> I see no practical way of addressing the problem more generally by
> patching architecture specific code on MIPS.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 95c8bc360944 ("usb: dwc2: Use platform endianness when accessing registers")
> ---
> v3: reverted the accidental changes that slipped into the patch,
>     resending as requested by Christian.
> 
>  drivers/usb/dwc2/core.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
> index 3c58d633ce80..74ed2ee881cd 100644
> --- a/drivers/usb/dwc2/core.h
> +++ b/drivers/usb/dwc2/core.h
> @@ -64,6 +64,18 @@
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
> @@ -90,6 +102,23 @@ static inline void dwc2_writel(u32 value, void __iomem *addr)
>  	pr_info("INFO:: wrote %08x to %p\n", value, addr);
>  #endif
>  }
> +#else
> +/* Normal architectures just use readl/write */
> +static inline u32 dwc2_readl(const void __iomem *addr)
> +{
> +	u32 value = readl(addr);
> +	return value;
> +}
> +
> +static inline void dwc2_writel(u32 value, void __iomem *addr)
> +{
> +	writel(value, addr);
> +
> +#ifdef dwc2_log_writes

Hi Arnd,

The capitalization issue is still there in this patch.

There's also a few checkpatch issues.

And should the barrier be moved after the write like it says in the
comment? That seems to have been removed since earlier versions of
the patch.

Regards,
John
