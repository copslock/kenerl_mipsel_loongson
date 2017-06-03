Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Jun 2017 08:37:27 +0200 (CEST)
Received: from mga14.intel.com ([192.55.52.115]:62713 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990511AbdFCGgygLkrf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 3 Jun 2017 08:36:54 +0200
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2017 23:36:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,287,1493708400"; 
   d="scan'208";a="94233607"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 02 Jun 2017 23:36:51 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1dH2jh-000UZ5-05; Sat, 03 Jun 2017 14:40:33 +0800
Date:   Sat, 3 Jun 2017 14:36:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     kbuild-all@01.org, netdev@vger.kernel.org,
        Tobias Klauser <tklauser@distanz.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jarod Wilson <jarod@redhat.com>, linux-mips@linux-mips.org,
        Eric Dumazet <edumazet@google.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v3 4/7] net: pch_gbe: Add device tree support
Message-ID: <201706031442.vYKOKOkq%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170602234042.22782-5-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58183
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

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.12-rc3 next-20170602]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Burton/net-pch_gbe-Fixes-MIPS-support/20170603-112042


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c:2587:9-16: WARNING: ERR_CAST can be used with gpio

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
