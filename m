Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2018 03:42:24 +0100 (CET)
Received: from conssluserg-01.nifty.com ([210.131.2.80]:22075 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992973AbeKWCmV7RdhH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2018 03:42:21 +0100
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wAN2fumN019593
        for <linux-mips@linux-mips.org>; Fri, 23 Nov 2018 11:41:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wAN2fumN019593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940916;
        bh=R157I6Dkx5Z2mskSmJELm97OIhgSrKrMbLwBuT6BgNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PJhm3VByg1Ah0Bi7mvZ6aiPwxFzUDNfv0jbVmnMBZzEHnuJxJtp/QAYLnvWDXSu2M
         QuP1ZQKL7ToO4PzAeFsIxIz+yFCibIKlF4VnlRnJYfeYVoIVG+S05oouBnn0ONb5rG
         Kfee/avcqdkY3E330NbYuuw5FbkoD2D6upNkIYekasYof8ohbCyFBTO/Yhpnnrsuzn
         lsXgPqoDWpBXpnjs/Qb84UkX7X5MDUplCnFYzkvSS1UohcQD2GEdiE58a0dtSmYiGA
         GxUD7lrTRdVGomPC4dVJBYRczt+OUOR4PGbT25CU1PeSW1QcEwCZmCWuVRYVwOZMZl
         GuTpYQf19Knxg==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id t8so3676276uap.0
        for <linux-mips@linux-mips.org>; Thu, 22 Nov 2018 18:41:56 -0800 (PST)
X-Gm-Message-State: AA+aEWbZ4/AZfP1fiSQo5wfuM6PmhcwMGTCexaHTinYBQe2VN7vljR4S
        raScniRZofGN4efTHrha29S5938BX4oECzyReys=
X-Google-Smtp-Source: AFSGD/U0y52k6OkO8mAFNr3ssfm0dIj5t/ic8hflM6hOWd/Ort5n5jrqwIFsps2z1+GeSvz9QtDEt9YhLpwhox0mNvE=
X-Received: by 2002:a9f:3f41:: with SMTP id i1mr5501205uaj.42.1542940915649;
 Thu, 22 Nov 2018 18:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-6-hch@lst.de>
In-Reply-To: <20181115190538.17016-6-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:41:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASYobpeAMqenZXycNieWErRFkNHz6xQUzEruJ0-nNwfdA@mail.gmail.com>
Message-ID: <CAK7LNASYobpeAMqenZXycNieWErRFkNHz6xQUzEruJ0-nNwfdA@mail.gmail.com>
Subject: Re: [PATCH 5/9] PCI: consolidate the PCI_DOMAINS and
 PCI_DOMAINS_GENERIC config options
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

On Fri, Nov 16, 2018 at 4:07 AM Christoph Hellwig <hch@lst.de> wrote:

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index a8128a1946a2..95812fc4958c 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -21,6 +21,15 @@ menuconfig PCI
>           support for PCI-X and the foundations for PCI Express support.
>           Say 'Y' here unless you know what you are doing.
>
> +config PCI_DOMAINS
> +       depends on PCI
> +       bool
> +
> +config PCI_DOMAINS_GENERIC
> +       depends on PCI
> +       select PCI_DOMAINS
> +       bool
> +
>  source "drivers/pci/pcie/Kconfig"
>
>  config PCI_MSI


I reordered this so it 'bool' comes first.

config PCI_DOMAINS
       bool
       depends on PCI


config PCI_DOMAINS_GENERIC
       bool
       depends on PCI
       select PCI_DOMAINS


Of course, it is just a matter of slight taste.
I just wanted the code to look consistent.




-- 
Best Regards
Masahiro Yamada
