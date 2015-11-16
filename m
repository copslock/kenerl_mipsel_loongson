Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 14:23:36 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54764 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27011673AbbKPNXei5J-F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 Nov 2015 14:23:34 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id tAGDNTTp014909;
        Mon, 16 Nov 2015 14:23:29 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id tAGDNSZa014908;
        Mon, 16 Nov 2015 14:23:28 +0100
Date:   Mon, 16 Nov 2015 14:23:28 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] mtd: jz4740_nand: fix build on jz4740 after removing
 gpio.h
Message-ID: <20151116132328.GB9425@linux-mips.org>
References: <1447284976-96693-1-git-send-email-computersforpeace@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1447284976-96693-1-git-send-email-computersforpeace@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Nov 11, 2015 at 03:36:16PM -0800, Brian Norris wrote:

> Fallout from commit 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
> 
> We see errors like this:
> 
> drivers/mtd/nand/jz4740_nand.c: In function 'jz_nand_detect_bank':
> drivers/mtd/nand/jz4740_nand.c:340:9: error: 'JZ_GPIO_MEM_CS0' undeclared (first use in this function)
> drivers/mtd/nand/jz4740_nand.c:340:9: note: each undeclared identifier is reported only once for each function it appears in
> drivers/mtd/nand/jz4740_nand.c:359:2: error: implicit declaration of function 'jz_gpio_set_function' [-Werror=implicit-function-declaration]
> drivers/mtd/nand/jz4740_nand.c:359:29: error: 'JZ_GPIO_FUNC_MEM_CS0' undeclared (first use in this function)
> drivers/mtd/nand/jz4740_nand.c:399:29: error: 'JZ_GPIO_FUNC_NONE' undeclared (first use in this function)
> drivers/mtd/nand/jz4740_nand.c: In function 'jz_nand_probe':
> drivers/mtd/nand/jz4740_nand.c:528:13: error: 'JZ_GPIO_MEM_CS0' undeclared (first use in this function)
> drivers/mtd/nand/jz4740_nand.c: In function 'jz_nand_remove':
> drivers/mtd/nand/jz4740_nand.c:555:14: error: 'JZ_GPIO_MEM_CS0' undeclared (first use in this function)
> 
> Patched similarly to:
> 
> https://patchwork.linux-mips.org/patch/11089/
> 
> Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Looks, good, shall I funnel this upstream?

  Ralf
