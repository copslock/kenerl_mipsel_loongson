Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2015 23:23:55 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:45813 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009619AbbJYWXxYr-pa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 25 Oct 2015 23:23:53 +0100
Received: from [192.168.178.22] (p5DE965E8.dip0.t-ipconnect.de [93.233.101.232])
        by hauke-m.de (Postfix) with ESMTPSA id EE2DA10002A;
        Sun, 25 Oct 2015 23:23:52 +0100 (CET)
Message-ID: <562D5678.9050804@hauke-m.de>
Date:   Sun, 25 Oct 2015 23:23:52 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: BCM47xx: Support on-SoC bus in SPROM reading
 function
References: <1445807808-23257-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1445807808-23257-1-git-send-email-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49687
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

On 10/25/2015 10:16 PM, Rafał Miłecki wrote:
> To support (extract) SPROM on Broadcom ARM devices we should separate
> SPROM code and make it a separated module. We won't want to export
> bcm47xx_fill_sprom symbol so we should support SoC SPROM in the standard
> fallback function and then modify ssb to use it.
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  arch/mips/bcm47xx/sprom.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/bcm47xx/sprom.c b/arch/mips/bcm47xx/sprom.c
> index 2d5c7a7..e19c1b9 100644
> --- a/arch/mips/bcm47xx/sprom.c
> +++ b/arch/mips/bcm47xx/sprom.c
> @@ -610,14 +610,18 @@ static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
>  {
>  	char prefix[10];
>  
> -	if (bus->bustype == SSB_BUSTYPE_PCI) {
> +	switch (bus->bustype) {
> +	case SSB_BUSTYPE_SSB:
> +		bcm47xx_fill_sprom(out, NULL, false);
> +		return 0;
> +	case SSB_BUSTYPE_PCI:
>  		memset(out, 0, sizeof(struct ssb_sprom));
>  		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
>  			 bus->host_pci->bus->number + 1,
>  			 PCI_SLOT(bus->host_pci->devfn));
>  		bcm47xx_fill_sprom(out, prefix, false);
>  		return 0;
> -	} else {
> +	default:
>  		pr_warn("Unable to fill SPROM for given bustype.\n");
>  		return -EINVAL;
>  	}
> 
