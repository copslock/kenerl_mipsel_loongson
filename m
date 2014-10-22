Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 08:43:12 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:57261 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011234AbaJVGnKV0ppg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Oct 2014 08:43:10 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id D90252800EA;
        Wed, 22 Oct 2014 08:42:05 +0200 (CEST)
Received: from dicker-alter.lan (p548C87DD.dip0.t-ipconnect.de [84.140.135.221])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 22 Oct 2014 08:42:05 +0200 (CEST)
Message-ID: <544751F4.3080304@openwrt.org>
Date:   Wed, 22 Oct 2014 08:43:00 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Varka Bhadram <varkabhadram@gmail.com>, linux-mips@linux-mips.org
CC:     ralf@linux-mips.org, Varka Bhadram <varkab@cdac.in>
Subject: Re: [PATCH mips] pci: pci-lantiq: remove duplicate check on resource
References: <1413950475-29451-1-git-send-email-varkab@cdac.in>
In-Reply-To: <1413950475-29451-1-git-send-email-varkab@cdac.in>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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


Hi Vara,

On 22/10/2014 06:01, Varka Bhadram wrote:
> Sanity check on resource happening with devm_ioremap_resource()
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>

Acked-by: John Crispin <blogic@openwrt.org>


Thanks for the fix !


> ---
> 
> This patch based on master brnch of 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/ralf/linux
> tree.
> 
> Thanks.
> 
> arch/mips/pci/pci-lantiq.c |    7 +------ 1 file changed, 1
> insertion(+), 6 deletions(-)
> 
> diff --git a/arch/mips/pci/pci-lantiq.c
> b/arch/mips/pci/pci-lantiq.c index 37fe8e7..d3ed15b 100644 ---
> a/arch/mips/pci/pci-lantiq.c +++ b/arch/mips/pci/pci-lantiq.c @@
> -215,17 +215,12 @@ static int ltq_pci_probe(struct platform_device
> *pdev)
> 
> pci_clear_flags(PCI_PROBE_ONLY);
> 
> -	res_cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0); 
> res_bridge = platform_get_resource(pdev, IORESOURCE_MEM, 1); -	if
> (!res_cfg || !res_bridge) { -		dev_err(&pdev->dev, "missing memory
> resources\n"); -		return -EINVAL; -	} - ltq_pci_membase =
> devm_ioremap_resource(&pdev->dev, res_bridge); if
> (IS_ERR(ltq_pci_membase)) return PTR_ERR(ltq_pci_membase);
> 
> +	res_cfg = platform_get_resource(pdev, IORESOURCE_MEM, 0); 
> ltq_pci_mapped_cfg = devm_ioremap_resource(&pdev->dev, res_cfg); if
> (IS_ERR(ltq_pci_mapped_cfg)) return PTR_ERR(ltq_pci_mapped_cfg);
> 
