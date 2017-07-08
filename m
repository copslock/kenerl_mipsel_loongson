Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2017 04:06:24 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:8477 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993952AbdGHCGRPxGc2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Jul 2017 04:06:17 +0200
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2017 19:06:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,326,1496127600"; 
   d="scan'208";a="876615481"
Received: from deliniu-mobl1.ccr.corp.intel.com (HELO wfg-t540p.sh.intel.com) ([10.255.25.97])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jul 2017 19:06:13 -0700
Received: from wfg by wfg-t540p.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1dTf8P-0001HD-3O; Sat, 08 Jul 2017 10:06:13 +0800
Date:   Sat, 8 Jul 2017 10:06:13 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
Cc:     linux-mips@linux-mips.org, kbuild-all@01.org
Subject: Re: [kbuild-all] [mips-sjhill:mips-for-linux-next 36/72]
 arch/mips/include/asm/cmpxchg.h:135:8: error: expected ':' or ')' before
 '__scbeqz'
Message-ID: <20170708020613.h6summkhmivjcbse@wfg-t540p.sh.intel.com>
References: <201706300326.dDkxWeg8%fengguang.wu@intel.com>
 <ab6bbbbf-6307-df8c-8440-1463e7821c5a@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab6bbbbf-6307-df8c-8440-1463e7821c5a@cavium.com>
User-Agent: NeoMutt/20161104 (1.7.1)
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59067
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

Hi Steven,

On Fri, Jul 07, 2017 at 09:45:13AM -0500, Steven J. Hill wrote:
>On 06/29/2017 02:41 PM, kbuild test robot wrote:
>> tree:   git://git.linux-mips.org/pub/scm/sjhill/linux-sjhill.git mips-for-linux-next head:   152e63e374cdc0dc7a321d523dd2930de0acdabf commit: 6b1e76297c4ad4b906fdf054460e4e56914f6e34 [36/72] MIPS: cmpxchg: Unify R10000_LLSC_WAR & non-R10000_LLSC_WAR cases config: mips-allyesconfig (attached as .config) compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705 reproduce: wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross chmod +x ~/bin/make.cross git checkout 6b1e76297c4ad4b906fdf054460e4e56914f6e34 # save the attached .config to linux build tree make.cross ARCH=mips
>>
>OMG...please remove this tree from the build robot. It is my
>personal tree and of no value to anyone. Cheers.

Sorry for the noise! Would you like to remove the testing altogether,
or switch the reporting to private emails? The latter is normally
preferred.

Cheers,
Fengguang
