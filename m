Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jun 2010 20:23:17 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:48537 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492073Ab0FJSXN convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Jun 2010 20:23:13 +0200
Received: by gyb11 with SMTP id 11so207093gyb.36
        for <multiple recipients>; Thu, 10 Jun 2010 11:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QUpa/odPaB+gapCNKESlkc5q+0zGdTfQVKNMBfmNvLs=;
        b=iT/Qi/Y03S3x2BTCh4GCLCWvwiDiZV7SRLbsrnToPPyfHuaekt9qEefhll56vqtrNN
         IsEyK4bCcZ4HYNdafhFgrWx6bRs4gActaIf53uHHZV0XDxjvE6qdDcFQ3gMcu51u4y8K
         HpSPgPGkJK8JIqfYieUwGoy871aw1sKcl4adQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rq3tsFZ8x3BPM03dV/OcN8JcbUBxPy1/WTUETssqS/OXec+IhF77/QFqY/P1pZApsp
         Si0cACrC1RKsU8iPdr+9IhaLxXjABEUamKo0RsmWX9f/RoxuUqIc0Z/1lA85DWabc4+L
         a72tJ2/QrnDRPPIYarb9ChWgPVTbs+0w3NONg=
MIME-Version: 1.0
Received: by 10.229.214.20 with SMTP id gy20mr569676qcb.149.1276194186706; 
        Thu, 10 Jun 2010 11:23:06 -0700 (PDT)
Received: by 10.220.65.11 with HTTP; Thu, 10 Jun 2010 11:23:06 -0700 (PDT)
In-Reply-To: <73e9e4bd7615488c9567f02f8962825386956365.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
        <73e9e4bd7615488c9567f02f8962825386956365.1275925108.git.siccegge@cs.fau.de>
Date:   Thu, 10 Jun 2010 12:23:06 -0600
Message-ID: <AANLkTillx50SaxZU2cT9YSlS4uRF_ED5-wlG-JwfXfFT@mail.gmail.com>
Subject: Re: [PATCH 5/9] Removing dead CONFIG_BLK_DEV_IDE
From:   Shane McDonald <mcdonald.shane@gmail.com>
To:     Christoph Egger <siccegge@cs.fau.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 27116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7526

On Wed, Jun 9, 2010 at 5:21 AM, Christoph Egger <siccegge@cs.fau.de> wrote:
> CONFIG_BLK_DEV_IDE doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
>
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/mips/mti-malta/malta-setup.c |   25 -------------------------
>  1 files changed, 0 insertions(+), 25 deletions(-)
>
> diff --git a/arch/mips/mti-malta/malta-setup.c b/arch/mips/mti-malta/malta-setup.c
> index b7f37d4..d85143c 100644
> --- a/arch/mips/mti-malta/malta-setup.c
> +++ b/arch/mips/mti-malta/malta-setup.c
> @@ -105,28 +105,6 @@ static void __init fd_activate(void)
>  }
>  #endif
>
> -#ifdef CONFIG_BLK_DEV_IDE
> -static void __init pci_clock_check(void)
> -{
> -       unsigned int __iomem *jmpr_p =
> -               (unsigned int *) ioremap(MALTA_JMPRS_REG, sizeof(unsigned int));
> -       int jmpr = (__raw_readl(jmpr_p) >> 2) & 0x07;
> -       static const int pciclocks[] __initdata = {
> -               33, 20, 25, 30, 12, 16, 37, 10
> -       };
> -       int pciclock = pciclocks[jmpr];
> -       char *argptr = prom_getcmdline();
> -
> -       if (pciclock != 33 && !strstr(argptr, "idebus=")) {
> -               printk(KERN_WARNING "WARNING: PCI clock is %dMHz, "
> -                               "setting idebus\n", pciclock);
> -               argptr += strlen(argptr);
> -               sprintf(argptr, " idebus=%d", pciclock);
> -               if (pciclock < 20 || pciclock > 66)
> -                       printk(KERN_WARNING "WARNING: IDE timing "
> -                                       "calculations will be incorrect\n");
> -       }
> -}
>  #endif
>
>  #if defined(CONFIG_VT) && defined(CONFIG_VGA_CONSOLE)
> @@ -207,9 +185,6 @@ void __init plat_mem_setup(void)
>        if (mips_revision_sconid == MIPS_REVISION_SCON_BONITO)
>                bonito_quirks_setup();
>
> -#ifdef CONFIG_BLK_DEV_IDE
> -       pci_clock_check();
> -#endif
>
>  #ifdef CONFIG_BLK_DEV_FD
>        fd_activate();
> --
> 1.6.3.3

  I wonder if, instead of deleting the code, the constant should be
changed from CONFIG_BLK_DEV_IDE to CONFIG_IDE.  The original
patch that removed CONFIG_BLK_DEV_IDE seemed to make this change:
http://kerneltrap.org/mailarchive/linux-kernel/2008/8/13/2929444

Shane
