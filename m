Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 20:48:49 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:50445 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6820513Ab3ADTso175tw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 20:48:44 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id BFA608F60;
        Fri,  4 Jan 2013 20:48:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id alMnWY4YDExe; Fri,  4 Jan 2013 20:48:37 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:89b9:649b:29b7:7863] (unknown [IPv6:2001:470:1f0b:447:89b9:649b:29b7:7863])
        by hauke-m.de (Postfix) with ESMTPSA id EF3098E1C;
        Fri,  4 Jan 2013 20:48:36 +0100 (CET)
Message-ID: <50E73212.60003@hauke-m.de>
Date:   Fri, 04 Jan 2013 20:48:34 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Arend van Spriel <arend@broadcom.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: bcm47xx: select GPIOLIB for BCMA on bcm47xx platform
References: <1357323005-28008-1-git-send-email-arend@broadcom.com>
In-Reply-To: <1357323005-28008-1-git-send-email-arend@broadcom.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35376
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/04/2013 07:10 PM, Arend van Spriel wrote:
> The Kconfig items BCM47XX_BCMA and BCM47XX_SSB selected
> respectively BCMA_DRIVER_GPIO and SSB_DRIVER_GPIO. These
> options depend on GPIOLIB without explicitly selecting it
> so it results in a warning when GPIOLIB is not set:
> 
> scripts/kconfig/conf --oldconfig Kconfig
> warning: (BCM47XX_BCMA) selects BCMA_DRIVER_GPIO ... unmet direct
> 	dependencies (BCMA_POSSIBLE && BCMA && GPIOLIB)
> warning: (BCM47XX_SSB) selects SSB_DRIVER_GPIO ... unmet direct
> 	dependencies (SSB_POSSIBLE && SSB && GPIOLIB)
> 
> which subsequently results in compile errors.
> 
> Cc: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
> Fixing a Kconfig issue in our nightly Jenkins build.
> 
> Gr. AvS

Thanks for spotting and fixing this.

This should also go into 3.8.
This was a missing piece of a fix by Geert Uytterhoeven for an other bug
in Kconfig of bcma and ssb:
https://lkml.org/lkml/2012/12/16/68
https://lkml.org/lkml/2012/12/16/69

Hauke
