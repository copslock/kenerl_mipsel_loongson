Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Nov 2015 16:38:11 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:40060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007270AbbK0PiJdFCSb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 27 Nov 2015 16:38:09 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D99C7AB13;
        Fri, 27 Nov 2015 15:36:25 +0000 (UTC)
Date:   Fri, 27 Nov 2015 16:38:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     kbuild test robot <lkp@intel.com>
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
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        linux-am33-list@redhat.com
Subject: Re: [PATCH v2 1/5] printk/nmi: Generic solution for safe printk in
 NMI
Message-ID: <20151127153804.GC2648@pathway.suse.cz>
References: <1448622572-16900-2-git-send-email-pmladek@suse.com>
 <201511271919.aEZuZKNe%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201511271919.aEZuZKNe%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pmladek@suse.com
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

On Fri 2015-11-27 19:49:48, kbuild test robot wrote:
> Hi Petr,
> 
> [auto build test WARNING on powerpc/next]
> [also build test WARNING on v4.4-rc2 next-20151127]
> [cannot apply to tip/x86/core]
> 
> url:    https://github.com/0day-ci/linux/commits/Petr-Mladek/Cleaning-printk-stuff-in-NMI-context/20151127-191620
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: mn10300-asb2364_defconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mn10300 
> 
> All warnings (new ones prefixed by >>):
> 
> warning: (MN10300) selects HAVE_NMI_WATCHDOG which has unmet direct dependencies (HAVE_NMI)

MN10300 has its own implementation for entering and exiting NMI
handlers. It does not call nmi_enter() and nmi_exit().
Please, find below an updated patch that adds printk_nmi_enter()
and printk_nmi_exit() to the custom entry points.
Then we could add HAVE_NMI to arch/mn10300/Kconfig and avoid
the above warning.

The updated patch also fixes includes in kernel/printk/nmi.c
and kernel/printk/printk.h to fix the other build errors
found by kbuild test robot.

The kbuild test robot is really cool thing!
