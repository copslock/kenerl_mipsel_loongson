Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Sep 2013 23:14:52 +0200 (CEST)
Received: from mail-qc0-f178.google.com ([209.85.216.178]:33471 "EHLO
        mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818702Ab3IVVOtoSLkl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Sep 2013 23:14:49 +0200
Received: by mail-qc0-f178.google.com with SMTP id r5so1552110qcx.23
        for <multiple recipients>; Sun, 22 Sep 2013 14:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nif/VIQ77pdWAsvIMaG4NhEEbt3wxAA+O/xwS9bPiv0=;
        b=Cnvc05nnzd4OXjOf6PYusww/t7CpZjSHC9bXUSHri5gzkljWGXx35RPvzegOA2CCiv
         9KPN5fFSI/WhSJ5dtPKhy8BILGa7IkTut3y3dv2pBhdX1gWinHvvRBh+jfv3cG2b23GH
         kFag292ORT/s/8sURr6HHk+j2TY3CRtO7tjq7jXD6vmSOHQp4B1C+4nJveUZaAlojY7r
         GVTy7rmWVDMG8Edri9Ryh8git75E/xu72IVw7EWNH5DKtMINXPqMU4FDRflj3uP8Js7o
         jir8UuX8iPDGVA/cAYNQzr3HZmOU0ZGz1sXc2HCYpuspJHCYRppPxbI1zA6Zpg85LfSh
         h6uA==
MIME-Version: 1.0
X-Received: by 10.49.48.67 with SMTP id j3mr25489083qen.11.1379884483784; Sun,
 22 Sep 2013 14:14:43 -0700 (PDT)
Received: by 10.49.54.194 with HTTP; Sun, 22 Sep 2013 14:14:43 -0700 (PDT)
In-Reply-To: <1379510692-32435-5-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
        <1379510692-32435-5-git-send-email-treding@nvidia.com>
Date:   Sun, 22 Sep 2013 16:14:43 -0500
Message-ID: <CAL_JsqLQeAQD460f8Lk9eDE2dCzLusC1mXZ-_uaKVFLfhJNryg@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] irqdomain: Return errors from irq_create_of_mapping()
From:   Rob Herring <robherring2@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <rob.herring@calxeda.com>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robherring2@gmail.com
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

On Wed, Sep 18, 2013 at 8:24 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> Instead of returning 0 for all errors, allow the precise error code to
> be propagated. This will be used in subsequent patches to allow further
> propagation of error codes.
>
> The interrupt number corresponding to the new mapping is returned in an
> output parameter so that the return value is reserved to signal success
> (== 0) or failure (< 0).
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

One comment below, otherwise:

Acked-by: Rob Herring <rob.herring@calxeda.com>

> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 905a24b..ae71b14 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -230,6 +230,7 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>  {
>         struct of_irq oirq;
>         unsigned int virq;
> +       int ret;
>
>         pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
>
> @@ -266,8 +267,10 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>                          oirq.size, oirq.specifier[0], oirq.specifier[1],
>                          of_node_full_name(oirq.controller));
>
> -               virq = irq_create_of_mapping(oirq.controller, oirq.specifier,
> -                                            oirq.size);
> +               ret = irq_create_of_mapping(oirq.controller, oirq.specifier,
> +                                           oirq.size, &virq);
> +               if (ret)
> +                       virq = NO_IRQ;
>         }
>         if(virq == NO_IRQ) {
>                 pr_debug(" Failed to map !\n");

Can you get rid of NO_IRQ usage here instead of adding to it.

Rob
