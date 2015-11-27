Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 12:50:33 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:5540 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010740AbbK0LubQwYe- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Nov 2015 12:50:31 +0100
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP; 27 Nov 2015 03:50:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,351,1444719600"; 
   d="gz'50?scan'50,208,50";a="695470433"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 27 Nov 2015 03:50:21 -0800
Received: from kbuild by bee with local (Exim 4.83)
        (envelope-from <fengguang.wu@intel.com>)
        id 1a2HXZ-0005zW-TC; Fri, 27 Nov 2015 19:50:13 +0800
Date:   Fri, 27 Nov 2015 19:49:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in
 NMI
Message-ID: <201511271919.aEZuZKNe%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <1448622572-16900-2-git-send-email-pmladek@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50154
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


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Petr,

[auto build test WARNING on powerpc/next]
[also build test WARNING on v4.4-rc2 next-20151127]
[cannot apply to tip/x86/core]

url:    https://github.com/0day-ci/linux/commits/Petr-Mladek/Cleaning-printk-stuff-in-NMI-context/20151127-191620
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: mn10300-asb2364_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mn10300 

All warnings (new ones prefixed by >>):

warning: (MN10300) selects HAVE_NMI_WATCHDOG which has unmet direct dependencies (HAVE_NMI)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--EeQfGwPcQSOJBaQU
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
di8HLjJMhlz/B1LI0AJEfwAA

--EeQfGwPcQSOJBaQU--
