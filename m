Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2015 04:49:36 +0200 (CEST)
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34726 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006940AbbENCtfIkeS6 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 14 May 2015 04:49:35 +0200
Received: by qkgx75 with SMTP id x75so41751699qkg.1;
        Wed, 13 May 2015 19:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xV8T8UNuBfU0ncH0nnl4TYZTHAREF3y/RqeLU5egrSE=;
        b=RMl5gzFWCXABrWhehJtpb2H6Kgt+CUEuq/7ts3yK3esuxaQEUzUe6Ftk0BoxFF/IVf
         2BuasCM7Layn8J4DwmSLkRSaABl7Pdcp63GYnFnV8JVM6ExOk8vunSRK1dNZUsDM+514
         JtNn5hXV22teQS7ZHLZctugKAvARVRVSufKzoI19fY+uRH0y/9eoZRzS15YI5p+W7rBg
         E35m+yiwTOSB7he/z427r7oIDD7jfHUtDpytqq/Cm3PaLOE6SZ2oq07jjffidD9fmikj
         zjG0/CWphwabZyJM/0sspBEEsH4zQM36/DuQWoHzb8E74PxhNbwiaYDHFnV46ic0tx0L
         5gWg==
X-Received: by 10.140.100.200 with SMTP id s66mr2538490qge.1.1431571771604;
 Wed, 13 May 2015 19:49:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.94.117 with HTTP; Wed, 13 May 2015 19:49:11 -0700 (PDT)
In-Reply-To: <20150514014924.36593.68642.stgit@ubuntu-yegoshin>
References: <20150514014924.36593.68642.stgit@ubuntu-yegoshin>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 13 May 2015 19:49:11 -0700
Message-ID: <CAJiQ=7CU+MyaypO-9Np8aChVpVX_Vobdtoytt0q4Vz7LY9qHsA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Flush cache after DMA_FROM_DEVICE for agressively
 speculative CPUs
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     mina86@mina86.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Zubair.Kakakhel@imgtec.com, Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Wed, May 13, 2015 at 6:49 PM, Leonid Yegoshin
<Leonid.Yegoshin@imgtec.com> wrote:
> Some MIPS CPUs have an aggressive speculative load and may erroneuosly load
> some cache line in the middle of DMA transaction. CPU discards result but cache
> doesn't. If DMA happens from device then additional cache invalidation is needed
> on that CPU's after DMA.
>
> Found in test.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> ---
>  arch/mips/mm/dma-default.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
> index 609d1241b0c4..ccf49ecfbf8c 100644
> --- a/arch/mips/mm/dma-default.c
> +++ b/arch/mips/mm/dma-default.c
> @@ -67,11 +67,13 @@ static inline struct page *dma_addr_to_page(struct device *dev,
>   * systems and only the R10000 and R12000 are used in such systems, the
>   * SGI IP28 Indigo² rsp. SGI IP32 aka O2.
>   */
> -static inline int cpu_needs_post_dma_flush(struct device *dev)
> +static inline int cpu_needs_post_dma_flush(struct device *dev,
> +                                          enum dma_data_direction direction)
>  {
>         return !plat_device_is_coherent(dev) &&
>                (boot_cpu_type() == CPU_R10000 ||
>                 boot_cpu_type() == CPU_R12000 ||
> +               (cpu_has_maar && (direction != DMA_TO_DEVICE)) ||
>                 boot_cpu_type() == CPU_BMIPS5000);

Can all of these CPUs safely skip the post_dma_flush on DMA_TO_DEVICE
(not just maar)?
