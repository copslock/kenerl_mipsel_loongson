Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 23:44:06 +0100 (CET)
Received: from mail.kmu-office.ch ([178.209.48.109]:41169 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011995AbbLGWoEH0-Kg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 23:44:04 +0100
Received: from webmail.kmu-office.ch (unknown [178.209.48.103])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id BBC9B5C0255;
        Mon,  7 Dec 2015 23:43:51 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Dec 2015 14:42:25 -0800
From:   Stefan Agner <stefan@agner.ch>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Josh Wu <josh.wu@atmel.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        punnaiah choudary kalluri <punnaia@xilinx.com>
Subject: Re: [PATCH 09/23] mtd: nand: vf610: remove useless mtd->ecclayout
 assignment
In-Reply-To: <1449527178-5930-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
 <1449527178-5930-10-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <97ccabe846d9410df0a28a2805b94a2e@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.1.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim; t=1449528231; bh=HQcTdLjD8UTWMS4yxWLKlalwhsTKBhWWahQgWuy8uu0=; h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID; b=JjwLambClnASFq4bb6amR7rlQqHJ09CIJ3JFW5Qsij7YiYock3yHrKBhR742ZG1EaTuuuRXHpuX7/jxIcETblnZDE2JdZLKH+oO4DChInplttmCJrehha16h8YD18s0/NgeVJ5FLfsS7QGik5nXSra3BozjxoZhlzC1MEtNKDRo=
Return-Path: <stefan@agner.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stefan@agner.ch
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

On 2015-12-07 14:26, Boris Brezillon wrote:
> The NAND core layer is already taking care of ecclayout propagation. Remove
> this useless assignment.

Thx! I see, nand_scan_tail takes care of that...

Acked-by: Stefan Agner <stefan@agner.ch>

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mtd/nand/vf610_nfc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> index 1c86c6b..0413e24 100644
> --- a/drivers/mtd/nand/vf610_nfc.c
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -794,8 +794,6 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  			goto error;
>  		}
>  
> -		/* propagate ecc.layout to mtd_info */
> -		mtd->ecclayout = chip->ecc.layout;
>  		chip->ecc.read_page = vf610_nfc_read_page;
>  		chip->ecc.write_page = vf610_nfc_write_page;
