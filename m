Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2014 01:49:48 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:51203 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843095AbaD3Xtlwbhgh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 May 2014 01:49:41 +0200
Received: by mail-ig0-f175.google.com with SMTP id h3so8327393igd.8
        for <linux-mips@linux-mips.org>; Wed, 30 Apr 2014 16:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=C/Gy+9YFrpHPlPppGGydoWtvEGMNUmchGMLWkLZfOU8=;
        b=VdpWQISsZPx6GQLt2LKScJrXEAxAzBdqd3U8NLWEqkq6p5BlZrtexrf6FNirME0lu4
         ZSL72TZXMh/w7AmD9qxJAIf3O1Z4/r51yIJr6Ck1aPzKuDB8LZEQ2/4QWoFNfeed4eP0
         fTBH4pHOSaePttYZqLJEuStmJtZ1BZre/TZPoH8/D7u9YpXA04jzzcxhVst3OKS5WbfG
         FmbdTUBdMnckP2WNcCkGcQ0Su0BJGWeBi5qDjH9XWHac7lT/m7ZyIB8DdLLl1UwFr6pS
         2ovnk+l48/ZJTL2+n84VfIZLMO2OVaEGNxGAOTmLQF1dEbefTYmNrvovZWvHTZwEymgW
         sI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=C/Gy+9YFrpHPlPppGGydoWtvEGMNUmchGMLWkLZfOU8=;
        b=PKMtdYPUDU0UWJdsN3J11eLuW115As4zfgxBV1EPmGXObCVlrQLAuW3XK3ZAgzdxlI
         B4tOs2O8z6JH2LHrCtsmlephuJVxH8sDLGh+eWYHvfCHFv77qj+VbdcBzCXhwmS/NvCD
         +6yedNIFSuvTUdlKwfZ6l9Y6Faz7iVWsmzzkdMUES/J+w+8wBwr8/5xhuipMOjlG/m+x
         GmCLyHqdahcbV4Y9mCX4QNN2Dn28pXag41h8zezfMeRZ379z5qyVdWYYY3TPnZA5Wa54
         Zg3omRYbhARqHBp7wqA/cPd/SqNM0hwpqhaR9az6AKwPnJgtIqwMFnQOrvtPFSmJqgWO
         4hNg==
X-Gm-Message-State: ALoCoQlXTzMkl4d8oKuDruc+FgCELHsggYkSXc4csMAdCO+cwpQj+VMWJuhNLy78TE9+Ergfyd2p
X-Received: by 10.50.153.49 with SMTP id vd17mr8576133igb.40.1398901775386;
        Wed, 30 Apr 2014 16:49:35 -0700 (PDT)
Received: from google.com ([172.16.51.193])
        by mx.google.com with ESMTPSA id p7sm10582283igg.15.2014.04.30.16.49.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 16:49:34 -0700 (PDT)
Date:   Wed, 30 Apr 2014 17:49:33 -0600
From:   Bjorn Helgaas <bhelgaas@google.com>
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/MSI: Phase out pci_enable_msi_block()
Message-ID: <20140430234933.GB31315@google.com>
References: <cover.1397458024.git.agordeev@redhat.com>
 <0b08613dc17cd608c1babc1f42b8919f60e1093f.1397458024.git.agordeev@redhat.com>
 <20140414120921.GA32132@dhcp-26-207.brq.redhat.com>
 <20140414132834.GA9164@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140414132834.GA9164@dhcp-26-207.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

On Mon, Apr 14, 2014 at 03:28:35PM +0200, Alexander Gordeev wrote:
> There are no users of pci_enable_msi_block() function have
> left. Obsolete it in favor of pci_enable_msi_range() and
> pci_enable_msi_exact() functions.

I mistakenly assumed this would have to wait because I thought there were
other pci_enable_msi_block() users that wouldn't be removed until the v3.16
merge window.  But I think I was wrong: I put your GenWQE patch in my tree,
and I think that was the last use, so I can just add this patch on top.

But I need a little help understanding the changelog:

> Up until now, when enabling MSI mode for a device a single
> successful call to arch_msi_check_device() was followed by
> a single call to arch_setup_msi_irqs() function.

I understand this part; the following two paths call
arch_msi_check_device() once and then arch_setup_msi_irqs() once:

  pci_enable_msi_block
    pci_msi_check_device
      arch_msi_check_device
    msi_capability_init
      arch_setup_msi_irqs

  pci_enable_msix
    pci_msi_check_device
      arch_msi_check_device
    msix_capability_init
      arch_setup_msi_irqs

> Yet, if arch_msi_check_device() returned success we should be
> able to call arch_setup_msi_irqs() multiple times - while it
> returns a number of MSI vectors that could have been allocated
> (a third state).

I don't know what you mean by "a third state."

Previously we only called arch_msi_check_device() once.  After your patch,
pci_enable_msi_range() can call it several times.  The only non-trivial
implementation of arch_msi_check_device() is in powerpc, and all the
ppc_md.msi_check_device() possibilities look safe to call multiple times.

After your patch, the pci_enable_msi_range() path can also call
arch_setup_msi_irqs() several times.  I don't see a problem with that --
even if the first call succeeds and allocates something, then a subsequent
call fails, I assume the allocations will be cleaned up when
msi_capability_init() calls free_msi_irqs().

