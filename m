Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 13:12:40 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:42798 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903640Ab2EHLMg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 13:12:36 +0200
Message-ID: <4FA8FF4C.5050400@openwrt.org>
Date:   Tue, 08 May 2012 13:11:08 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: xway_nand does not build
References: <1336474838.23308.28.camel@sauron.fi.intel.com>         <4FA8FD24.6060908@openwrt.org> <1336475618.23308.30.camel@sauron.fi.intel.com>
In-Reply-To: <1336475618.23308.30.camel@sauron.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 33192
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


> OK, so I should drop this patch from l2-mtd.git:
>
> commit e4445062be41c27b2a0b4f2e1e770d24b68686f4
> Author: John Crispin <blogic@openwrt.org>
> Date:   Mon Apr 30 19:30:48 2012 +0200
>
>     mtd: mips: lantiq: add xway nand support
>     
>     Add NAND support on Lantiq XWAY SoC.
>     
>     The driver uses plat_nand. As the platform_device is loaded from DT, we need
>     to lookup the node and attach our xway specific "struct platform_nand_data"
>     to it.
>     
>     Signed-off-by: John Crispin <blogic@openwrt.org>
>     Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Right?
Hi,

That would be appreciated. i will get aligned with Ralf to make sure
this patch flow via his tree

Thanks,
John
