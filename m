Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jul 2014 15:19:00 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:35271 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816615AbaGXNSzQv7Nv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jul 2014 15:18:55 +0200
Received: from aurel32 by hall.aurel32.net with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1XAIv4-0005cW-2N; Thu, 24 Jul 2014 15:18:50 +0200
Date:   Thu, 24 Jul 2014 15:18:49 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        Andreas Barth <aba@ayous.org>
Subject: Re: SMP IPI issues on Loongson 3A based machines
Message-ID: <20140724131849.GB26280@hall.aurel32.net>
References: <tencent_17A6D3544BFB28F65D92C62E@qq.com>
 <20140724074032.GC18817@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20140724074032.GC18817@hall.aurel32.net>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41565
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Thu, Jul 24, 2014 at 09:40:32AM +0200, Aurelien Jarno wrote:
> On Thu, Jul 24, 2014 at 07:47:02AM +0800, 陈华才 wrote:
> > Hi, Aurelien
> 
> Hi,
> 
> > Could you please attachment your config file? It seems you didn't use
> > the default one.
> 
> Please fine it attached. That said thanks for your idea about using the
> default config file, I built a 3.15.6 kernel with it, and it doesn't 
> crash with it. I'll try to "bisect" the config file to see what is
> causing the issue, and I'll keep you updated.

The issue is reproducible when PREEMPT=y instead of PREEMPT_VOLUNTARY=y
like in the default config. As PREEMPT=y is supposed to be more
aggressive than PREEMPT_VOLUNTARY=y, I guess it allows a deadlock to be
preempted and that it just workarounds the real issue.

Note also that doing this change automatically changes a few other
configuration variables:

| --- defconfig
| +++ badconfig
| @@ -155,9 +155,8 @@
|  CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
|  CONFIG_HZ=256
|  # CONFIG_PREEMPT_NONE is not set
| -# CONFIG_PREEMPT_VOLUNTARY is not set
| -CONFIG_PREEMPT=y
| -CONFIG_PREEMPT_COUNT=y
| +CONFIG_PREEMPT_VOLUNTARY=y
| +# CONFIG_PREEMPT is not set
|  CONFIG_KEXEC=y
|  # CONFIG_CRASH_DUMP is not set
|  CONFIG_SECCOMP=y
| @@ -234,8 +233,8 @@
|  #
|  # RCU Subsystem
|  #
| -CONFIG_TREE_PREEMPT_RCU=y
| -CONFIG_PREEMPT_RCU=y
| +CONFIG_TREE_RCU=y
| +# CONFIG_PREEMPT_RCU is not set
|  CONFIG_RCU_STALL_COMMON=y
|  # CONFIG_RCU_USER_QS is not set
|  CONFIG_RCU_FANOUT=64
| @@ -243,7 +242,6 @@
|  # CONFIG_RCU_FANOUT_EXACT is not set
|  # CONFIG_RCU_FAST_NO_HZ is not set
|  # CONFIG_TREE_RCU_TRACE is not set
| -# CONFIG_RCU_BOOST is not set
|  # CONFIG_RCU_NOCB_CPU is not set
|  # CONFIG_IKCONFIG is not set
|  CONFIG_LOG_BUF_SHIFT=14
| @@ -404,7 +402,11 @@
|  CONFIG_DEFAULT_CFQ=y
|  # CONFIG_DEFAULT_NOOP is not set
|  CONFIG_DEFAULT_IOSCHED="cfq"
| -CONFIG_UNINLINE_SPIN_UNLOCK=y
| +CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
| +CONFIG_INLINE_READ_UNLOCK=y
| +CONFIG_INLINE_READ_UNLOCK_IRQ=y
| +CONFIG_INLINE_WRITE_UNLOCK=y
| +CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
|  CONFIG_MUTEX_SPIN_ON_OWNER=y
|  CONFIG_FREEZER=y
|  
| @@ -3027,7 +3029,6 @@
|  # CONFIG_SCHED_DEBUG is not set
|  # CONFIG_SCHEDSTATS is not set
|  # CONFIG_TIMER_STATS is not set
| -# CONFIG_DEBUG_PREEMPT is not set
|  
|  #
|  # Lock Debugging (spinlocks, mutexes, etc...)
| @@ -3052,12 +3053,10 @@
|  #
|  # RCU Debugging
|  #
| -# CONFIG_PROVE_RCU_DELAY is not set
|  # CONFIG_SPARSE_RCU_POINTER is not set
|  # CONFIG_TORTURE_TEST is not set
|  # CONFIG_RCU_TORTURE_TEST is not set
|  CONFIG_RCU_CPU_STALL_TIMEOUT=21
| -# CONFIG_RCU_CPU_STALL_VERBOSE is not set
|  # CONFIG_RCU_CPU_STALL_INFO is not set
|  # CONFIG_RCU_TRACE is not set
|  # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set

I hope that'll help to reproduce the real problem and to fix it.

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
