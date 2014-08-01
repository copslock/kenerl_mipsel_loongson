Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2014 07:43:45 +0200 (CEST)
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:61063 "EHLO
        mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816005AbaHAFnjndQ3V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2014 07:43:39 +0200
X-IronPort-AV: E=Sophos;i="5.01,777,1400050800"; 
   d="scan'208";a="41011026"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw3-out.broadcom.com with ESMTP; 31 Jul 2014 22:54:51 -0700
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Thu, 31 Jul 2014 22:43:30 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP Server id
 14.3.174.1; Thu, 31 Jul 2014 22:43:31 -0700
Received: from jayachandranc.netlogicmicro.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 17A3A9FA7C;    Thu, 31 Jul 2014 22:43:19 -0700 (PDT)
Date:   Fri, 1 Aug 2014 11:17:40 +0530
From:   Jayachandran C. <jchandra@broadcom.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
CC:     kbuild test robot <fengguang.wu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        kbuild-all <kbuild-all@01.org>, <linux-mips@linux-mips.org>
Subject: Re: [next:master
 9246/10000]arch/mips/include/asm/mach-netlogic/topology.h:14:0:
 warning:"topology_physical_package_id" redefined
Message-ID: <20140801054739.GF12788@jayachandranc.netlogicmicro.com>
References: <53dac64a.+6998x07jTwh9JtK%fengguang.wu@intel.com>
 <tencent_4DD2F4897C8F21F621E1333A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_4DD2F4897C8F21F621E1333A@qq.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41856
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Hi Huacai,

On Fri, Aug 01, 2014 at 09:19:11AM +0800, 陈华才 wrote:
> Hi, Jayachandran
> 
> I think I introduce a more *general* method of MIPS CPU's topology in commit bda4584cd94 (MIPS: Support CPU topology files in sysfs). So, could you please modify the Netlogic's code to adaptive the new framework? If you can't do that, I'll send a new version of my patch by adding some #ifndef.

You have added the definitions for topology in asm/smp.h

+#define topology_physical_package_id(cpu)      (cpu_data[cpu].package)
+#define topology_core_id(cpu)                  (cpu_data[cpu].core)
+#define topology_core_cpumask(cpu)             (&cpu_core_map[cpu])
+#define topology_thread_cpumask(cpu)           (&cpu_sibling_map[cpu])

These changes have to be in asm/topology.h and should only change the
definitions if mach-<platform>/topology.h does not define them.

Can you please look at fixing this?

Thanks,
JC.
