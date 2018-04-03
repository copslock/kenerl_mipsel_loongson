Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 22:58:10 +0200 (CEST)
Received: from mga03.intel.com ([134.134.136.65]:31885 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990413AbeDCU6AZV-e0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Apr 2018 22:58:00 +0200
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2018 13:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,402,1517904000"; 
   d="gz'50?scan'50,208,50";a="39133468"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Apr 2018 13:57:54 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1f3T05-0009Ox-Im; Wed, 04 Apr 2018 04:57:53 +0800
Date:   Wed, 4 Apr 2018 04:57:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     kbuild-all@01.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 5/5] MIPS: perf: Fold vpe_id() macro into it's one last
 usage
Message-ID: <201804040426.r7NS8aS0%fengguang.wu@intel.com>
References: <1522758691-17003-6-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <1522758691-17003-6-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63407
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


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matt,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v4.16 next-20180403]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matt-Redfearn/MIPS-perf-MT-fixes-and-improvements/20180404-011026
config: mips-gpr_defconfig (attached as .config)
compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:14:0,
                    from include/linux/cpumask.h:10,
                    from arch/mips/kernel/perf_event_mipsxx.c:18:
   arch/mips/kernel/perf_event_mipsxx.c: In function 'mipsxx_pmu_free_counter':
   arch/mips/kernel/perf_event_mipsxx.c:353:42: error: 'cpu' undeclared (first use in this function)
     pr_debug("CPU%d released counter %d\n", cpu, hwc->idx);
                                             ^
   include/linux/printk.h:136:17: note: in definition of macro 'no_printk'
      printk(fmt, ##__VA_ARGS__);  \
                    ^~~~~~~~~~~
   arch/mips/kernel/perf_event_mipsxx.c:353:2: note: in expansion of macro 'pr_debug'
     pr_debug("CPU%d released counter %d\n", cpu, hwc->idx);
     ^~~~~~~~
   arch/mips/kernel/perf_event_mipsxx.c:353:42: note: each undeclared identifier is reported only once for each function it appears in
     pr_debug("CPU%d released counter %d\n", cpu, hwc->idx);
                                             ^
   include/linux/printk.h:136:17: note: in definition of macro 'no_printk'
      printk(fmt, ##__VA_ARGS__);  \
                    ^~~~~~~~~~~
   arch/mips/kernel/perf_event_mipsxx.c:353:2: note: in expansion of macro 'pr_debug'
     pr_debug("CPU%d released counter %d\n", cpu, hwc->idx);
     ^~~~~~~~
   arch/mips/kernel/perf_event_mipsxx.c: In function 'mipsxx_pmu_enable_event':
>> arch/mips/kernel/perf_event_mipsxx.c:372:25: error: 'cpu_has_mipsmt_pertccounters' undeclared (first use in this function); did you mean 'can_use_mips_counter'?
      unsigned int vpe_id = cpu_has_mipsmt_pertccounters ? 0 :
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
                            can_use_mips_counter
   arch/mips/kernel/perf_event_mipsxx.c:376:22: error: expected expression before ')' token
     } else if (range > V) {
                         ^
   arch/mips/kernel/perf_event_mipsxx.c: In function 'mipspmu_perf_event_encode':
   arch/mips/kernel/perf_event_mipsxx.c:708:28: error: 'const struct mips_perf_event' has no member named 'range'
      return ((unsigned int)pev->range << 24) |
                               ^~

vim +372 arch/mips/kernel/perf_event_mipsxx.c

   327	
   328	static void mipsxx_pmu_free_counter(struct cpu_hw_events *cpuc,
   329					    struct hw_perf_event *hwc)
   330	{
   331	#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
   332		int sibling_cpu, cpu = smp_processor_id();
   333	
   334		/* When counters are per-core, free them in all sibling CPUs */
   335		if (!cpu_has_mipsmt_pertccounters) {
   336			struct cpu_hw_events *sibling_cpuc;
   337			unsigned long flags;
   338	
   339			spin_lock_irqsave(&core_counters_lock, flags);
   340	
   341			for_each_cpu(sibling_cpu, &cpu_sibling_map[cpu]) {
   342				sibling_cpuc = per_cpu_ptr(&cpu_hw_events, sibling_cpu);
   343	
   344				clear_bit(hwc->idx, sibling_cpuc->used_mask);
   345				pr_debug("CPU%d released core counter %d\n",
   346					 sibling_cpu, hwc->idx);
   347			}
   348	
   349			spin_unlock_irqrestore(&core_counters_lock, flags);
   350			return;
   351		}
   352	#endif
 > 353		pr_debug("CPU%d released counter %d\n", cpu, hwc->idx);
   354		clear_bit(hwc->idx, cpuc->used_mask);
   355	}
   356	
   357	static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
   358	{
   359		struct perf_event *event = container_of(evt, struct perf_event, hw);
   360		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
   361		unsigned int range = evt->event_base >> 24;
   362	
   363		WARN_ON(idx < 0 || idx >= mipspmu.num_counters);
   364	
   365		cpuc->saved_ctrl[idx] = M_PERFCTL_EVENT(evt->event_base & 0xff) |
   366			(evt->config_base & M_PERFCTL_CONFIG_MASK) |
   367			/* Make sure interrupt enabled. */
   368			MIPS_PERFCTRL_IE;
   369	
   370		if (IS_ENABLED(CONFIG_CPU_BMIPS5000)) {
   371			/* enable the counter for the calling thread */
 > 372			unsigned int vpe_id = cpu_has_mipsmt_pertccounters ? 0 :
   373				(smp_processor_id() & MIPS_CPUID_TO_COUNTER_MASK);
   374	
   375			cpuc->saved_ctrl[idx] |= BIT(12 + vpe_id) | BRCM_PERFCTRL_TC;
   376		} else if (range > V) {
   377			/* The counter is processor wide. Set it up to count all TCs. */
   378			pr_debug("Enabling perf counter for all TCs\n");
   379			cpuc->saved_ctrl[idx] |= M_TC_EN_ALL;
   380		} else {
   381			unsigned int cpu, ctrl;
   382	
   383			/*
   384			 * Set up the counter for a particular CPU when event->cpu is
   385			 * a valid CPU number. Otherwise set up the counter for the CPU
   386			 * scheduling this thread.
   387			 */
   388			cpu = (event->cpu >= 0) ? event->cpu : smp_processor_id();
   389	
   390			ctrl = M_PERFCTL_VPEID(cpu_vpe_id(&cpu_data[cpu]));
   391			ctrl |= M_TC_EN_VPE;
   392			cpuc->saved_ctrl[idx] |= ctrl;
   393			pr_debug("Enabling perf counter for CPU%d\n", cpu);
   394		}
   395		/*
   396		 * We do not actually let the counter run. Leave it until start().
   397		 */
   398	}
   399	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--h31gzZEtNLTqOjlF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AQA=

--h31gzZEtNLTqOjlF--
