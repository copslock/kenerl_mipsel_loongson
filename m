Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 01:39:03 +0100 (CET)
Received: from mailout3.w1.samsung.com ([210.118.77.13]:43388 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007910AbbLHAjAswoJC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Dec 2015 01:39:00 +0100
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout3.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NZ0005UPKGTRW80@mailout3.w1.samsung.com>; Tue,
 08 Dec 2015 00:38:53 +0000 (GMT)
X-AuditID: cbfec7f5-f79b16d000005389-b1-5666269c26b5
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 6F.98.21385.C9626665; Tue,
 8 Dec 2015 00:38:52 +0000 (GMT)
Received: from [10.113.63.52] by eusync1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NZ0006R4KGMH600@eusync1.samsung.com>; Tue,
 08 Dec 2015 00:38:52 +0000 (GMT)
Subject: Re: [PATCH 04/23] mtd: nand: s3c2410: kill the ->ecc_layout field
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449527178-5930-5-git-send-email-boris.brezillon@free-electrons.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Stefan Agner <stefan@agner.ch>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>
From:   Krzysztof Kozlowski <k.kozlowski@samsung.com>
Message-id: <56662696.1000705@samsung.com>
Date:   Tue, 08 Dec 2015 09:38:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-version: 1.0
In-reply-to: <1449527178-5930-5-git-send-email-boris.brezillon@free-electrons.com>
Content-type: text/plain; charset=windows-1252
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xy7pz1NLCDJ68M7Q48GIhi8WRC2uZ
        LZr+vmKx2HPmF7vFxJWTmS1On1rAatG8eD2bxYV15ha7Gn+zWrx+YWjR//g1s8XZpjfsFpse
        X2O1uLxrDpvFhKmT2C12Ny1jt5hxfh+Txe9Hx9gttm7ay2yx8OlPVotLe1QsZr0Rtti8rp3d
        4ueh80wOEh6Lv99j9ljwayuLx4ZHq1k97u07zOLxZNNFRo/+dZ9ZPXbOusvusWfiSTaPzSu0
        PDat6mTzOLpyLZPH/rlr2D02L6n36NuyitHj8yY5j72ff7MECEZx2aSk5mSWpRbp2yVwZWx/
        dpy14CFrxa7nag2Me1m6GDk5JARMJNb9/8AIYYtJXLi3nq2LkYtDSGApo8S0htNQzlNGifPb
        W8GqhAW8JGa+/sECkhARWAdUdec9E0TVbEaJ76+3g2WYBW6ySjw40Aq2hE3AWGLz8iVsIDav
        gJbEqqOLwWwWAVWJtpn3gGo4OEQFIiQW7ciEKBGU+DH5Hlgrp0CIxKafx5hASpgF9CTuX9QC
        CTMLyEtsXvOWeQKjwCwkHbMQqmYhqVrAyLyKUTS1NLmgOCk910ivODG3uDQvXS85P3cTIyTi
        v+5gXHrM6hCjAAejEg+vwsnUMCHWxLLiytxDjBIczEoivHyqaWFCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeWfueh8iJJCeWJKanZpakFoEk2Xi4JRqYPT0PcW/1XVvEvenmKOLLygJP+vzlLJv
        s2j4q/M/lMFImd+y84WHzPEtaTVfPDZJeMbqR5ZalwnJ9zeX3j1WM3+i0AelzSXx3xRefDq7
        VY1JYt0Bj41Fjxd+XFnG+cE/6W3Am80fsoruR+kmheZuXMDF2+kWHpDXvexKyKElzzacfsjw
        uvbKZSWW4oxEQy3mouJEAHEEP3/0AgAA
Return-Path: <k.kozlowski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: k.kozlowski@samsung.com
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

On 08.12.2015 07:25, Boris Brezillon wrote:
> The s3c2410 is allowing board data to overload the default ECC layout
> defined inside the driver, but this feature is not used by board
> specific definitions.
> Kill this field so that we can easily move to a model where ecclayout
> are dynamically allocated by the NAND controller driver.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  arch/arm/plat-samsung/devs.c                   | 9 ---------
>  drivers/mtd/nand/s3c2410.c                     | 3 ---
>  include/linux/platform_data/mtd-nand-s3c2410.h | 1 -
>  3 files changed, 13 deletions(-)

Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
