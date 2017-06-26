Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 07:40:13 +0200 (CEST)
Received: from mga07.intel.com ([134.134.136.100]:41791 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993418AbdFZFkBFcJo6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 26 Jun 2017 07:40:01 +0200
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP; 25 Jun 2017 22:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,394,1493708400"; 
   d="gz'50?scan'50,208,50";a="119213369"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2017 22:39:54 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1dPMo5-0002R7-LO; Mon, 26 Jun 2017 13:43:29 +0800
Date:   Mon, 26 Jun 2017 13:39:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     kbuild-all@01.org, rth@twiddle.net, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@synopsys.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, geert@linux-m68k.org,
        ralf@linux-mips.org, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, cmetcalf@mellanox.com, gxt@mprc.pku.edu.cn,
        bhelgaas@google.com, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-pci@vger.kernel.org, hch@infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH] pci: Add and use PCI_GENERIC_SETUP Kconfig entry
Message-ID: <201706261344.OUjMGlsQ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20170623220857.28774-2-palmer@dabbelt.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58792
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

Hi Palmer,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.12-rc6]
[cannot apply to next-20170623]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Palmer-Dabbelt/pci-Add-and-use-PCI_GENERIC_SETUP-Kconfig-entry/20170626-043558
config: m68k-allnoconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

warning: (M68K) selects PCI_GENERIC_SETUP which has unmet direct dependencies (MMU)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
JPY8AAA=

--82I3+IH0IqGh5yIs--
