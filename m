Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Oct 2015 07:02:55 +0200 (CEST)
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37736 "EHLO
        mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008435AbbJWFCrm-g2k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Oct 2015 07:02:47 +0200
Received: by igbhv6 with SMTP id hv6so8959971igb.0;
        Thu, 22 Oct 2015 22:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7AfQ20KBdYy5kiQ7sMcM6Th+5dN1kws3VqUOFDLYhVo=;
        b=TIiqyrCGQaM/cLWvS7iIlxpw3zB0M/5XD918n3fbBP9JM+YEvMF/huItsW3shEC9LS
         FbwNWz58hGcxevoidY3XMmtxbANiCw0hnIWHjqL8foIvMagP93ZRllOMm7BLJhgzFVwy
         3sntTvMPTIGnii4yyLnH5fDXOCzNKX++WwG5AoEEYgLbADuDxz8rqSprv6T9TULON4Ql
         UxNWKcDCMyiRIMYUaMwb+udGokW2K12yKxZGDQ3lQu/G/V5+YrzY0MwEG6kl2uaLkxUw
         0LKKEx3MlOvnkQPs2BLgONIrieLO3hHKyvJGzogbuNVqLLVWI3XpPLQd0hr335fNS2n/
         JOcw==
X-Received: by 10.50.3.3 with SMTP id 3mr2274128igy.34.1445576562130; Thu, 22
 Oct 2015 22:02:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.165 with HTTP; Thu, 22 Oct 2015 22:02:02 -0700 (PDT)
In-Reply-To: <1445564663-66824-6-git-send-email-jaedon.shin@gmail.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com> <1445564663-66824-6-git-send-email-jaedon.shin@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Thu, 22 Oct 2015 22:02:02 -0700
Message-ID: <CAGVrzcb3gbtBS8TvsJjQbRxQ=shVXgKAaTNV3p3spgEbWRgRQg@mail.gmail.com>
Subject: Re: [PATCH 05/10] phy: phy_brcmstb_sata: remove unused definitions
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>
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
X-archive-position: 49658
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
> Remove unused definitions.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/phy/phy-brcmstb-sata.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/phy/phy-brcmstb-sata.c b/drivers/phy/phy-brcmstb-sata.c
> index 8a2cb16a1937..0be55dafe9ea 100644
> --- a/drivers/phy/phy-brcmstb-sata.c
> +++ b/drivers/phy/phy-brcmstb-sata.c
> @@ -26,8 +26,6 @@
>
>  #define SATA_MDIO_BANK_OFFSET                          0x23c
>  #define SATA_MDIO_REG_OFFSET(ofs)                      ((ofs) * 4)
> -#define SATA_MDIO_REG_SPACE_SIZE                       0x1000
> -#define SATA_MDIO_REG_LENGTH                           0x1f00
>
>  #define MAX_PORTS                                      2
>
> --
> 2.6.2
>



-- 
Florian
