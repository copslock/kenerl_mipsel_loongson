Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 01:20:41 +0200 (CEST)
Received: from mail-pz0-f47.google.com ([209.85.210.47]:58665 "EHLO
        mail-pz0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491763Ab1GUXUe convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jul 2011 01:20:34 +0200
Received: by pzk36 with SMTP id 36so2652333pzk.34
        for <multiple recipients>; Thu, 21 Jul 2011 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=iDUBJstFb96wiDWZ5wvxD0CUlwTR7vUK7rYmBP2pSxg=;
        b=f2Ci96Owywgoy6cnMbrl2DmKS3Xmlp06ox4YPY5oR2JHgZfp8uWQGi84YeAQHMlv1F
         CJDFk++pPmiCNGcOkFoSoBPBWIuL8iYYQQboAM6hY6Xnrlu7C4NBnl9lQQtsY90qzDKE
         mx936J9ihjBPPkpGH3Eqd24kRfkZgqZqEctrY=
MIME-Version: 1.0
Received: by 10.68.12.225 with SMTP id b1mr1199176pbc.116.1311290428183; Thu,
 21 Jul 2011 16:20:28 -0700 (PDT)
Received: by 10.68.49.98 with HTTP; Thu, 21 Jul 2011 16:20:28 -0700 (PDT)
In-Reply-To: <1310835342-18877-5-git-send-email-hauke@hauke-m.de>
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
        <1310835342-18877-5-git-send-email-hauke@hauke-m.de>
Date:   Fri, 22 Jul 2011 01:20:28 +0200
Message-ID: <CACna6rzf8=FpWn-=agGi4GESiw0-XG1QDS81fGTkV2J6dgtiOw@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] bcma: add SOC bus
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, jonas.gorski@gmail.com, mb@bu3sch.de,
        george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15615

2011/7/16 Hauke Mehrtens <hauke@hauke-m.de>:
> This patch adds support for using bcma on a Broadcom SoC as the system
> bus. An SoC like the bcm4716 could register this bus and use it to
> searches for the bcma cores and register the devices on this bus.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Rafał Miłecki <zajec5@gmail.com>

Cleaning enum bcma_hosttype would be nice (see below), but we cal
always easily do this later.


> diff --git a/include/linux/bcma/bcma.h b/include/linux/bcma/bcma.h
> index 6bd7b7f..73fda1c 100644
> --- a/include/linux/bcma/bcma.h
> +++ b/include/linux/bcma/bcma.h
> @@ -16,6 +16,7 @@ enum bcma_hosttype {
>        BCMA_HOSTTYPE_NONE,
>        BCMA_HOSTTYPE_PCI,
>        BCMA_HOSTTYPE_SDIO,
> +       BCMA_HOSTTYPE_SOC,
>  };

I wanted to use BCMA_HOSTTYPE_NONE for SoCs (embedded systems), when I
decided to add it. As we decided SOC is better name than NONE, you
could drop it (NONE one).

-- 
Rafał
