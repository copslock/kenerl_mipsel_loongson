Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Dec 2015 00:38:11 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:8691 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007910AbbLGXiJRn8Bl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Dec 2015 00:38:09 +0100
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 07 Dec 2015 15:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,397,1444719600"; 
   d="gz'50?scan'50,208,50";a="614169043"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2015 15:37:57 -0800
Received: from kbuild by bee with local (Exim 4.83)
        (envelope-from <fengguang.wu@intel.com>)
        id 1a65Lw-000QWX-DI; Tue, 08 Dec 2015 07:37:56 +0800
Date:   Tue, 8 Dec 2015 07:36:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
Cc:     kbuild-all@01.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-mtd@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-mips@linux-mips.org,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Ralf Baechle <ralf@linux-mips.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-kernel@vger.kernel.org, Josh Wu <josh.wu@atmel.com>,
        Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        punnaiah choudary kalluri <punnaia@xilinx.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Stefan Agner <stefan@agner.ch>, Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 12/23] mtd: use mtd_eccpos() and mtd_oobfree() where
 appropriate
Message-ID: <201512080741.Ff54iWvd%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <1449527178-5930-13-git-send-email-boris.brezillon@free-electrons.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50406
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


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Boris,

[auto build test WARNING on next-20151207]
[cannot apply to staging/staging-testing v4.4-rc4 v4.4-rc3 v4.4-rc2 v4.4-rc4]

url:    https://github.com/0day-ci/linux/commits/Boris-Brezillon/mtd-rework-ECC-layout-definition/20151208-063127
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

>> drivers/mtd/nand/nand_base.c:1607: warning: No description found for parameter 'mtd'
>> drivers/mtd/nand/nand_base.c:1607: warning: Excess function parameter 'chip' description in 'nand_transfer_oob'
>> drivers/mtd/nand/nand_base.c:1607: warning: No description found for parameter 'mtd'
>> drivers/mtd/nand/nand_base.c:1607: warning: Excess function parameter 'chip' description in 'nand_transfer_oob'

vim +/mtd +1607 drivers/mtd/nand/nand_base.c

7e4178f9 Vitaly Wool     2006-06-07  1591  	i = mtd->oobsize - (oob - chip->oob_poi);
f5bbdacc Thomas Gleixner 2006-05-25  1592  	if (i)
f5bbdacc Thomas Gleixner 2006-05-25  1593  		chip->read_buf(mtd, oob, i);
f5bbdacc Thomas Gleixner 2006-05-25  1594  
3f91e94f Mike Dunn       2012-04-25  1595  	return max_bitflips;
^1da177e Linus Torvalds  2005-04-16  1596  }
^1da177e Linus Torvalds  2005-04-16  1597  
f5bbdacc Thomas Gleixner 2006-05-25  1598  /**
7854d3f7 Brian Norris    2011-06-23  1599   * nand_transfer_oob - [INTERN] Transfer oob to client buffer
8593fbc6 Thomas Gleixner 2006-05-29  1600   * @chip: nand chip structure
844d3b42 Randy Dunlap    2006-06-28  1601   * @oob: oob destination address
8593fbc6 Thomas Gleixner 2006-05-29  1602   * @ops: oob ops structure
7014568b Vitaly Wool     2006-11-03  1603   * @len: size of oob to transfer
8593fbc6 Thomas Gleixner 2006-05-29  1604   */
64456fac Boris Brezillon 2015-12-07  1605  static uint8_t *nand_transfer_oob(struct mtd_info *mtd, uint8_t *oob,
7014568b Vitaly Wool     2006-11-03  1606  				  struct mtd_oob_ops *ops, size_t len)
8593fbc6 Thomas Gleixner 2006-05-29 @1607  {
64456fac Boris Brezillon 2015-12-07  1608  	struct nand_chip *chip = mtd->priv;
64456fac Boris Brezillon 2015-12-07  1609  
8593fbc6 Thomas Gleixner 2006-05-29  1610  	switch (ops->mode) {
8593fbc6 Thomas Gleixner 2006-05-29  1611  
0612b9dd Brian Norris    2011-08-30  1612  	case MTD_OPS_PLACE_OOB:
0612b9dd Brian Norris    2011-08-30  1613  	case MTD_OPS_RAW:
8593fbc6 Thomas Gleixner 2006-05-29  1614  		memcpy(oob, chip->oob_poi + ops->ooboffs, len);
8593fbc6 Thomas Gleixner 2006-05-29  1615  		return oob + len;

:::::: The code at line 1607 was first introduced by commit
:::::: 8593fbc68b0df1168995de76d1af38eb62fd6b62 [MTD] Rework the out of band handling completely

:::::: TO: Thomas Gleixner <tglx@cruncher.tec.linutronix.de>
:::::: CC: Thomas Gleixner <tglx@cruncher.tec.linutronix.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--82I3+IH0IqGh5yIs
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Lmgh+A8qRN9XQVcAAA==

--82I3+IH0IqGh5yIs--
