Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Oct 2015 12:58:05 +0200 (CEST)
Received: from mga03.intel.com ([134.134.136.65]:58322 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010723AbbJMK6D5DVbe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Oct 2015 12:58:03 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP; 13 Oct 2015 03:57:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,677,1437462000"; 
   d="gz'50?scan'50,208,50";a="809832846"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2015 03:57:52 -0700
Received: from kbuild by bee with local (Exim 4.83)
        (envelope-from <fengguang.wu@intel.com>)
        id 1ZlxH0-000Ltr-FE; Tue, 13 Oct 2015 18:57:38 +0800
Date:   Tue, 13 Oct 2015 18:56:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        jiang.liu@linux.intel.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org, Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [RFC v2 PATCH 07/14] irq: add a new generic IPI reservation code
 to irq core
Message-ID: <201510131859.ryx1tuu6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
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
X-archive-position: 49511
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


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Qais,

[auto build test ERROR on v4.3-rc5 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Qais-Yousef/Implement-generic-IPI-support-mechanism/20151013-182314
config: sh-titan_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   kernel/irq/irqdomain.c: In function 'irq_reserve_ipi':
>> kernel/irq/irqdomain.c:791:2: error: implicit declaration of function '__irq_domain_alloc_irqs' [-Werror=implicit-function-declaration]
   kernel/irq/irqdomain.c:799:18: error: 'struct irq_data' has no member named 'ipi_mask'
   kernel/irq/irqdomain.c:800:6: error: 'struct irq_data' has no member named 'ipi_mask'
   kernel/irq/irqdomain.c: In function 'irq_destroy_ipi':
>> kernel/irq/irqdomain.c:832:2: error: implicit declaration of function 'irq_domain_free_irqs' [-Werror=implicit-function-declaration]
   kernel/irq/irqdomain.c:833:21: error: 'struct irq_data' has no member named 'ipi_mask'
   kernel/irq/irqdomain.c:833:45: error: 'struct irq_data' has no member named 'ipi_mask'
   cc1: some warnings being treated as errors

vim +/__irq_domain_alloc_irqs +791 kernel/irq/irqdomain.c

   785		if (virq <= 0) {
   786			pr_warn("Can't reserve IPI, failed to alloc descs\n");
   787			return 0;
   788		}
   789	
   790		/* we are reusing hierarchy alloc function, should we create another one? */
 > 791		virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
   792						(void *) dest, true);
   793		if (virq <= 0) {
   794			pr_warn("Can't reserve IPI, failed to alloc irqs\n");
   795			goto free_descs;
   796		}
   797	
   798		data = irq_get_irq_data(virq);
   799		bitmap_copy(data->ipi_mask.cpumask, dest->cpumask, dest->nbits);
   800		data->ipi_mask.nbits = dest->nbits;
   801	
   802		return virq;
   803	
   804	free_descs:
   805		irq_free_descs(virq, nr_irqs);
   806		return 0;
   807	}
   808	
   809	/**
   810	 * irq_destroy_ipi() - unreserve an IPI that was previously allocated
   811	 * @irq: linux irq number to be destroyed
   812	 *
   813	 * Return an IPI allocated with irq_reserve_ipi() to the system.
   814	 */
   815	void irq_destroy_ipi(unsigned int irq)
   816	{
   817		struct irq_data *data = irq_get_irq_data(irq);
   818		struct irq_domain *domain;
   819	
   820		if (!irq || !data)
   821			return;
   822	
   823		domain = data->domain;
   824		if (WARN_ON(domain == NULL))
   825			return;
   826	
   827		if (!irq_domain_is_ipi(domain)) {
   828			pr_warn("Not an IPI domain!\n");
   829			return;
   830		}
   831	
 > 832		irq_domain_free_irqs(irq,
   833			bitmap_weight(data->ipi_mask.cpumask, data->ipi_mask.nbits));
   834	}
   835	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--BOKacYhQ+x31HxR3
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
NIxIwb/a0eCl6DpKNEKOsqpYx+9DiW0cdJK7mTdAGIsca6mJlxnabiLh8CMIKngn6A39lhUR
TMrNRgrCwyY6puvYRFUwHEigeuP4fJ16UNaeV7rnpn7mXed4gDxEh4iud1eHVniNtv86yNXk
NzVt/vr35P384+HfExp+UNP0d8Nfr2N8lrBGo6IpdUtNHTkTTiuoS5uFi3mJoj6wNHRHxuye
u3f2BpEa9Tion+GsCjmp0JA42+97l9E2QFA4uRandOj4qMdVduvR5pC6qpI6BpPBhuzoGILr
f0dAgohfgcR8q/7zYIrcO3vVaB11Pgpr4WiKxGwWNFWfLOkA0Z6PVe23iwbvB92MgbZpNfdg
tmzuIbYzcnGsK/VHr2j8SVEu3KKVpqo2NhUin3UA7/cgfXfeHplQf/cIp2tvBwCwGQFsbnyA
5OB9g+RQJp4vpT051LzwIAqaINcwms7U4+eIYM/2RDPklB2xu5QLpol/4cf43zSX8zHAwgso
dyKi3skmeeZeZc3qTTlyFtlsNdVitpl52t+VEuSmxufew5CQk8uGmMLZpJdOZkg4i+YlJPPM
NnFKlgsaqHXptsXRoDvF0zmtZ3MktFkLImNsJKSLzfI/nqkJfdms3VJqs5WLHLFS1eRjuJ5t
PG+LhypodvlkZPnnSTBFwkw27Xu2zkyEzcck7njVjeYLSkl3XGDuCQQxnE7cve28fjChflcK
Z/hUxthkttjcTH7bPb4+HNXf311y+I4XDG4o3W23xDrNhCtlhBLH2hsbMzwW75lvNNkGrrtI
loaYVKHVIrfucleSmH/GXYpq5PaQ75DbRu2kgx0WEoraBPAcJR0qjyEBCFwZlo2GSbgMRzuq
48Kr32WhfnDapcjSMldWv9YHPfo6zxDy2IPSl93PjLHzRLXn9MztmtkEN75X9euLfSUbPipV
7fGPn5BjTvz9+H7/bUJe7789vj/cQ/gf17lVa+moNskgYCtsox6g6iYCmtP3R70sKEU9Y5hG
tq4XNLNW6UGpswi3lac8ypxnOUZ7JCS5ZJaVZFuk4wHtuDutjNHAntnrhsnZYoY5/HeVYsns
wHSEMmzrA3BBaumMcmA2mtihwpMwmM1mNTZ3cpggzoshs82COj8DgW+UCZtfxkh2Ohm7GTgQ
kLAhioINBja0lIQspdanUOwBM61s32NbZCTsTantjXs73NIE7sCRaC1KXnfrlNhnlXyfpe7w
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
jBVmtKT/A1d9UNGC+AAA

--BOKacYhQ+x31HxR3--
