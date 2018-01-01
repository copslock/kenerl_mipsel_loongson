Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jan 2018 19:02:07 +0100 (CET)
Received: from mga09.intel.com ([134.134.136.24]:45514 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992126AbeAASB6zyhXY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Jan 2018 19:01:58 +0100
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2018 10:01:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.45,492,1508828400"; 
   d="scan'208";a="6547058"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jan 2018 10:01:46 -0800
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1eW4VL-000E36-3k; Tue, 02 Jan 2018 02:08:07 +0800
Date:   Tue, 2 Jan 2018 02:01:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     kbuild-all@01.org, mturquette@baylibre.com, sboyd@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-mips@linux-mips.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-rtc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org,
        pure.logic@nexus-software.ie, linux-omap@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 01/33] clk_ops: change round_rate() to return unsigned
 long
Message-ID: <201801020112.PEMNifTo%fengguang.wu@intel.com>
References: <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61804
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

Hi Bryan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tegra/for-next]
[also build test WARNING on v4.15-rc6]
[cannot apply to clk/clk-next next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bryan-O-Donoghue/change-clk_ops-round_rate-to-scale-past-LONG_MAX/20180101-212907
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +321 drivers/clk/clk-versaclock5.c

8c1ebe97 Marek Vasut 2017-07-09  318  
8c1ebe97 Marek Vasut 2017-07-09  319  static const struct clk_ops vc5_dbl_ops = {
8c1ebe97 Marek Vasut 2017-07-09  320  	.recalc_rate	= vc5_dbl_recalc_rate,
8c1ebe97 Marek Vasut 2017-07-09 @321  	.round_rate	= vc5_dbl_round_rate,
8c1ebe97 Marek Vasut 2017-07-09  322  	.set_rate	= vc5_dbl_set_rate,
8c1ebe97 Marek Vasut 2017-07-09  323  };
8c1ebe97 Marek Vasut 2017-07-09  324  

:::::: The code at line 321 was first introduced by commit
:::::: 8c1ebe9762670159ca982167131af63c94ff1571 clk: vc5: Add support for the input frequency doubler

:::::: TO: Marek Vasut <marek.vasut@gmail.com>
:::::: CC: Stephen Boyd <sboyd@codeaurora.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