> This update makes use of the assumption described above. It
> could have broke things had the architectures done any pre-
> allocations or switch to some state in a call to function
> arch_msi_check_device(). But because arch_msi_check_device()
> is expected stateless and MSI resources are allocated in a
> follow-up call to arch_setup_msi_irqs() we should be fine.

I guess you mean that your patch assumes arch_msi_check_device() is
stateless.  That looks like a safe assumption to me.

arch_setup_msi_irqs() is clearly not stateless, but I assume
free_msi_irqs() is enough to clean up any state if we fail.

Bjorn

> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: x86@kernel.org
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/msi.c   |   79 +++++++++++++++++++++-----------------------------
>  include/linux/pci.h |    5 +--
>  2 files changed, 34 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 955ab79..fc669ab 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -883,50 +883,6 @@ int pci_msi_vec_count(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_msi_vec_count);
>  
> -/**
> - * pci_enable_msi_block - configure device's MSI capability structure
> - * @dev: device to configure
> - * @nvec: number of interrupts to configure
> - *
> - * Allocate IRQs for a device with the MSI capability.
> - * This function returns a negative errno if an error occurs.  If it
> - * is unable to allocate the number of interrupts requested, it returns
> - * the number of interrupts it might be able to allocate.  If it successfully
> - * allocates at least the number of interrupts requested, it returns 0 and
> - * updates the @dev's irq member to the lowest new interrupt number; the
> - * other interrupt numbers allocated to this device are consecutive.
> - */
> -int pci_enable_msi_block(struct pci_dev *dev, int nvec)
> -{
> -	int status, maxvec;
> -
> -	if (dev->current_state != PCI_D0)
> -		return -EINVAL;
> -
> -	maxvec = pci_msi_vec_count(dev);
> -	if (maxvec < 0)
> -		return maxvec;
> -	if (nvec > maxvec)
> -		return maxvec;
> -
> -	status = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSI);
> -	if (status)
> -		return status;
> -
> -	WARN_ON(!!dev->msi_enabled);
> -
> -	/* Check whether driver already requested MSI-X irqs */
> -	if (dev->msix_enabled) {
> -		dev_info(&dev->dev, "can't enable MSI "
> -			 "(MSI-X already enabled)\n");
> -		return -EINVAL;
> -	}
> -
> -	status = msi_capability_init(dev, nvec);
> -	return status;
> -}
> -EXPORT_SYMBOL(pci_enable_msi_block);
> -
>  void pci_msi_shutdown(struct pci_dev *dev)
>  {
>  	struct msi_desc *desc;
> @@ -1132,14 +1088,45 @@ void pci_msi_init_pci_dev(struct pci_dev *dev)
>   **/
>  int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
>  {
> -	int nvec = maxvec;
> +	int nvec;
>  	int rc;
>  
> +	if (dev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	WARN_ON(!!dev->msi_enabled);
> +
> +	/* Check whether driver already requested MSI-X irqs */
> +	if (dev->msix_enabled) {
> +		dev_info(&dev->dev,
> +			 "can't enable MSI (MSI-X already enabled)\n");
> +		return -EINVAL;
> +	}
> +
>  	if (maxvec < minvec)
>  		return -ERANGE;
>  
> +	nvec = pci_msi_vec_count(dev);
> +	if (nvec < 0)
> +		return nvec;
> +	else if (nvec < minvec)
> +		return -EINVAL;
> +	else if (nvec > maxvec)
> +		nvec = maxvec;
> +
> +	do {
> +		rc = pci_msi_check_device(dev, nvec, PCI_CAP_ID_MSI);
> +		if (rc < 0) {
> +			return rc;
> +		} else if (rc > 0) {
> +			if (rc < minvec)
> +				return -ENOSPC;
> +			nvec = rc;
> +		}
> +	} while (rc);
> +
>  	do {
> -		rc = pci_enable_msi_block(dev, nvec);
> +		rc = msi_capability_init(dev, nvec);
>  		if (rc < 0) {
>  			return rc;
>  		} else if (rc > 0) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aab57b4..499755e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1158,7 +1158,6 @@ struct msix_entry {
>  
>  #ifdef CONFIG_PCI_MSI
>  int pci_msi_vec_count(struct pci_dev *dev);
> -int pci_enable_msi_block(struct pci_dev *dev, int nvec);
>  void pci_msi_shutdown(struct pci_dev *dev);
>  void pci_disable_msi(struct pci_dev *dev);
>  int pci_msix_vec_count(struct pci_dev *dev);
> @@ -1188,8 +1187,6 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
>  }
>  #else
>  static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
> -static inline int pci_enable_msi_block(struct pci_dev *dev, int nvec)
> -{ return -ENOSYS; }
>  static inline void pci_msi_shutdown(struct pci_dev *dev) { }
>  static inline void pci_disable_msi(struct pci_dev *dev) { }
>  static inline int pci_msix_vec_count(struct pci_dev *dev) { return -ENOSYS; }
> @@ -1244,7 +1241,7 @@ static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
>  static inline void pcie_ecrc_get_policy(char *str) { }
>  #endif
>  
> -#define pci_enable_msi(pdev)	pci_enable_msi_block(pdev, 1)
> +#define pci_enable_msi(pdev)	pci_enable_msi_exact(pdev, 1)
>  
>  #ifdef CONFIG_HT_IRQ
>  /* The functions a driver should call */
> -- 
> 1.7.7.6
> 
> -- 
> Regards,
> Alexander Gordeev
> agordeev@redhat.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
