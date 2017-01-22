Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2017 18:50:31 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:50553 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992029AbdAVRuH4scSs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Jan 2017 18:50:07 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP; 22 Jan 2017 09:49:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,270,1477983600"; 
   d="scan'208";a="1116255669"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jan 2017 09:49:49 -0800
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1cVMJH-000ChX-23; Mon, 23 Jan 2017 01:52:11 +0800
Date:   Mon, 23 Jan 2017 01:49:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        james.hogan@imgtec.com, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 04/14] GPIO: Add gpio-ingenic driver
Message-ID: <201701230130.T42P6EcW%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170122144947.16158-5-paul@crapouillou.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56458
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

Hi Paul,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.10-rc4 next-20170120]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Cercueil/Ingenic-JZ4740-JZ4780-pinctrl-driver/20170122-232326


coccinelle warnings: (new ones prefixed by >>)

>> drivers/gpio/gpio-ingenic.c:101:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
