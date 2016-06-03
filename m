Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 09:56:02 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:10629 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27039906AbcFCH4BDEYPm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 09:56:01 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8600L5ERD5AIA0@mailout1.w1.samsung.com>; Fri,
 03 Jun 2016 08:55:54 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-7f-575138090a60
Received: from eusync3.samsung.com ( [203.254.199.213])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id C5.8B.04866.90831575; Fri,
 3 Jun 2016 08:55:53 +0100 (BST)
Received: from [106.120.53.17] by eusync3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0O86002CZRD21860@eusync3.samsung.com>; Fri,
 03 Jun 2016 08:55:53 +0100 (BST)
Subject: Re: [RFC v3 01/45] powerpc: dma-mapping: Don't hard-code the value of
 DMA_ATTR_WEAK_ORDERING
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
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
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <1464881987-13203-1-git-send-email-k.kozlowski@samsung.com>
 <1464881987-13203-2-git-send-email-k.kozlowski@samsung.com>
Cc:     hch@infradead.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <57513804.9020309@samsung.com>
Date:   Fri, 03 Jun 2016 09:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-version: 1.0
In-reply-to: <1464881987-13203-2-git-send-email-k.kozlowski@samsung.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0yTZxTH97zPeytZk9eK8qjJTJqYZY2y4bbkeA1+WPImxgSXbYgf1Ipv
        Chsga4HMfbGC9TbqXmA4KbVBWgW05RrCZTBCNSCwKp2O3cRuSLlKqRccWsC1dmZ++51zfuef
        kycPj1UOdjWfnpUj6bO0GWo2hh5Y6v1lgwJ2J7/Xd+EtON0W4qC33siC+WYfBdY6JwuLxT0c
        NJyvYyCYb8LgyE8D7/cmGmYvFyKoqt4Fvkd/Igjkh2hYmnmA4c7cLAtFNSUYvqkd4eDEuR1g
        HfcgGPujkwLH5Hbo/u0pBwNyJQXnGuJgfq4gvNjfgKGiawsEbBMYfLVXGBh3WzBYf98IC2VB
        Ck6X13MwPZEAl+1+BH75LguB4esILF3DNDTeH2KgqMvDwfVymYLqq7UYLp5w0HDjbJCB2eOt
        LARPBRi43W5loWrUhaGwvjlcFngjV52kQS4t5qDc8S0NI/2DFHhsvSyMuc00PPrrBQb5YgGG
        87d+DL/HwncYTHddFNR4XBy4SzsRhP5ZYhJTxNFuGyWaOmVWdNqcSLw95MVi6HkxEn+tTRKn
        S+Rw66yZErtH3KxYOWmkxTbLMCcGH+4TKxpzxcK2n5DYVK0R7R2TVNKHe2O2HpIy0vMk/bvb
        D8SkXStismXFV03GGmREHu4MUvBE+IDcue//j1eSwXt17BkUw6uES4j02p9T0WIMkWd/25mI
        tVzQEad3FEUGsUIhIbaZKRS1TIhcaDbiiIWFnST4uJOKMCu8T5qqHGyElYKGtLQWvGRaWEc6
        8s0vU1cIe4ilZZ6KOsvIfMk9OsIKQSQn+56F+3w4M574vJpo/FrS5JzBMhIsr21Y/rcsr1kV
        CF9BK6Tc1GzDQV3mxniDNtOQm6WLTz2c2Yiif3euFV3q2exGAo/UbyrfsCclqxhtnuFIphsR
        Hqtjlama3ckq5SHtka8l/eH9+twMyeBGa3haHacsa5/9RCXotDnSF5KULelfTSlesdqI7P05
        Zatc1U5VenPgyYOsGr85sdK0LrthXOUrXbYBf0n5V6211CfBgPR24mLswbiWY2bdR59u2jdt
        gE3x2+xT1tYq5tRTRU4oqHtnausPCyt3OrqHl17cwD/7xq4lh7Bps67n1vqPXe69+zMSbk60
        Bz9Ly/tcf3SxY3TwwB4qZUhNG9K0CRqsN2j/Baij/vG3AwAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

On 06/02/2016 05:39 PM, Krzysztof Kozlowski wrote:
> Hard-coded value of DMA_ATTR_WEAK_ORDERING is then compared with the
> symbol.  This will stop matching if the value of symbol is changed (when
> switching DMA attributes to unsigned long).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/powerpc/platforms/cell/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
> index 14a582b21274..0c2794d2b6c0 100644
> --- a/arch/powerpc/platforms/cell/iommu.c
> +++ b/arch/powerpc/platforms/cell/iommu.c
> @@ -1162,7 +1162,7 @@ static int __init setup_iommu_fixed(char *str)
>  	pciep = of_find_node_by_type(NULL, "pcie-endpoint");
>  
>  	if (strcmp(str, "weak") == 0 || (pciep && strcmp(str, "strong") != 0))
> -		iommu_fixed_is_weak = 1;
> +		iommu_fixed_is_weak = DMA_ATTR_WEAK_ORDERING;

After some more thoughts given to this, I think my fix is not correct.
The 'iommu_fixed_is_weak' stores the bool and it is used to compare with
result of test_bit().

Please ignore this patch.

Best regards,
Krzysztof
