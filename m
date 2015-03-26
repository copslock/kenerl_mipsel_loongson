Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Mar 2015 14:05:24 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57480 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014638AbbCZNFWuB8is (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Mar 2015 14:05:22 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2QD5Jku012803;
        Thu, 26 Mar 2015 14:05:19 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2QD5I98012802;
        Thu, 26 Mar 2015 14:05:18 +0100
Date:   Thu, 26 Mar 2015 14:05:18 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, linux-pm@vger.kernel.org,
        Hongliang Tao <taohl@lemote.com>
Subject: Re: [PATCH V8 8/8] MIPS: Loongson: Make CPUFreq usable for Loongson-3
Message-ID: <20150326130517.GD9705@linux-mips.org>
References: <1426213836-28600-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426213836-28600-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Mar 13, 2015 at 10:30:36AM +0800, Huacai Chen wrote:

> Loongson-3A/3B support frequency scaling. But due to hardware
> limitation, Loongson-3A's frequency scaling is not independent for
> each core, we suggest enable Loongson-3A's CPUFreq only when there is
> one core online. Loongson-3B can adjust frequency independently for
> each core, so it can be always enabled.
> 
> Each package has only one register (ChipConfig or FreqCtrl) to control
> frequency, so we need spinlocks to protect register access for multi-
> cores. However, we cannot use spinlock when a core becomes into "wait"
> status (frequency = 0), so we only enable "wait" when there is one core
> in a package online.
> 
> arch/mips/kernel/smp.c is modified to guarantee udelay_val has the
> correct value while both CPU hotplug and CPUFreq are enabled.

With clockscaling you have a fundamental problem with udelay.  If the clock
is increased for a CPU that already has computed the number of iterations
of the delay loop for the old, lower clock rate, it is possible that
udelay won't wait for long enough.

The opposite case would result in waiting too long but that's not a big
problem as udelay only guarantees a minimum waiting time.

So you probably need a different delay mechanism than the classic delay
loop on SMP with clockscaling.

  Ralf
