Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2016 14:37:04 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:54611 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006981AbcCaMhCc69G- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Mar 2016 14:37:02 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F20CEABB4;
        Thu, 31 Mar 2016 12:36:59 +0000 (UTC)
Date:   Thu, 31 Mar 2016 14:36:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jiri Kosina <jkosina@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v4 5/5] printk/nmi: flush NMI messages on the system panic
Message-ID: <20160331123657.GN5522@pathway.suse.cz>
References: <1459353210-20260-6-git-send-email-pmladek@suse.com>
 <201603310000.dKufp7mg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201603310000.dKufp7mg%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pmladek@suse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52819
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

On Thu 2016-03-31 00:33:54, kbuild test robot wrote:
> Hi Petr,
> 
> [auto build test ERROR on v4.6-rc1]
> [cannot apply to tip/x86/core next-20160330]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Petr-Mladek/Cleaning-printk-stuff-in-NMI-context/20160330-235818
> config: i386-randconfig-s1-201613 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/printk/nmi.c: In function 'printk_nmi_flush_on_panic':
> >> kernel/printk/nmi.c:218:4: error: implicit declaration of function 'debug_locks_off' [-Werror=implicit-function-declaration]
>        debug_locks_off();
>        ^
>    cc1: some warnings being treated as errors

Fixed by adding #include <linux/debug_locks.h> into kernel/printk/nmi.c

Please, find the updated patch below.
