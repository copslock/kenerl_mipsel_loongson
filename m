Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Jan 2015 17:16:09 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:47683 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006810AbbAAQQH2jm6I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Jan 2015 17:16:07 +0100
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t01GG0l6005609
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 1 Jan 2015 08:16:00 -0800 (PST)
Received: from yow-pgortmak-d1 (128.224.56.57) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.174.1; Thu, 1 Jan 2015
 08:16:00 -0800
Received: by yow-pgortmak-d1 (Postfix, from userid 1000)        id A0E5BE1D1B2; Thu,
  1 Jan 2015 11:16:15 -0500 (EST)
Date:   Thu, 1 Jan 2015 11:16:15 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch: mips: pci: pci-ip27.c:  Remove unused function
Message-ID: <20150101161615.GH23085@windriver.com>
References: <1420126326-27198-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1420126326-27198-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

[[PATCH] arch: mips: pci: pci-ip27.c:  Remove unused function] On 01/01/2015 (Thu 16:32) Rickard Strandqvist wrote:

> Remove the function pci_enable_swapping() that is not used anywhere.

A quick search shows it has been orphanware since the git epoch (~2005)
so removing it should be fine AFAICT.

P.
--

> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  arch/mips/pci/pci-ip27.c |   11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
> index 0f09eaf..55e3332 100644
> --- a/arch/mips/pci/pci-ip27.c
> +++ b/arch/mips/pci/pci-ip27.c
> @@ -200,17 +200,6 @@ static inline void pci_disable_swapping(struct pci_dev *dev)
>  	bridge->b_widget.w_tflush;	/* Flush */
>  }
>  
> -static inline void pci_enable_swapping(struct pci_dev *dev)
> -{
> -	struct bridge_controller *bc = BRIDGE_CONTROLLER(dev->bus);
> -	bridge_t *bridge = bc->base;
> -	int slot = PCI_SLOT(dev->devfn);
> -
> -	/* Turn on byte swapping */
> -	bridge->b_device[slot].reg |= BRIDGE_DEV_SWAP_DIR;
> -	bridge->b_widget.w_tflush;	/* Flush */
> -}
> -
>  static void pci_fixup_ioc3(struct pci_dev *d)
>  {
>  	pci_disable_swapping(d);
> -- 
> 1.7.10.4
> 
