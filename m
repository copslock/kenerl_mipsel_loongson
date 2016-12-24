Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Dec 2016 18:19:55 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:37059 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991986AbcLXRTppa520 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 24 Dec 2016 18:19:45 +0100
Received: from [192.168.178.21] (host-091-097-250-123.ewe-ip-backbone.de [91.97.250.123])
        by mail.hauke-m.de (Postfix) with ESMTPSA id E57E010047A;
        Sat, 24 Dec 2016 18:19:44 +0100 (CET)
Subject: Re: [PATCH] mtd: nand: fix implicit module.h usage in xway_nand.c
To:     kbuild test robot <lkp@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
References: <201612220745.BJjbs3bC%fengguang.wu@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <92266a2a-8a64-7c71-842e-26b12ddcf7a0@hauke-m.de>
Date:   Sat, 24 Dec 2016 18:19:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <201612220745.BJjbs3bC%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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



On 12/22/2016 12:27 AM, kbuild test robot wrote:
> Hi Paul,
> 
> [auto build test ERROR on mtd/master]
> [also build test ERROR on v4.9 next-20161221]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Paul-Gortmaker/mtd-nand-fix-implicit-module-h-usage-in-xway_nand-c/20161221-115714
> base:   git://git.infradead.org/linux-mtd.git master
> config: mips-xway_defconfig (attached as .config)
> compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/mips/built-in.o: In function `vpe_run':
>>> (.text+0x148f0): undefined reference to `physical_memsize'
>    arch/mips/built-in.o: In function `vpe_run':
>    (.text+0x148f4): undefined reference to `physical_memsize'
Let me look into this, it is probably caused by activating a "bad"
config option and not related to GPIO at all.

Hauke
