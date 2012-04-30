Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Apr 2012 19:54:50 +0200 (CEST)
Received: from mail-pz0-f48.google.com ([209.85.210.48]:63698 "EHLO
        mail-pz0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903715Ab2D3Ryq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Apr 2012 19:54:46 +0200
Received: by dakb39 with SMTP id b39so3666227dak.35
        for <multiple recipients>; Mon, 30 Apr 2012 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mSVGZSvrA5pkUI9h7K6YlIGO9Se6pf82/sBq+WA5J7A=;
        b=OqzqIDVdNqb/l75uEYIi6uza5wlaMFTa+9dFt0xauWSfurgaKKIFbRfczgEn4IFn07
         hoTh8xFoTwISrOerYbtAZ7R4gZRvzQuTtap5OclRFXabLxsB+BKqx2p77MNI3lMEXOxt
         qPbjFHNIxb5dPd2JyIDpR1TXmJAG1xVrka4Uiv68hO+FxxgNXtpP1NSDbWqzH6m+a6fv
         jik7xN/mbK1qPTpq6iP0Vz6oV46eBqfDu4J6+/ahv2/g12fVSw0YPo/5AQ36Pa9b6gg+
         LIRAZDdNVl4/mHvMq8Ej0eulBdewiwVmQIXt2psbymVm4/yUanCaiFGGzGchFl3L68z1
         Z71w==
Received: by 10.68.132.201 with SMTP id ow9mr10752389pbb.160.1335808479533;
        Mon, 30 Apr 2012 10:54:39 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id i1sm16648489pbv.49.2012.04.30.10.54.37
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Apr 2012 10:54:38 -0700 (PDT)
Message-ID: <4F9ED1DC.3050007@gmail.com>
Date:   Mon, 30 Apr 2012 10:54:36 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Grant Likely <grant.likely@secretlab.ca>,
        linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] OF: PCI: const usage needed by MIPS
References: <1335808019-24502-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1335808019-24502-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/30/2012 10:46 AM, John Crispin wrote:
> On MIPS we want to call of_irq_map_pci from inside
>
> arch/mips/include/asm/pci.h:extern int pcibios_map_irq(
> 				const struct pci_dev *dev, u8 slot, u8 pin);
>
> For this to work we need to change several functions to const usage.

I think there is a mismatch on this throughout the kernel.

Properly fixing it requires touching many more places than these. 
Although I haven't tried it, I wouldn't be surprised if doing this 
caused warnings to appear in non-MIPS code.

Ralf had a patch at one point that tried to make this consistent 
tree-wide, but it is not yet applied.

David Daney

>
> Signed-off-by: John Crispin<blogic@openwrt.org>
> Cc: linux-pci@vger.kernel.org
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: linux-mips@linux-mips.org
> ---
> I am not sure which tree this should go via. Grant, can you take it ?
>
>   drivers/of/of_pci_irq.c |    2 +-
>   drivers/pci/pci.c       |    2 +-
>   include/linux/of_pci.h  |    2 +-
>   include/linux/pci.h     |    5 +++--
>   4 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/of/of_pci_irq.c b/drivers/of/of_pci_irq.c
> index 9312516..6770538 100644
> --- a/drivers/of/of_pci_irq.c
> +++ b/drivers/of/of_pci_irq.c
> @@ -15,7 +15,7 @@
>    * PCI tree until an device-node is found, at which point it will finish
>    * resolving using the OF tree walking.
>    */
> -int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
> +int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq)
>   {
>   	struct device_node *dn, *ppnode;
>   	struct pci_dev *ppdev;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d20f133..4c79586 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2363,7 +2363,7 @@ void pci_enable_acs(struct pci_dev *dev)
>    * number is always 0 (see the Implementation Note in section 2.2.8.1 of
>    * the PCI Express Base Specification, Revision 2.1)
>    */
> -u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin)
> +u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin)
>   {
>   	int slot;
>
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index f93e217..bb115de 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -5,7 +5,7 @@
>
>   struct pci_dev;
>   struct of_irq;
> -int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
> +int of_irq_map_pci(const struct pci_dev *pdev, struct of_irq *out_irq);
>
>   struct device_node;
>   struct device_node *of_pci_find_child_device(struct device_node *parent,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e444f5b..3bbc77e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -680,7 +680,7 @@ int __must_check pci_bus_add_device(struct pci_dev *dev);
>   void pci_read_bridge_bases(struct pci_bus *child);
>   struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>   					  struct resource *res);
> -u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin);
> +u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
>   int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
>   u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
>   extern struct pci_dev *pci_dev_get(struct pci_dev *dev);
> @@ -1685,7 +1685,8 @@ extern void pci_release_bus_of_node(struct pci_bus *bus);
>   /* Arch may override this (weak) */
>   extern struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus);
>
> -static inline struct device_node *pci_device_to_OF_node(struct pci_dev *pdev)
> +static inline struct device_node *
> +pci_device_to_OF_node(const struct pci_dev *pdev)
>   {
>   	return pdev ? pdev->dev.of_node : NULL;
>   }
