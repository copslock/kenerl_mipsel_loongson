Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Nov 2017 08:46:51 +0100 (CET)
Received: from mga01.intel.com ([192.55.52.88]:56589 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990395AbdKEHqogXbsp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Nov 2017 08:46:44 +0100
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2017 00:46:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.44,346,1505804400"; 
   d="gz'50?scan'50,208,50";a="332241334"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga004.fm.intel.com with ESMTP; 05 Nov 2017 00:46:39 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1eBFic-000KVl-PV; Sun, 05 Nov 2017 15:51:46 +0800
Date:   Sun, 5 Nov 2017 15:45:59 +0800
From:   kbuild test robot <lkp@intel.com>
To:     David Daney <david.daney@cavium.com>
Cc:     kbuild-all@01.org, linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, David Daney <david.daney@cavium.com>,
        Carlos Munoz <cmunoz@caviumnetworks.com>
Subject: Re: [PATCH 5/7] MIPS: Octeon: Automatically provision CVMSEG space.
Message-ID: <201711051521.E1wdDphN%fengguang.wu@intel.com>
References: <20171102003606.19913-6-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20171102003606.19913-6-david.daney@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60714
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


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.14-rc7]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Daney/Cavium-OCTEON-III-network-driver/20171105-012026
config: mips-cavium_octeon_defconfig (attached as .config)
compiler: mips64-linux-gnuabi64-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/staging/octeon/ethernet-rx.c:31:0:
   drivers/staging/octeon/ethernet-rx.c: In function 'cvm_oct_poll':
>> drivers/staging/octeon/ethernet-defines.h:35:38: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function)
    #define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
                                         ^
>> drivers/staging/octeon/ethernet-rx.c:204:6: note: in expansion of macro 'USE_ASYNC_IOBDMA'
     if (USE_ASYNC_IOBDMA) {
         ^~~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet-defines.h:35:38: note: each undeclared identifier is reported only once for each function it appears in
    #define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
                                         ^
>> drivers/staging/octeon/ethernet-rx.c:204:6: note: in expansion of macro 'USE_ASYNC_IOBDMA'
     if (USE_ASYNC_IOBDMA) {
         ^~~~~~~~~~~~~~~~
--
   In file included from drivers/staging/octeon/ethernet-tx.c:30:0:
   drivers/staging/octeon/ethernet-tx.c: In function 'cvm_oct_xmit':
>> drivers/staging/octeon/ethernet-defines.h:35:38: error: 'CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE' undeclared (first use in this function)
    #define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
                                         ^
>> drivers/staging/octeon/ethernet-tx.c:182:6: note: in expansion of macro 'USE_ASYNC_IOBDMA'
     if (USE_ASYNC_IOBDMA) {
         ^~~~~~~~~~~~~~~~
   drivers/staging/octeon/ethernet-defines.h:35:38: note: each undeclared identifier is reported only once for each function it appears in
    #define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
                                         ^
>> drivers/staging/octeon/ethernet-tx.c:182:6: note: in expansion of macro 'USE_ASYNC_IOBDMA'
     if (USE_ASYNC_IOBDMA) {
         ^~~~~~~~~~~~~~~~

vim +/CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE +35 drivers/staging/octeon/ethernet-defines.h

80ff0fd3 David Daney 2009-05-05  34  
80ff0fd3 David Daney 2009-05-05 @35  #define USE_ASYNC_IOBDMA            (CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE > 0)
80ff0fd3 David Daney 2009-05-05  36  

:::::: The code at line 35 was first introduced by commit
:::::: 80ff0fd3ab6451407a20c19b80c1643c4a6d6434 Staging: Add octeon-ethernet driver files.

:::::: TO: David Daney <ddaney@caviumnetworks.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--jI8keyz6grp/JLjh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--jI8keyz6grp/JLjh--
