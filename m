Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2016 08:47:24 +0200 (CEST)
Received: from cassarossa.samfundet.no ([193.35.52.29]:39368 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042593AbcFFGrWWix6D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2016 08:47:22 +0200
Received: from egtvedt by cassarossa.samfundet.no with local (Exim 4.84_2)
        (envelope-from <egtvedt@samfundet.no>)
        id 1b9oGT-0003rb-RN; Mon, 06 Jun 2016 08:43:57 +0200
Date:   Mon, 6 Jun 2016 08:43:57 +0200
From:   Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
To:     Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Steven Miao <realmz6@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Kuo <rkuo@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Hogan <james.hogan@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Ley Foon Tan <lftan@altera.com>,
        Jonas Bonn <jonas@southpole.se>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Geoff Levand <geoff@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Muli Ben-Yehuda <muli@il.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@linux.ie>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        discuss@x86-64.org, linux-pci@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-rdma@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-media@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        hch@infradead.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFC v3 07/45] avr32: dma-mapping: Use unsigned long for
 dma_attrs
Message-ID: <20160606064357.GA7998@samfundet.no>
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
 <1464881987-13203-8-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464881987-13203-8-git-send-email-k.kozlowski@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <egtvedt@samfundet.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: egtvedt@samfundet.no
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

Around Thu 02 Jun 2016 17:39:09 +0200 or thereabout, Krzysztof Kozlowski wrote:
> Split out subsystem specific changes for easier reviews. This will be
> squashed with main commit.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/mm/dma-coherent.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/avr32/mm/dma-coherent.c b/arch/avr32/mm/dma-coherent.c
> index 92cf1fb2b3e6..fc51f4421933 100644
> --- a/arch/avr32/mm/dma-coherent.c
> +++ b/arch/avr32/mm/dma-coherent.c
> @@ -99,7 +99,7 @@ static void __dma_free(struct device *dev, size_t size,
>  }
>  
>  static void *avr32_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
> +		dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
>  {
>  	struct page *page;
>  	dma_addr_t phys;
> @@ -119,7 +119,7 @@ static void *avr32_dma_alloc(struct device *dev, size_t size,
>  }
>  
>  static void avr32_dma_free(struct device *dev, size_t size,
> -		void *cpu_addr, dma_addr_t handle, struct dma_attrs *attrs)
> +		void *cpu_addr, dma_addr_t handle, unsigned long attrs)
>  {
>  	struct page *page;
>  
> @@ -142,7 +142,7 @@ static void avr32_dma_free(struct device *dev, size_t size,
>  
>  static dma_addr_t avr32_dma_map_page(struct device *dev, struct page *page,
>  		unsigned long offset, size_t size,
> -		enum dma_data_direction direction, struct dma_attrs *attrs)
> +		enum dma_data_direction direction, unsigned long attrs)
>  {
>  	void *cpu_addr = page_address(page) + offset;
>  
> @@ -152,7 +152,7 @@ static dma_addr_t avr32_dma_map_page(struct device *dev, struct page *page,
>  
>  static int avr32_dma_map_sg(struct device *dev, struct scatterlist *sglist,
>  		int nents, enum dma_data_direction direction,
> -		struct dma_attrs *attrs)
> +		unsigned long attrs)
>  {
>  	int i;
>  	struct scatterlist *sg;
-- 
mvh
Hans-Christian Noren Egtvedt
