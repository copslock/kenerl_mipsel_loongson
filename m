Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Sep 2013 23:08:35 +0200 (CEST)
Received: from mail-qe0-f43.google.com ([209.85.128.43]:52318 "EHLO
        mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818702Ab3IVVIck0gAe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Sep 2013 23:08:32 +0200
Received: by mail-qe0-f43.google.com with SMTP id gh4so1584005qeb.2
        for <multiple recipients>; Sun, 22 Sep 2013 14:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oqRDyhZ9tnCpk5ku/zHYR1xT8YIzsBs5LFCl9R6LUro=;
        b=lZEBksdC3+VXgPyx2R3BR9Fu5QYXMUeCDinGAN4db9X84vX1EkEyz8aM3Zwa3utoZq
         Wz6fp0zg2FHSf3ooiUrhUrEx9njqrONulehFZAxxMH6B8Iws2qR78rj2/Am4CQTH25gN
         B+WbXCLJQvmT7RUIBKPXCyRUKempIzoCH5GBUXXsuAE1lUpFZS6FLnsn0II857qCOwVX
         e+cw9ngcCXNfIsufL/4vkewtDIvZabgojuI8HDcMUzQtTfVxMd6vDzWI7AL77fKKvt6u
         Ldtvk1scm+qZ00qurVBPFCf3jL0aMewTVAupqBZnZJ7ajtUKhpX2wDt+yYegaoei/gka
         N4Bw==
MIME-Version: 1.0
X-Received: by 10.224.137.68 with SMTP id v4mr19909633qat.31.1379884106774;
 Sun, 22 Sep 2013 14:08:26 -0700 (PDT)
Received: by 10.49.54.194 with HTTP; Sun, 22 Sep 2013 14:08:26 -0700 (PDT)
In-Reply-To: <1379510692-32435-8-git-send-email-treding@nvidia.com>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
        <1379510692-32435-8-git-send-email-treding@nvidia.com>
Date:   Sun, 22 Sep 2013 16:08:26 -0500
Message-ID: <CAL_JsqJ+4P26hRrJcrbBmwfNPDAS+1GhXj12B+UvqmZZGjqT0g@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] of/irq: Propagate errors in of_irq_to_resource_table()
From:   Rob Herring <robherring2@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <rob.herring@calxeda.com>,
        Grant Likely <grant.likely@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Russell King <linux@arm.linux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37915
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
> Now that all helpers return precise error codes, this function can
> propagate these errors to the caller properly.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - return 0 on success or a negative error code on failure
> - convert callers to new calling convention

[snip]

> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index e4f38c0..6d7f824 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -397,18 +397,20 @@ int of_irq_count(struct device_node *dev)
>   * @res: array of resources to fill in
>   * @nr_irqs: the number of IRQs (and upper bound for num of @res elements)

You are effectively changing this to require an exact match rather
than an upper bound. That seems to be okay since that is what all the
callers want, but the documentation should be updated.

>   *
> - * Returns the size of the filled in table (up to @nr_irqs).
> + * Returns 0 on success or a negative error code on failure.
>   */
>  int of_irq_to_resource_table(struct device_node *dev, struct resource *res,
>                 int nr_irqs)
>  {
> -       int i;
> +       int i, ret;
>
> -       for (i = 0; i < nr_irqs; i++, res++)
> -               if (!of_irq_to_resource(dev, i, res))

The error handling here needs to be updated in the previous patch.

> -                       break;
> +       for (i = 0; i < nr_irqs; i++, res++) {
> +               ret = of_irq_to_resource(dev, i, res);
> +               if (ret < 0)
> +                       return ret;
> +       }
>
> -       return i;
> +       return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_irq_to_resource_table);
>
