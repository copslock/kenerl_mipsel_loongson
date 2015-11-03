Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2015 13:07:51 +0100 (CET)
Received: from mga11.intel.com ([192.55.52.93]:8899 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012389AbbKCMHtEBxXf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Nov 2015 13:07:49 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP; 03 Nov 2015 04:07:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,238,1444719600"; 
   d="gz'50?scan'50,208,50";a="841970697"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 03 Nov 2015 04:07:38 -0800
Received: from kbuild by bee with local (Exim 4.83)
        (envelope-from <fengguang.wu@intel.com>)
        id 1ZtaN3-000I7c-5D; Tue, 03 Nov 2015 20:07:25 +0800
Date:   Tue, 3 Nov 2015 20:06:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        jiang.liu@linux.intel.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 07/14] genirq: Add a new generic IPI reservation code to
 irq core
Message-ID: <201511032024.sTgW2j0J%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <1446549181-31788-8-git-send-email-qais.yousef@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49818
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


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Qais,

[auto build test ERROR on tip/irq/core -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Qais-Yousef/Implement-generic-IPI-support-mechanism/20151103-192028
config: mips-jz4740 (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   kernel/irq/irqdomain.c: In function 'irq_reserve_ipi':
>> kernel/irq/irqdomain.c:890:9: error: implicit declaration of function '__irq_domain_alloc_irqs' [-Werror=implicit-function-declaration]
     virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
            ^
   kernel/irq/irqdomain.c: In function 'irq_destroy_ipi':
>> kernel/irq/irqdomain.c:950:2: error: implicit declaration of function 'irq_domain_free_irqs' [-Werror=implicit-function-declaration]
     irq_domain_free_irqs(irq, nr_irqs);
     ^
   cc1: some warnings being treated as errors

vim +/__irq_domain_alloc_irqs +890 kernel/irq/irqdomain.c

   884		virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE);
   885		if (virq <= 0) {
   886			pr_warn("Can't reserve IPI, failed to alloc descs\n");
   887			return 0;
   888		}
   889	
 > 890		virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
   891						(void *) dest, true);
   892		if (virq <= 0) {
   893			pr_warn("Can't reserve IPI, failed to alloc irqs\n");
   894			goto free_descs;
   895		}
   896	
   897		for (i = virq; i < virq + nr_irqs; i++) {
   898			data = irq_get_irq_data(i);
   899			data->common->ipi_mask = ipi_mask_alloc(dest->nbits);
   900			if (!data->common->ipi_mask)
   901				goto free_ipi_mask;
   902			ipi_mask_copy(data->common->ipi_mask, dest);
   903		}
   904	
   905		return virq;
   906	
   907	free_ipi_mask:
   908		for (i = virq; i < virq + nr_irqs; i++) {
   909			data = irq_get_irq_data(i);
   910			ipi_mask_free(data->common->ipi_mask);
   911		}
   912	free_descs:
   913		irq_free_descs(virq, nr_irqs);
   914		return 0;
   915	}
   916	
   917	/**
   918	 * irq_destroy_ipi() - unreserve an IPI that was previously allocated
   919	 * @irq: linux irq number to be destroyed
   920	 *
   921	 * Return the IPIs allocated with irq_reserve_ipi() to the system destroying all
   922	 * virqs associated with them.
   923	 */
   924	void irq_destroy_ipi(unsigned int irq)
   925	{
   926		struct irq_data *data = irq_get_irq_data(irq);
   927		struct irq_domain *domain;
   928		unsigned int nr_irqs, i;
   929	
   930		if (!irq || !data)
   931			return;
   932	
   933		domain = data->domain;
   934		if (WARN_ON(domain == NULL))
   935			return;
   936	
   937		if (!irq_domain_is_ipi(domain)) {
   938			pr_warn("Not an IPI domain!\n");
   939			return;
   940		}
   941	
   942		nr_irqs = ipi_mask_weight(data->common->ipi_mask);
   943		ipi_mask_free(data->common->ipi_mask);
   944	
   945		for (i = irq + 1; i < irq + nr_irqs; i++) {
   946			data = irq_get_irq_data(i);
   947			ipi_mask_free(data->common->ipi_mask);
   948		}
   949	
 > 950		irq_domain_free_irqs(irq, nr_irqs);
   951	}
   952	
   953	#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--cWoXeonUoKmBZSoM
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--cWoXeonUoKmBZSoM--
