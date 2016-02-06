Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Feb 2016 22:55:22 +0100 (CET)
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:49532 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011853AbcBFVzUMmiEv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Feb 2016 22:55:20 +0100
Received: from belgarion ([109.222.219.121])
        by mwinf5d61 with ME
        id F9v51s00K2dl3Th039v57N; Sat, 06 Feb 2016 22:55:14 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 06 Feb 2016 22:55:14 +0100
X-ME-IP: 109.222.219.121
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
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
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH v2 18/51] mtd: docg3: use mtd_set_ecclayout() where appropriate
References: <1454580434-32078-1-git-send-email-boris.brezillon@free-electrons.com>
        <1454580434-32078-19-git-send-email-boris.brezillon@free-electrons.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Sat, 06 Feb 2016 22:55:05 +0100
In-Reply-To: <1454580434-32078-19-git-send-email-boris.brezillon@free-electrons.com>
        (Boris Brezillon's message of "Thu, 4 Feb 2016 11:06:41 +0100")
Message-ID: <8737t54i86.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <robert.jarzmik@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robert.jarzmik@free.fr
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

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> Use the mtd_set_ecclayout() helper instead of directly assigning the
> mtd->ecclayout field.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
