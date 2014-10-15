Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Oct 2014 01:29:17 +0200 (CEST)
Received: from mail-qg0-f49.google.com ([209.85.192.49]:54028 "EHLO
        mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011560AbaJOX3OoAVBH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Oct 2014 01:29:14 +0200
Received: by mail-qg0-f49.google.com with SMTP id e89so1716525qgf.8
        for <linux-mips@linux-mips.org>; Wed, 15 Oct 2014 16:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=n3VhfssnO0vbsTJOD+A2frJeXlAiFHTP8Es/yV7X4kw=;
        b=MHZ9I0M758Z6WQ3QOJZIiZ/KOGemRsRzevf4Sj+p0OvAJUU8B8kDzgfdW1v7B2h+L+
         0q2H0iYDAx/Y05hdmSE4gyb7yy1V7vk9Z0MCKmUGrt3JJJ0/LaYtixX2Qf+qwGZY1VME
         W1qk7OPCny/KGtvw/nAbjkIAEIBLHCs63eu2Nl+0BHeCfmGaULRoNDOEyNV7QL7sy88a
         vX8FQGYbs4+WYNc+MQM9BWYzYL0IPMGDEBIb8agBzuIy8tWnoyMLpAnEe2X/1MuSc790
         8hOQEZDkkPPLIMBkT14++ShRo7RMzTZcthY7u4Or13kkHJs9BI+XPj8shUntyGum2ZnQ
         TeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=n3VhfssnO0vbsTJOD+A2frJeXlAiFHTP8Es/yV7X4kw=;
        b=cSmxA/O9RkQlplHcvKdBZiaBBqqo5CjA5WP3Nseohby/TfD3WzZuXdRyDT9kD01UqM
         hTOg1Chc6xSQY0mN8tZ5G1xwtj8fP/3eM6oLvV/UtOQxmyuFbPorFMLrKYB0A6qZkatd
         TwRGKTx6EsFml543RmPC0lIBDgFGOvEMw6NSZwsYUahUZXjPH7idDlRG4jszBF1NK7X2
         DCjA/EJfUUSlX1UCFdaz6IXhpW7NfDN8Q0uV7xjYJ61Ev4z/xaH5ai10P/bsj8QljDkb
         QNFPxcue1SHJ5UkrEIT02vGR0JOLnm/EIy1lQAZ/yZRAiVYGyLfOkqizWBJtaU/TkNg5
         TG+A==
X-Gm-Message-State: ALoCoQnmzpho+P8gLcfiV073AbUmdePKBPv3IJLgtiAnYiLkSFhHxNqPV2XH9/8vilIRAxqS++CE
X-Received: by 10.229.80.138 with SMTP id t10mr2956231qck.11.1413415749037;
 Wed, 15 Oct 2014 16:29:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.161.79 with HTTP; Wed, 15 Oct 2014 16:28:48 -0700 (PDT)
In-Reply-To: <20141015170617.4063.2807.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20141015165957.4063.66741.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20141015170617.4063.2807.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 15 Oct 2014 17:28:48 -0600
Message-ID: <CAErSpo45JNAFM7gYM39hsAw=O+Pe2FLJYpj3WV0p2rDe-_t+xg@mail.gmail.com>
Subject: Re: [PATCH v1 05/10] MIPS: MT: Move "weak" from vpe_run() declaration
 to definition
To:     Jason Wessel <jason.wessel@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Eric Paris <eparis@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43294
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

[+cc linux-mips]

On Wed, Oct 15, 2014 at 11:06 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> When the "weak" attribute is on a declaration in a header file, every
> definition where the header is included becomes weak, and the linker
> chooses one definition based on link order (see 10629d711ed7 ("PCI: Remove
> __weak annotation from pcibios_get_phb_of_node decl")).
>
> Move the "weak" attribute from the declaration to the default definition so
> we always prefer a non-weak definition over the weak one, independent of
> link order.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: linux-mips@linux-mips.org
> ---
>  arch/mips/include/asm/vpe.h |    2 +-
>  arch/mips/kernel/vpe-mt.c   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/include/asm/vpe.h b/arch/mips/include/asm/vpe.h
> index 7849f3978fea..80e70dbd1f64 100644
> --- a/arch/mips/include/asm/vpe.h
> +++ b/arch/mips/include/asm/vpe.h
> @@ -122,7 +122,7 @@ void release_vpe(struct vpe *v);
>  void *alloc_progmem(unsigned long len);
>  void release_progmem(void *ptr);
>
> -int __weak vpe_run(struct vpe *v);
> +int vpe_run(struct vpe *v);
>  void cleanup_tc(struct tc *tc);
>
>  int __init vpe_module_init(void);
> diff --git a/arch/mips/kernel/vpe-mt.c b/arch/mips/kernel/vpe-mt.c
> index 2e003b11a098..0e5899a2cd96 100644
> --- a/arch/mips/kernel/vpe-mt.c
> +++ b/arch/mips/kernel/vpe-mt.c
> @@ -23,7 +23,7 @@ static int major;
>  static int hw_tcs, hw_vpes;
>
>  /* We are prepared so configure and start the VPE... */
> -int vpe_run(struct vpe *v)
> +int __weak vpe_run(struct vpe *v)
>  {
>         unsigned long flags, val, dmt_flag;
>         struct vpe_notifications *notifier;
>
