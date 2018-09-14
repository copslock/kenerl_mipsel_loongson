Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Sep 2018 14:57:18 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:16344 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992066AbeINM5OkcS4- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Sep 2018 14:57:14 +0200
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 05:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,373,1531810800"; 
   d="gz'50?scan'50,208,50";a="83511045"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 14 Sep 2018 05:55:36 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1g0ndH-0000nB-Ta; Fri, 14 Sep 2018 20:55:35 +0800
Date:   Fri, 14 Sep 2018 20:55:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     kbuild-all@01.org, Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: Re: [PATCH 3/3] mips: uapi header and system call table file
 generation
Message-ID: <201809142014.V0LXpNws%fengguang.wu@intel.com>
References: <1536914314-5026-4-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <1536914314-5026-4-git-send-email-firoz.khan@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <lkp@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66289
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


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Firoz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc3 next-20180913]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Firoz-Khan/mips-Add-__NR_syscalls-macro-in-uapi-asm-unistd-h/20180914-184600
config: mips-allnoconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   arch/mips/kernel/scall32-o32.o: In function `einval':
>> (.text+0x678): undefined reference to `mipsmt_sys_sched_setaffinity'
>> (.text+0x67c): undefined reference to `mipsmt_sys_sched_getaffinity'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--a8Wt8u1KmwUX3Y2C
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--a8Wt8u1KmwUX3Y2C--
