Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Mar 2016 20:06:12 +0100 (CET)
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35036 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006970AbcCJTGLHkc3R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Mar 2016 20:06:11 +0100
Received: by mail-pf0-f175.google.com with SMTP id n5so37302613pfn.2;
        Thu, 10 Mar 2016 11:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vFwQEyzhFipYXMfoDilAWnUUBIp9IiLG27EKKCCYzp0=;
        b=w/ilUXAHZUgxcmWsbNq6vb7TiuXLl0NNppQv60lrJZMTJD2V0+/NTEI0xzOjzcm+z3
         U+xUp/QUzhIe6l/uQuPqce8mSLbP9Eoptb+G6qTgRsu6uTDzrCG9d0CY8m6oQgFmRsR0
         tvS4GkUlPPJH+vKki6CkpBfa50n2BF/rjp9fkUa9/5EjT8QAHAe9zoV7MT3ScgfHkDIw
         BiShp8CeaIIFGX4ovxYpVfT2NrZ/xcvn/31ZsCmwGFl1uYwjZsC8vFLZoHH4P3gGspTr
         i9yZklPGgCFpbCkeUGuKZJX9hqslg3R4qwebmxAfVGyTEt7DB2ONWjNyWAf3ne02sKoP
         XD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vFwQEyzhFipYXMfoDilAWnUUBIp9IiLG27EKKCCYzp0=;
        b=cln2OOTPq4IKKY0gv4nqxHSqlHmcmKaVI8VVxBD9oFtch3Zy9//8PfJcRAQnJRJD1T
         L4T7E07+X22N5ijxSSsFwm9yi/ilIXb5xJkElTOSLgXcp/R9J1K2xUKejLDfqSLMYJxT
         u2KcmVlU+C0itsWa/fjNTY64vetRLUYR4pfL1j98y8fkrJ3I9vvLBGDFYmBqqf7YbaQm
         VZ+0LbFyQVaWsf+CNbE1U1n0LO+ANpk2aBW8/RdZ+ky1giyXmywnRQgJLPTOpBYhAx6y
         +tegxz2KdSe1VntkSfWmxUP4NrPGqU+K+OClxnXKR/2djmB+5UkVkzvcQ3yMoOt/e/cR
         t7ug==
X-Gm-Message-State: AD7BkJLoyM//68v0sG+tO1ND1T6OI2WvSvEwQxDJmKHNHNJIDDHXcHVpsovC3LUQUCLkcQ==
X-Received: by 10.98.7.5 with SMTP id b5mr7248405pfd.47.1457636765008;
        Thu, 10 Mar 2016 11:06:05 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:c13f:a75f:75f5:3e66])
        by smtp.gmail.com with ESMTPSA id ah10sm7285970pad.23.2016.03.10.11.06.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Mar 2016 11:06:04 -0800 (PST)
Date:   Thu, 10 Mar 2016 11:06:01 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Wenyou Yang <wenyou.yang@atmel.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-api@vger.kernel.org,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v4 00/52] mtd: rework ECC layout definition
Message-ID: <20160310190601.GC2545@google.com>
References: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457344062-11633-1-git-send-email-boris.brezillon@free-electrons.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52570
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

On Mon, Mar 07, 2016 at 10:46:50AM +0100, Boris Brezillon wrote:
> Hello,
> 
> This patchset aims at getting rid of the nand_ecclayout limitations.
> struct nand_ecclayout is defining fixed eccpos and oobfree arrays which
> can only be increased by modifying the MTD_MAX_ECCPOS_ENTRIES_LARGE and
> MTD_MAX_OOBFREE_ENTRIES_LARGE macros.
> This approach forces us to modify the macro values each time we add a
> new NAND chip with a bigger OOB area, and increasing these arrays also
> penalize all platforms, even those who only support small NAND devices
> (with small OOB area).
> 
> The idea to overcome this limitation, is to define the ECC/OOB layout
> by the mean of two functions: ->ecc() and ->free(), which will
> basically return the same information has those stored in the
> nand_ecclayout struct.
> 
> Another advantage of this solution is that ECC layouts are usually
> following a repetitive pattern (i.e. leave X bytes free and put Y bytes
> of ECC per ECC chunk), which allows one to implement the ->ecc()
> and ->free() functions with a simple logic that can be applied
> to any size of OOB.
> 
> Patches 1 to 4 are just cleanups or trivial fixes that can be taken
> independently.
> 
> Also note that the last two commits are removing the nand_ecclayout
> definition, thus preventing any new driver to use this structure.
> Of course, this step can be delayed if some of the previous patches
> are not accepted.
> 
> All those changes are available here [1].
> 
> Best Regards,
> 
> Boris
> 
> [1]https://github.com/bbrezillon/linux-0day/tree/nand/ecclayout

FYI, I've pushed patches 1-4 to l2-mtd.git. I'll take another look at
them this week I hope (or your new fellow, Richard, can!), then you can
queue them up for the next cycle.

Brian
