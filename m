Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 00:35:14 +0200 (CEST)
Received: from mail-pz0-f47.google.com ([209.85.210.47]:65105 "EHLO
        mail-pz0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491159Ab1GUWfI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jul 2011 00:35:08 +0200
Received: by pzk36 with SMTP id 36so2604315pzk.34
        for <multiple recipients>; Thu, 21 Jul 2011 15:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=U+fioFA7j6d9z9dxChpGgwyy5Htf/m81f2IsKdBcQGw=;
        b=FglgcHUnc4FHnyXFgnDNhNNpxVwn0jjaU0+RpjxdpngYyhjX5/h6l/zMNIp+QOWGCS
         ibU1zJtL5U1msVnG8ZS1n83C8h4Quvbxjhwcuq20nE2h1vmP7zTXHDESSgfrPqH4n2ln
         Zs/5brQnTd/0JEuqHt4P7Y9Abdxqhsrw4cGTs=
MIME-Version: 1.0
Received: by 10.68.13.193 with SMTP id j1mr1018277pbc.384.1311287701851; Thu,
 21 Jul 2011 15:35:01 -0700 (PDT)
Received: by 10.68.49.98 with HTTP; Thu, 21 Jul 2011 15:35:01 -0700 (PDT)
In-Reply-To: <1310835342-18877-4-git-send-email-hauke@hauke-m.de>
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
        <1310835342-18877-4-git-send-email-hauke@hauke-m.de>
Date:   Fri, 22 Jul 2011 00:35:01 +0200
Message-ID: <CACna6ryPABAx87b2+-gsTY5a5_qHTo61Otre-Pm+vYH8ad9hNg@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] bcma: add functions to scan cores needed on SoCs
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, jonas.gorski@gmail.com, mb@bu3sch.de,
        george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30659
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15559

2011/7/16 Hauke Mehrtens <hauke@hauke-m.de>:
> @@ -159,5 +159,8 @@ static void bcma_pcicore_serdes_workaround(struct bcma_drv_pci *pc)
>
>  void bcma_core_pci_init(struct bcma_drv_pci *pc)
>  {
> +       if (pc->setup_done)
> +               return;
>        bcma_pcicore_serdes_workaround(pc);
> +       pc->setup_done = true;
>  }

This won't apply to the upstream driver_pci.c. Fix is obvious for me
and you, but could be nice to don't bother John/Ralf.


> +       /* Scan for devices (cores) */
> +       err = bcma_bus_scan_early(bus, &match, core_cc);

Could you update the comment by the way?

-- 
Rafał
