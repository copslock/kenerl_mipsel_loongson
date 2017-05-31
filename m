Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 11:15:59 +0200 (CEST)
Received: from mail.free-electrons.com ([62.4.15.54]:40453 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdEaJPsLNJ5e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 11:15:48 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id BAE4A20EA0; Wed, 31 May 2017 11:15:41 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 6F69E207F0;
        Wed, 31 May 2017 11:15:41 +0200 (CEST)
Date:   Wed, 31 May 2017 11:15:41 +0200
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] bcm47xx: fix build regression
Message-ID: <20170531111541.0ce9a99d@bbrezillon>
In-Reply-To: <20170530112027.3983554-1-arnd@arndb.de>
References: <20170530112027.3983554-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

On Tue, 30 May 2017 13:20:12 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> An unknown change in the kernel headers caused a build regression
> in an MTD partition driver:
> 
> In file included from drivers/mtd/bcm47xxpart.c:12:0:
> include/linux/bcm47xx_nvram.h: In function 'bcm47xx_nvram_init_from_mem':
> include/linux/bcm47xx_nvram.h:27:10: error: 'ENOTSUPP' undeclared (first use in this function)
> 
> Clearly we want to include linux/errno.h here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  include/linux/bcm47xx_nvram.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/bcm47xx_nvram.h b/include/linux/bcm47xx_nvram.h
> index 2793652fbf66..a414a2b53e41 100644
> --- a/include/linux/bcm47xx_nvram.h
> +++ b/include/linux/bcm47xx_nvram.h
> @@ -8,6 +8,7 @@
>  #ifndef __BCM47XX_NVRAM_H
>  #define __BCM47XX_NVRAM_H
>  
> +#include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/vmalloc.h>
