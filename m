Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 13:32:20 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:50287 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab1FFLcS convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 13:32:18 +0200
Received: by qyk32 with SMTP id 32so847126qyk.15
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 04:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q/kdsAXzOZOh74cFYGRyN61XXDqinT4KNI1L9wleoj4=;
        b=MWXGpavn6CvftSCwqvPGFD85dlU4ia8PsKrxEG0A0DIKMYRwHImQhOOhTZOntbP5oK
         DKB9jzKQAsUG/iUA+eQY/3O31IxzgcK8CWTUaVi3e5u8YX1qEOPnsLPDCFuA1WBAQU9b
         t5X5bXERokWqlLQJP68BCZUIfcGdBRfIVwTSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=srbsfgkaJeqxuBvdkaQcHGYG92DilZd2tQjEwwNAUK6uavFrrWLsjQamNH4TzDHfTC
         h6uS8a+YsH9Up1sOXfgOPdfKBDTk1tZgA2xnE3aeeEAY6WnQtilsg2lVhrYw4fEdYzJf
         951oXNe36tFheb+8k/hnJZSB6F/gH91odSr3U=
MIME-Version: 1.0
Received: by 10.229.43.99 with SMTP id v35mr3466671qce.8.1307359932220; Mon,
 06 Jun 2011 04:32:12 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 04:32:11 -0700 (PDT)
In-Reply-To: <1307311658-15853-8-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-8-git-send-email-hauke@hauke-m.de>
Date:   Mon, 6 Jun 2011 13:32:11 +0200
Message-ID: <BANLkTik93+7ujHyv0_Zk2Ma9BPsHvJTttg@mail.gmail.com>
Subject: Re: [RFC][PATCH 07/10] bcma: add pci(e) host mode
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4142

2011/6/6 Hauke Mehrtens <hauke@hauke-m.de>:
> +config BCMA_PCICORE_HOSTMODE
> +       bool "Hostmode support for BCMA PCI core"
> +       depends on BCMA_DRIVER_MIPS
> +       help
> +         PCIcore hostmode operation (external PCI bus).

I think you started to use BCMA_DRIVER_corename. Could you stick to it
(one schema), please? Maybe just
BCMA_DRIVER_PCI_HOSTMODE
?


> +#ifdef CONFIG_BCMA_PCICORE_HOSTMODE
> +       pc->hostmode = bcma_pcicore_is_in_hostmode(pc);
> +       if (pc->hostmode)
> +               bcma_pcicore_init_hostmode(pc);
> +#endif /* CONFIG_BCMA_PCICORE_HOSTMODE */
> +       if (!pc->hostmode)
> +               bcma_pcicore_serdes_workaround(pc);

Does it make sense to init hostmode PCI like clientmode if we just
disable CONFIG_BCMA_PCICORE_HOSTMODE?

I think we should always check if core is host or client mode and use
correct initialization only. We should not init it as clientmode just
because we do not have driver for host mode.


> diff --git a/drivers/bcma/driver_pci_host.c b/drivers/bcma/driver_pci_host.c
> new file mode 100644
> index 0000000..b52c6c9
> --- /dev/null
> +++ b/drivers/bcma/driver_pci_host.c
> @@ -0,0 +1,44 @@
> +/*
> + * Broadcom specific AMBA
> + * PCI Core

Please rename "PCI Core", add something about hostmode.

-- 
Rafał
