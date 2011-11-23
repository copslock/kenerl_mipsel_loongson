Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 12:35:28 +0100 (CET)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:42155 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903547Ab1KWLfW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2011 12:35:22 +0100
Received: by vcbfo13 with SMTP id fo13so1429708vcb.36
        for <multiple recipients>; Wed, 23 Nov 2011 03:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=wUO01CPxm5M1jLmWHo2DajInMFYuIFFnSzzuARGE13w=;
        b=IfqQX8gPt1FlwiiQGQB1z/7kupmttbFxBQ9xdHpZxeg4pMl7jCyqo3FG5q47BMKXje
         mjPYZO3lYpbUpINrgR30o1VVia//PgI0t0dwX76QafvKj68ZGlcQO1NZSvlsZUUuz4JK
         cM3wP4/s+e8hO7fAxmgbFNqJWGNVtu7oWsfJs=
MIME-Version: 1.0
Received: by 10.182.145.38 with SMTP id sr6mr7592495obb.65.1322048115799; Wed,
 23 Nov 2011 03:35:15 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Wed, 23 Nov 2011 03:35:15 -0800 (PST)
In-Reply-To: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
References: <1322003670-8797-1-git-send-email-juhosg@openwrt.org>
Date:   Wed, 23 Nov 2011 12:35:15 +0100
Message-ID: <CAEWqx5-HNNy-9BhYi=nnp3Q=vGQnq1hfH50env5W73ux2UiZXw@mail.gmail.com>
Subject: Re: [PATCH 00/12] MIPS: ath79: AR724X PCI fixes and AR71XX PCI support
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19817

I don't know on which board you tested the patches,
but the pci read/write function are now broken.

-My patchset has the ability to use different irqs (see pci_data).
-I never hit the pci controller bug, any steps to replicate?

On Wed, Nov 23, 2011 at 12:14 AM, Gabor Juhos <juhosg@openwrt.org> wrote:
> This patch set fixes some errors in the AR724X specific
> PCI code, and adds support for the PCI Host controller
> of the AR71XX SoCs.
>
> This set depends on v4 of the
> 'MIPS: ath79: cleanup AR724X PCI support code' patches.
>
> Gabor Juhos (12):
>  MIPS: ath79: remove superfluous alignment checks from pci-ar724x.c
>  MIPS: ath79: fix broken ar724x_pci_{read,write} functions
>  MIPS: ath79: add a workaround for a PCI controller bug in AR724X SoCs
>  MIPS: ath79: fix a wrong IRQ number
>  MIPS: ath79: add PCI IRQ handling code for AR724X SoCs
>  MIPS: ath79: get rid of some ifdefs in mach-ubnt-xm.c
>  MIPS: ath79: allow to use board specific pci_plat_dev_init functions
>  MIPS: ath79: add support for the PCI host controller of the AR71XX SoCs
>  MIPS: ath79: allow to use SoC specific PCI IRQ maps
>  MIPS: ath79: remove ar724x_pci_add_data function
>  MIPS: ath79: register PCI controller on the PB44 board
>  MIPS: ath79: update copyright headers of PCI related files
>
>  arch/mips/ath79/Kconfig                |    1 +
>  arch/mips/ath79/mach-pb44.c            |    2 +
>  arch/mips/ath79/mach-ubnt-xm.c         |   42 ++++---
>  arch/mips/ath79/pci.c                  |   97 ++++++++++++---
>  arch/mips/ath79/pci.h                  |   19 ++-
>  arch/mips/include/asm/mach-ath79/irq.h |    6 +-
>  arch/mips/include/asm/mach-ath79/pci.h |   14 ++-
>  arch/mips/pci/Makefile                 |    1 +
>  arch/mips/pci/pci-ar724x.c             |  215 +++++++++++++++++++++++++++-----
>  9 files changed, 318 insertions(+), 79 deletions(-)
>
> --
> 1.7.2.1
>
>
