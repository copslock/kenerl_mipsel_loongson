Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2016 13:52:47 +0200 (CEST)
Received: from a.ns.miles-group.at ([95.130.255.143]:7605 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026283AbcDHLwpVCN1B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 8 Apr 2016 13:52:45 +0200
Received: (qmail 21839 invoked by uid 89); 8 Apr 2016 11:52:45 -0000
Received: by simscan 1.3.1 ppid: 21830, pid: 21837, t: 0.0454s
         scanners: attach: 1.3.1
Received: from unknown (HELO ?192.168.0.10?) (richard@nod.at@213.47.235.169)
  by radon.swed.at with ESMTPA; 8 Apr 2016 11:52:45 -0000
Subject: Re: [PATCH V2 4/7] mtd: nand: add Loongson1 NAND driver
To:     Keguang Zhang <keguang.zhang@gmail.com>, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <1460115779-13141-1-git-send-email-keguang.zhang@gmail.com>
 <1460115779-13141-4-git-send-email-keguang.zhang@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
From:   Richard Weinberger <richard@nod.at>
Message-ID: <57079B87.9030209@nod.at>
Date:   Fri, 8 Apr 2016 13:52:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
MIME-Version: 1.0
In-Reply-To: <1460115779-13141-4-git-send-email-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

Am 08.04.2016 um 13:42 schrieb Keguang Zhang:
> +	chip->options		= NAND_NO_SUBPAGE_WRITE;
> +	chip->ecc.mode		= NAND_ECC_SOFT;

Is the lack of HW ECC and subpage write a hardware limitation?

Thanks,
//richard
