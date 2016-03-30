Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Mar 2016 21:19:38 +0200 (CEST)
Received: from www381.your-server.de ([78.46.137.84]:34253 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008467AbcC3TTgi9D9h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Mar 2016 21:19:36 +0200
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1alLdl-0004ed-8A; Wed, 30 Mar 2016 21:18:53 +0200
Received: from [46.244.248.242] (helo=[192.168.178.32])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.84_2)
        (envelope-from <lars@metafoo.de>)
        id 1alLcr-0001Jy-Di; Wed, 30 Mar 2016 21:17:57 +0200
Subject: Re: [PATCH v5 21/50] mtd: nand: jz4740: switch to mtd_ooblayout_ops
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459354505-32551-22-git-send-email-boris.brezillon@free-electrons.com>
Cc:     Daniel Mack <daniel@zonque.org>,
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
        Archit Taneja <architt@codeaurora.org>,
        Han Xu <b45815@freescale.com>,
        Huang Shijie <shijie.huang@arm.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56FC265D.8070500@metafoo.de>
Date:   Wed, 30 Mar 2016 21:17:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.6.0
MIME-Version: 1.0
In-Reply-To: <1459354505-32551-22-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.99/21479/Wed Mar 30 16:47:26 2016)
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 03/30/2016 06:14 PM, Boris Brezillon wrote:
> Implementing the mtd_ooblayout_ops interface is the new way of exposing
> ECC/OOB layout to MTD users.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
