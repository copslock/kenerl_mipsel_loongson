Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2015 16:15:03 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:46133 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007679AbbE2OPCKXgAn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 29 May 2015 16:15:02 +0200
Received: from [192.168.0.100] (ip-109-43-81-189.web.vodafone.de [109.43.81.189])
        by hauke-m.de (Postfix) with ESMTPSA id 8496C20200;
        Fri, 29 May 2015 16:14:53 +0200 (CEST)
Message-ID: <5568743F.4000505@hauke-m.de>
Date:   Fri, 29 May 2015 16:14:23 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:     Arend van Spriel <arend@broadcom.com>
Subject: Re: [PATCH] MAINTAINERS: Add Broadcom BCM47xx entry
References: <1432877966-5820-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1432877966-5820-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47727
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 05/29/2015 07:39 AM, Rafał Miłecki wrote:
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 474bcb6..643dc00 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2161,6 +2161,14 @@ F:	arch/mips/bcm3384/*
>  F:	arch/mips/include/asm/mach-bcm3384/*
>  F:	arch/mips/kernel/*bmips*
>  
> +BROADCOM BCM47XX MIPS ARCHITECTURE
> +M:	Hauke Mehrtens <hauke@hauke-m.de>
> +M:	Rafał Miłecki <zajec5@gmail.com>
> +L:	linux-mips@linux-mips.org
> +S:	Maintained
> +F:	arch/mips/bcm47xx/*
> +F:	arch/mips/include/asm/mach-bcm47xx/*
> +
>  BROADCOM BCM5301X ARM ARCHITECTURE
>  M:	Hauke Mehrtens <hauke@hauke-m.de>
>  L:	linux-arm-kernel@lists.infradead.org
> 
