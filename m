Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 19:49:28 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35511 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012822AbbKPStZvjJh8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2015 19:49:25 +0100
Received: by pacej9 with SMTP id ej9so76409154pac.2;
        Mon, 16 Nov 2015 10:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ebUK6vEIRFasBDV0NKfZneM8cRuA6kWRjsMXQB0ERLI=;
        b=fagWZl3OaNHd6gtF1Kpz6gtNEg3SNrbVaxtu8bXYe26gHdluhNiex2ag9f7DXYWDj0
         ygt1H0O2eg33eLiM0V0axd0NIf4TAwlfbuIyTBjgsdRCJ39jrclhm28m3JFV1qE8M9Q0
         iCRuJB4p4OespaS4LU+grSQ/Ar7nXtwd/Y4TwhnVUK3g7lM9VI0YWnRtEuQ7/p6+3ZA6
         gvfkvNPESOTDzD2OCnRv8x3K7BQs+oMJglyZLQ+20lSvdPFdnYCTN0hCrmVxMwWxElmb
         QRhBNVVFvK0phELp+O/+mGhDK5f7fR9coFZ3FWmiVOwRnokJJ/PJPtCD7aFXsOuZ4DeV
         T8+w==
X-Received: by 10.66.136.40 with SMTP id px8mr32981961pab.75.1447699759694;
        Mon, 16 Nov 2015 10:49:19 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:64ae:171:73e1:bc49])
        by smtp.gmail.com with ESMTPSA id qv5sm37970653pbc.71.2015.11.16.10.49.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Nov 2015 10:49:19 -0800 (PST)
Date:   Mon, 16 Nov 2015 10:49:17 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] mtd: jz4740_nand: fix build on jz4740 after removing
 gpio.h
Message-ID: <20151116184917.GM8456@google.com>
References: <1447284976-96693-1-git-send-email-computersforpeace@gmail.com>
 <20151116132328.GB9425@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151116132328.GB9425@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Mon, Nov 16, 2015 at 02:23:28PM +0100, Ralf Baechle wrote:
> On Wed, Nov 11, 2015 at 03:36:16PM -0800, Brian Norris wrote:
> 
> > Fallout from commit 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
> > 
> > We see errors like this:
> > 
> > drivers/mtd/nand/jz4740_nand.c: In function 'jz_nand_detect_bank':
> > drivers/mtd/nand/jz4740_nand.c:340:9: error: 'JZ_GPIO_MEM_CS0' undeclared (first use in this function)
> > drivers/mtd/nand/jz4740_nand.c:340:9: note: each undeclared identifier is reported only once for each function it appears in
> > drivers/mtd/nand/jz4740_nand.c:359:2: error: implicit declaration of function 'jz_gpio_set_function' [-Werror=implicit-function-declaration]
> > drivers/mtd/nand/jz4740_nand.c:359:29: error: 'JZ_GPIO_FUNC_MEM_CS0' undeclared (first use in this function)
> > drivers/mtd/nand/jz4740_nand.c:399:29: error: 'JZ_GPIO_FUNC_NONE' undeclared (first use in this function)
> > drivers/mtd/nand/jz4740_nand.c: In function 'jz_nand_probe':
> > drivers/mtd/nand/jz4740_nand.c:528:13: error: 'JZ_GPIO_MEM_CS0' undeclared (first use in this function)
> > drivers/mtd/nand/jz4740_nand.c: In function 'jz_nand_remove':
> > drivers/mtd/nand/jz4740_nand.c:555:14: error: 'JZ_GPIO_MEM_CS0' undeclared (first use in this function)
> > 
> > Patched similarly to:
> > 
> > https://patchwork.linux-mips.org/patch/11089/
> > 
> > Fixes: 832f5dacfa0b ("MIPS: Remove all the uses of custom gpio.h")
> > Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> 
> Looks, good, shall I funnel this upstream?

Actually, if you don't mind, I'll take it through MTD. I think I'll have
a few things to push upstream this week anyway, and I'd like to get some
of my MIPS-based build test configs working again in my development
trees.

So...pushed to linux-mtd.git

Regards,
Brian
