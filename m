Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 13:03:34 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:52098 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903640Ab2EHLDZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 13:03:25 +0200
Message-ID: <4FA8FD24.6060908@openwrt.org>
Date:   Tue, 08 May 2012 13:01:56 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     dedekind1@gmail.com
CC:     MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: xway_nand does not build
References: <1336474838.23308.28.camel@sauron.fi.intel.com>
In-Reply-To: <1336474838.23308.28.camel@sauron.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 33190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 08/05/12 13:00, Artem Bityutskiy wrote:
> Hi John,
>
> I get the following build error when building xway_nand.c:
>
> dedekind@blue:~/git/l2-mtd$ make ARCH=mips CROSS_COMPILE=mips-linux-
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
>   UPD     include/generated/utsrelease.h
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   CC      kernel/sys.o
>   LD      kernel/built-in.o
>   LD      drivers/mtd/nand/nand.o
>   CC      drivers/mtd/nand/xway_nand.o
> drivers/mtd/nand/xway_nand.c: In function 'xway_select_chip':
> drivers/mtd/nand/xway_nand.c:78:3: error: implicit declaration of function 'ltq_ebu_w32_mask' [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors
> make[3]: *** [drivers/mtd/nand/xway_nand.o] Error 1
> make[2]: *** [drivers/mtd/nand] Error 2
> make[1]: *** [drivers/mtd] Error 2
> make: *** [drivers] Error 2
>
> and I cannot figure out how to fix this. This build failure makes
> me really unhappy and shame on me I did not notice it before, of
> course. Would you have a fix?

Hi,

I should have spotted this myself infact. I split these patches out of a
huge series and did infact check that it builds outside the series.
looks like i missed a define. Would it be possible, that patch 4 of my
series flows via Ralfs MIPS tree ? That way we dont need to split out a
single "#define ltq_ebu_w32_mask" out of the bigger MIPS series ?

Sorry about this,
John



> I am attaching the defconfig which I used.
>
