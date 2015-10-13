Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 12:58:25 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:5832 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010908AbbJMK6MNTWRe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Oct 2015 12:58:12 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP; 13 Oct 2015 03:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,677,1437462000"; 
   d="gz'50?scan'50,208,50";a="825515046"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2015 03:58:03 -0700
Received: from kbuild by bee with local (Exim 4.83)
        (envelope-from <fengguang.wu@intel.com>)
        id 1ZlxHA-000MOp-Jq; Tue, 13 Oct 2015 18:57:48 +0800
Date:   Tue, 13 Oct 2015 18:56:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        jiang.liu@linux.intel.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [RFC v2 PATCH 07/14] irq: add a new generic IPI reservation code
 to irq core
Message-ID: <201510131846.WLNB7o7L%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <1444731382-19313-8-git-send-email-qais.yousef@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49512
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


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Qais,

[auto build test ERROR on v4.3-rc5 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Qais-Yousef/Implement-generic-IPI-support-mechanism/20151013-182314
config: x86_64-allnoconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   kernel/irq/irqdomain.c: In function 'irq_reserve_ipi':
>> kernel/irq/irqdomain.c:799:18: error: 'struct irq_data' has no member named 'ipi_mask'
     bitmap_copy(data->ipi_mask.cpumask, dest->cpumask, dest->nbits);
                     ^
   kernel/irq/irqdomain.c:800:6: error: 'struct irq_data' has no member named 'ipi_mask'
     data->ipi_mask.nbits = dest->nbits;
         ^
   kernel/irq/irqdomain.c: In function 'irq_destroy_ipi':
   kernel/irq/irqdomain.c:833:21: error: 'struct irq_data' has no member named 'ipi_mask'
      bitmap_weight(data->ipi_mask.cpumask, data->ipi_mask.nbits));
                        ^
   kernel/irq/irqdomain.c:833:45: error: 'struct irq_data' has no member named 'ipi_mask'
      bitmap_weight(data->ipi_mask.cpumask, data->ipi_mask.nbits));
                                                ^

vim +799 kernel/irq/irqdomain.c

   793		if (virq <= 0) {
   794			pr_warn("Can't reserve IPI, failed to alloc irqs\n");
   795			goto free_descs;
   796		}
   797	
   798		data = irq_get_irq_data(virq);
 > 799		bitmap_copy(data->ipi_mask.cpumask, dest->cpumask, dest->nbits);
   800		data->ipi_mask.nbits = dest->nbits;
   801	
   802		return virq;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--UlVJffcvxoiEqYs2
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--UlVJffcvxoiEqYs2--
