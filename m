Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Nov 2016 12:34:49 +0100 (CET)
Received: from mga03.intel.com ([134.134.136.65]:45514 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991346AbcKBLemsE8jm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Nov 2016 12:34:42 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 02 Nov 2016 04:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,583,1473145200"; 
   d="gz'50?scan'50,208,50";a="781308773"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2016 04:34:37 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1c1tpH-0001PU-8B; Wed, 02 Nov 2016 19:35:27 +0800
Date:   Wed, 2 Nov 2016 19:33:47 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     kbuild-all@01.org, linux-mtd@lists.infradead.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>
Subject: Re: [PATCH V4] mtd: nand: add Loongson1 NAND driver
Message-ID: <201611021941.3qc11614%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <1478051526-7216-1-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lkp@intel.com
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


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kelvin,

[auto build test ERROR on mtd/master]
[also build test ERROR on v4.9-rc3 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Keguang-Zhang/mtd-nand-add-Loongson1-NAND-driver/20161102-095605
base:   git://git.infradead.org/linux-mtd.git master
config: mips-loongson1c_defconfig (attached as .config)
compiler: mipsel-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   drivers/mtd/nand/loongson1_nand.c: In function 'setup_dma':
>> drivers/mtd/nand/loongson1_nand.c:134:18: error: 'struct plat_ls1x_nand' has no member named 'dma_filter'
     if (!nand->pdata->dma_filter) {
                     ^~
   In file included from drivers/mtd/nand/loongson1_nand.c:15:0:
   drivers/mtd/nand/loongson1_nand.c:148:57: error: 'struct plat_ls1x_nand' has no member named 'dma_filter'
     nandc->dma_chan = dma_request_channel(mask, nand->pdata->dma_filter,
                                                            ^
   include/linux/dmaengine.h:1398:72: note: in definition of macro 'dma_request_channel'
    #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
                                                                           ^

vim +134 drivers/mtd/nand/loongson1_nand.c

   128		struct ls1x_nand_controller *nandc =
   129		    to_ls1x_nand_controller(chip->controller);
   130		struct dma_slave_config cfg;
   131		dma_cap_mask_t mask;
   132		int ret;
   133	
 > 134		if (!nand->pdata->dma_filter) {
   135			dev_err(mtd->dev.parent, "no DMA filter\n");
   136			return -ENOENT;
   137		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--tKW2IUtsqtDRztdT--
