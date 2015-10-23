Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 06:53:08 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37076 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008247AbbJWExHIXOrk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 06:53:07 +0200
Received: by igbhv6 with SMTP id hv6so8864969igb.0;
        Thu, 22 Oct 2015 21:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZHhe5zC02kAgw+QsP4UrDIveF13HsJNMdfX6jfpXPD0=;
        b=nJakQ5C5v4gKGxeR9VMZ0rPRDcsIA8XZhqe4UvsKhysoIZvw4qwB1owJvLvhbzEm1U
         kY0zShZ9ZEMuE6jfaz28lkpkBU3fnGjqvk5mBdnfOx65iW0jb636iWM7UlV5Xo3Sjjq2
         MeTNxU3Q1+3eH9u6jjqh/fdv0EWGfdsYB2tfrd1DLFk5fcEU1NV9NfA3gCBJ/BwpN+Ta
         NnAhrugElPwVvgpyUkm+/otE92+573Pnq5tTGHX6c6DoYy/mdhN3dlgZyqWaRgTu8pud
         ZkVLzMcuEkRsXDVenvM3wPuRYByIwwuRsHCcS5FzvC8jh8T2wsIR8gyH5fVp9hpF8AQZ
         O3/Q==
X-Received: by 10.50.3.3 with SMTP id 3mr2244809igy.34.1445575981295; Thu, 22
 Oct 2015 21:53:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.165 with HTTP; Thu, 22 Oct 2015 21:52:21 -0700 (PDT)
In-Reply-To: <1445564663-66824-2-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-2-git-send-email-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 22 Oct 2015 21:52:21 -0700
Message-ID: <CAGVrzcbzGfuzt_6CV23f+RF4gFjnc_MYO4E-huQ7PTTLyXFihA@mail.gmail.com>
Subject: Re: [PATCH 01/10] ata: ahci_brcmstb: make the driver buildable on BMIPS_GENERIC
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2015-10-22 18:44 GMT-07:00 Jaedon Shin <jaedon.shin@gmail.com>:
> The BCM7xxx ARM and MIPS platforms share a similar hardware block for AHCI
> SATA3.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/ata/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 15e40ee62a94..8f535a88a0c7 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -100,7 +100,7 @@ config SATA_AHCI_PLATFORM
>
>  config AHCI_BRCMSTB
>         tristate "Broadcom STB AHCI SATA support"
> -       depends on ARCH_BRCMSTB
> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC
>         help
>           This option enables support for the AHCI SATA3 controller found on
>           STB SoC's.
> --
> 2.6.2
>



-- 
Florian
