Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 03:25:57 +0200 (CEST)
Received: from mga05.intel.com ([192.55.52.43]:23316 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992298AbcIBBZu2TKIx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Sep 2016 03:25:50 +0200
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP; 01 Sep 2016 18:25:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,269,1470726000"; 
   d="gz'50?scan'50,208,50";a="3899955"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga005.jf.intel.com with ESMTP; 01 Sep 2016 18:25:38 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1bfdF9-000AHI-EI; Fri, 02 Sep 2016 09:26:07 +0800
Date:   Fri, 2 Sep 2016 09:25:23 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     kbuild-all@01.org, monstr@monstr.eu, ralf@linux-mips.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        soren.brinkmann@xilinx.com, Zubair.Kakakhel@imgtec.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        michal.simek@xilinx.com, netdev@vger.kernel.org
Subject: Re: [Patch v4 02/12] irqchip: axi-intc: Clean up irqdomain argument
 and read/write
Message-ID: <201609020919.0CP1sS90%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <1472748665-47774-3-git-send-email-Zubair.Kakakhel@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54964
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


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Zubair,

[auto build test WARNING on tip/irq/core]
[also build test WARNING on v4.8-rc4 next-20160825]
[cannot apply to linus/master linux/master]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Zubair-Lutfullah-Kakakhel/microblaze-MIPS-xilfpga-intc-and-peripheral/20160902-084739
config: microblaze-mmu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=microblaze 

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-axi-intc.c: In function 'xilinx_intc_of_init':
>> drivers/irqchip/irq-axi-intc.c:169:3: warning: format '%s' expects a matching 'char *' argument [-Wformat=]
      pr_err("%s: Multiple instances of axi_intc aren't supported\n");
      ^

vim +169 drivers/irqchip/irq-axi-intc.c

   153		.xlate = irq_domain_xlate_onetwocell,
   154		.map = xintc_map,
   155	};
   156	
   157	static int __init xilinx_intc_of_init(struct device_node *intc,
   158						     struct device_node *parent)
   159	{
   160		u32 nr_irq;
   161		int ret;
   162		struct xintc_irq_chip *irqc;
   163	
   164		irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
   165		if (!irqc)
   166			return -ENOMEM;
   167	
   168		if (xintc_irqc) {
 > 169			pr_err("%s: Multiple instances of axi_intc aren't supported\n");
   170			ret = -EINVAL;
   171			goto err_alloc;
   172		} else {
   173			xintc_irqc = irqc;
   174		}
   175	
   176		irqc->base = of_iomap(intc, 0);
   177		BUG_ON(!irqc->base);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--ReaqsoxgOBHFXBhH
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--ReaqsoxgOBHFXBhH--
