Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2017 17:14:05 +0200 (CEST)
Received: from mga11.intel.com ([192.55.52.93]:23103 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993423AbdDKPN4dXone (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Apr 2017 17:13:56 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2017 08:13:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,186,1488873600"; 
   d="gz'50?scan'50,208,50";a="1154401040"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 11 Apr 2017 08:13:52 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1cxxWJ-000XL8-RQ; Tue, 11 Apr 2017 23:15:51 +0800
Date:   Tue, 11 Apr 2017 23:13:20 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Cc:     kbuild-all@01.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [mips-sjhill:mips-for-linux-next 22/28]
 arch/mips/kernel/smp-cps.c:446:8: error: implicit declaration of function
 'cpu_report_death'
Message-ID: <201704112353.jxQ8Oz1n%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
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


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.linux-mips.org/pub/scm/sjhill/linux-sjhill.git mips-for-linux-next
head:   fc048e96ed2825cfa8b71d40cfdef842b8ea59d6
commit: d0f801e14727763aadf85618917c77759fec6f81 [22/28] MIPS: Use common outgoing-CPU-notification code
config: mips-64r6el_defconfig (attached as .config)
compiler: mips64el-linux-gnuabi64-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d0f801e14727763aadf85618917c77759fec6f81
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   arch/mips/kernel/smp-cps.c: In function 'play_dead':
>> arch/mips/kernel/smp-cps.c:446:8: error: implicit declaration of function 'cpu_report_death' [-Werror=implicit-function-declaration]
     (void)cpu_report_death();
           ^~~~~~~~~~~~~~~~
   arch/mips/kernel/smp-cps.c: In function 'cps_cpu_die':
>> arch/mips/kernel/smp-cps.c:495:7: error: implicit declaration of function 'cpu_wait_death' [-Werror=implicit-function-declaration]
     if (!cpu_wait_death(cpu, 5)) {
          ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/cpu_report_death +446 arch/mips/kernel/smp-cps.c

   440				cpu_death = CPU_DEATH_HALT;
   441				break;
   442			}
   443		}
   444	
   445		/* This CPU has chosen its way out */
 > 446		(void)cpu_report_death();
   447	
   448		if (cpu_death == CPU_DEATH_HALT) {
   449			vpe_id = cpu_vpe_id(&cpu_data[cpu]);
   450	
   451			pr_debug("Halting core %d VP%d\n", core, vpe_id);
   452			if (cpu_has_mipsmt) {
   453				/* Halt this TC */
   454				write_c0_tchalt(TCHALT_H);
   455				instruction_hazard();
   456			} else if (cpu_has_vp) {
   457				write_cpc_cl_vp_stop(1 << vpe_id);
   458	
   459				/* Ensure that the VP_STOP register is written */
   460				wmb();
   461			}
   462		} else {
   463			pr_debug("Gating power to core %d\n", core);
   464			/* Power down the core */
   465			cps_pm_enter_state(CPS_PM_POWER_GATED);
   466		}
   467	
   468		/* This should never be reached */
   469		panic("Failed to offline CPU %u", cpu);
   470	}
   471	
   472	static void wait_for_sibling_halt(void *ptr_cpu)
   473	{
   474		unsigned cpu = (unsigned long)ptr_cpu;
   475		unsigned vpe_id = cpu_vpe_id(&cpu_data[cpu]);
   476		unsigned halted;
   477		unsigned long flags;
   478	
   479		do {
   480			local_irq_save(flags);
   481			settc(vpe_id);
   482			halted = read_tc_c0_tchalt();
   483			local_irq_restore(flags);
   484		} while (!(halted & TCHALT_H));
   485	}
   486	
   487	static void cps_cpu_die(unsigned int cpu)
   488	{
   489		unsigned core = cpu_data[cpu].core;
   490		unsigned int vpe_id = cpu_vpe_id(&cpu_data[cpu]);
   491		unsigned stat;
   492		int err;
   493	
   494		/* Wait for the cpu to choose its way out */
 > 495		if (!cpu_wait_death(cpu, 5)) {
   496			pr_err("CPU%u: didn't offline\n", cpu);
   497			return;
   498		}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--WIyZ46R2i8wDzkSu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
9d1r6gkTh+xVg/T9P0WzD7u1yQAA

--WIyZ46R2i8wDzkSu--
