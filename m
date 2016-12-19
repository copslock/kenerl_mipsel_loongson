Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 05:29:37 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:3119 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990720AbcLSE3asW56g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Dec 2016 05:29:30 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP; 18 Dec 2016 20:29:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,372,1477983600"; 
   d="gz'50?scan'50,208,50";a="1101302162"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 18 Dec 2016 20:29:25 -0800
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1cIpbS-000C1p-B6; Mon, 19 Dec 2016 12:31:10 +0800
Date:   Mon, 19 Dec 2016 12:28:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     kbuild-all@01.org, ralf@linux-mips.org, paul.burton@imgtec.com,
        rabinv@axis.com, matt.redfearn@imgtec.com, james.hogan@imgtec.com,
        alexander.sverdlin@nokia.com, robh+dt@kernel.org,
        frowand.list@gmail.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 01/21] MIPS memblock: Unpin dts memblock sanity check
 method
Message-ID: <201612191225.8v9sc58G%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <1482113266-13207-2-git-send-email-fancer.lancer@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56088
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


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Serge,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.9 next-20161216]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Serge-Semin/MIPS-memblock-Remove-bootmem-code-and-switch-to-NO_BOOTMEM/20161219-105045
config: openrisc-or1ksim_defconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All warnings (new ones prefixed by >>):

   drivers/of/fdt.c: In function 'sanity_check_dt_memory':
>> drivers/of/fdt.c:1125:4: warning: format '%llx' expects type 'long long unsigned int', but argument 2 has type 'phys_addr_t'
   drivers/of/fdt.c:1125:4: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'phys_addr_t'
   drivers/of/fdt.c:1129:3: warning: format '%llx' expects type 'long long unsigned int', but argument 2 has type 'phys_addr_t'
   drivers/of/fdt.c:1129:3: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'phys_addr_t'
   drivers/of/fdt.c:1133:3: warning: format '%llx' expects type 'long long unsigned int', but argument 2 has type 'phys_addr_t'
   drivers/of/fdt.c:1133:3: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'phys_addr_t'
   drivers/of/fdt.c:1138:3: warning: format '%llx' expects type 'long long unsigned int', but argument 2 has type 'phys_addr_t'
   drivers/of/fdt.c:1138:3: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'phys_addr_t'
   drivers/of/fdt.c:1144:3: warning: format '%llx' expects type 'long long unsigned int', but argument 2 has type 'phys_addr_t'
   drivers/of/fdt.c:1144:3: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'phys_addr_t'
   drivers/of/fdt.c:1147:3: warning: format '%llx' expects type 'long long unsigned int', but argument 2 has type 'phys_addr_t'
   drivers/of/fdt.c:1147:3: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'phys_addr_t'
   drivers/of/fdt.c:1151:3: warning: format '%llx' expects type 'long long unsigned int', but argument 2 has type 'phys_addr_t'
   drivers/of/fdt.c:1151:3: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'phys_addr_t'
   drivers/of/fdt.c:1157:3: warning: format '%llx' expects type 'long long unsigned int', but argument 2 has type 'phys_addr_t'
   drivers/of/fdt.c:1157:3: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'phys_addr_t'
   drivers/of/fdt.c:1161:3: warning: format '%llx' expects type 'long long unsigned int', but argument 2 has type 'phys_addr_t'
   drivers/of/fdt.c:1161:3: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'phys_addr_t'
   drivers/of/fdt.c: In function 'early_init_dt_add_memory_arch':
   drivers/of/fdt.c:1173:2: warning: passing argument 1 of 'sanity_check_dt_memory' from incompatible pointer type
   drivers/of/fdt.c:1117:12: note: expected 'phys_addr_t *' but argument is of type 'u64 *'
   drivers/of/fdt.c:1173:2: warning: passing argument 2 of 'sanity_check_dt_memory' from incompatible pointer type
   drivers/of/fdt.c:1117:12: note: expected 'phys_addr_t *' but argument is of type 'u64 *'

vim +1125 drivers/of/fdt.c

  1109	#ifdef CONFIG_HAVE_MEMBLOCK
  1110	#ifndef MIN_MEMBLOCK_ADDR
  1111	#define MIN_MEMBLOCK_ADDR	__pa(PAGE_OFFSET)
  1112	#endif
  1113	#ifndef MAX_MEMBLOCK_ADDR
  1114	#define MAX_MEMBLOCK_ADDR	((phys_addr_t)~0)
  1115	#endif
  1116	
  1117	int __init sanity_check_dt_memory(phys_addr_t *out_base,
  1118					  phys_addr_t *out_size)
  1119	{
  1120		phys_addr_t base = *out_base, size = *out_size;
  1121		const u64 phys_offset = MIN_MEMBLOCK_ADDR;
  1122	
  1123		if (!PAGE_ALIGNED(base)) {
  1124			if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
> 1125				pr_err("Memblock 0x%llx - 0x%llx isn't page aligned\n",
  1126					base, base + size);
  1127				return -EINVAL;
  1128			}
  1129			pr_warn("Memblock 0x%llx - 0x%llx shifted to ",
  1130				base, base + size);
  1131			size -= PAGE_SIZE - (base & ~PAGE_MASK);
  1132			base = PAGE_ALIGN(base);
  1133			pr_cont("0x%llx - 0x%llx\n", base, base + size);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--DocE+STaALJfprDB
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
kaNN+R/xxid3M2wAAA==

--DocE+STaALJfprDB--
