Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 13:16:06 +0100 (CET)
Received: from mail-pg0-x244.google.com ([IPv6:2607:f8b0:400e:c05::244]:56746
        "EHLO mail-pg0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992910AbdKAMP7qiKlz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2017 13:15:59 +0100
Received: by mail-pg0-x244.google.com with SMTP id m18so1952235pgd.13
        for <linux-mips@linux-mips.org>; Wed, 01 Nov 2017 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASGfHtIcZv0d1p1Pls6DuEmhEOf4ah2rLt+//AD6zMM=;
        b=L9CJa389uvHRpgKr06/f2m5coIfbb1QdkHzBIcFwiHmjSu0OsazT8+HQehrJ1EdiR9
         VML6jAFXSaShvg8Ya/6u5Yy6CYJto0NWTIj7Oa0FHOOAlVvhmjvBFUZHo314Z6G56jN8
         lFFKH+DLUBTxN9iUmLdJV9tyZt+7RyUrl3/AYhrQiJa7BuldZ+IqpWNVBe+KcEqHM4XA
         S8xmLd1w1asvvENCVp0l3+FEBGjHHST47xy5NC26+gxvAU6WxgDWNM4rPgbwBaSP2uk6
         0H7s2rmM1b98CMPrL9t3nqgoim9NUdKmId2are2Qv4rjiHPri2OA7iUeJw3ruWPjz+lW
         /RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASGfHtIcZv0d1p1Pls6DuEmhEOf4ah2rLt+//AD6zMM=;
        b=lWZi5tAJejOxKH/gGwns2+IIHOsavxSbW/HeRdziue1YIJZU88bBEAycJGJHu/WcKF
         P2K7F8VNCHruzHwZEM/4jl+a+hdx/APZMaiJuXHJnBFB31/iU8DGDHInC0RMg/8ut65I
         L7915PeJG4K5cJzl98h/E6uQZI6bqgo+JVt3y2jNQRWdmbOXixCG+U8jPpEFps1ZAzXW
         Vap0ZGghLQ/e/UocwbVBFeDHFKNKfgx9IRWNYDPtnmON2mqt40I/7Rc153VM0e3p7p7A
         bwSD1mvvrEkq/5ZPlOgTQ3aTYFiC/tMDmVr8arA+TSQibtjuSzKNvBtqzbJrS4QGvp9T
         MVbQ==
X-Gm-Message-State: AMCzsaWsFSqvJUpsbOAhjjwEmhMn5bqOCBbuzdABSPnXo57eNI4FNPI6
        3nRj4QMfuWeH2kcHNE2U9NI=
X-Google-Smtp-Source: ABhQp+S5P8oYwZbdtre4laDB/gFF3F/ER+36QK9Ttgyy9f0Ae49aa2coz+hg5UHFrphj6s1b4tWRxw==
X-Received: by 10.99.99.71 with SMTP id x68mr6124473pgb.334.1509538552957;
        Wed, 01 Nov 2017 05:15:52 -0700 (PDT)
Received: from localhost (g183.61-45-92.ppp.wakwak.ne.jp. [61.45.92.183])
        by smtp.gmail.com with ESMTPSA id n72sm1244683pfi.92.2017.11.01.05.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Nov 2017 05:15:52 -0700 (PDT)
Date:   Wed, 1 Nov 2017 21:15:49 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Jan Henrik Weinstock <jan.weinstock@ice.rwth-aachen.de>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        openrisc@lists.librecores.org,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH v4 13/13] openrisc: add tick timer multi-core sync logic
Message-ID: <20171101121549.GG29237@lianli.shorne-pla.net>
References: <20171029231123.27281-1-shorne@gmail.com>
 <20171029231123.27281-14-shorne@gmail.com>
 <05333dd1-f8df-c96e-03df-1623ff67ab39@mips.com>
 <20171031231759.GB29237@lianli.shorne-pla.net>
 <20171101003447.GC29237@lianli.shorne-pla.net>
 <132de3e6-52b5-b5fe-8199-9da427a1baf4@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132de3e6-52b5-b5fe-8199-9da427a1baf4@mips.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <shorne@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shorne@gmail.com
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

On Wed, Nov 01, 2017 at 09:26:43AM +0000, Matt Redfearn wrote:
> 
> 
> On 01/11/17 00:34, Stafford Horne wrote:
> > On Wed, Nov 01, 2017 at 08:17:59AM +0900, Stafford Horne wrote:
> > > On Tue, Oct 31, 2017 at 02:06:21PM +0000, Matt Redfearn wrote:
> > > > Hi,
> > > > 
> > > > 
> > > > On 29/10/17 23:11, Stafford Horne wrote:
> > > > > In case timers are not in sync when cpus start (i.e. hot plug / offset
> > > > > resets) we need to synchronize the secondary cpus internal timer with
> > > > > the main cpu.  This is needed as in OpenRISC SMP there is only one
> > > > > clocksource registered which reads from the same ttcr register on each
> > > > > cpu.
> > > > > 
> > > > > This synchronization routine heavily borrows from mips implementation that
> > > > > does something similar.
> > > [..]
> > > > > diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
> > > > > index 4763b8b9161e..4d80ce6fa045 100644
> > > > > --- a/arch/openrisc/kernel/smp.c
> > > > > +++ b/arch/openrisc/kernel/smp.c
> > > > > @@ -100,6 +100,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
> > > > >    		pr_crit("CPU%u: failed to start\n", cpu);
> > > > >    		return -EIO;
> > > > >    	}
> > > > > +	synchronise_count_master(cpu);
> > > > >    	return 0;
> > > > >    }
> > > > > @@ -129,6 +130,8 @@ asmlinkage __init void secondary_start_kernel(void)
> > > > >    	set_cpu_online(cpu, true);
> > > > >    	complete(&cpu_running);
> > > > > +	synchronise_count_slave(cpu);
> > > > > +
> > > > 
> > > > Note that until 8f46cca1e6c06a058374816887059bcc017b382f, the MIPS timer
> > > > synchronization code contained the possibility of deadlock. If you mark a
> > > > CPU online before it goes into the synchronize loop, then the boot CPU can
> > > > schedule a different thread and send IPIs to all "online" CPUs. It gets
> > > > stuck waiting for the secondary to ack it's IPI, since this secondary CPU
> > > > has not enabled IRQs yet, and is stuck waiting for the master to synchronise
> > > > with it. The system then deadlocks.
> > > > Commit 8f46cca1e6c06a058374816887059bcc017b382f fixed this for MIPS and you
> > > > might want to similarly move the
> > > > 
> > > > set_cpu_online(cpu, true);
> > > > 
> > > > after counters are synchronized.
> > > Thank you for the heads up.  I do remember having interim issues with the timer
> > > syncing but I havent seen it for a while.  I think I fixed it by also moving
> > > synchronise_count_slave.
> > > 
> > > Let me double check.  Also, I see your patch 8f46cca1e6c06a0583748168 was merged
> > > last year?
> > Hello,
> > 
> > I should have read a bit more closely, definitely this could be an issue if the
> > boot cpu has other things running.
> > 
> > However, looking at mainline I can see the clock sync comes after set_cpu_online
> > again after this patch in mips.
> > 
> >    6f542ebeaee0 MIPS: Fix race on setting and getting cpu_online_mask
> >    Author: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
> > 
> > Is this deadlock an issue in mips again?
> > 
> > -Stafford
> 
> Hi Stafford,
> 
> Yes - the deadlock is an issue again, it was re-introduced by 6f542ebeaee0.
> That patch was based on testing with 4.4, where the core CPU hotplug code
> did not contain it's own completion event. Since commit 8df3e07e7f21f
> ("cpu/hotplug: Let upcoming cpu bring itself fully up"), which was added in
> 4.6, this is no longer the case and there is no race condition. I have
> https://patchwork.linux-mips.org/patch/17376/ pending which fixes this race
> in pre-4.6 stable kernels, and guards against the deadlock as well.
> Unfortunately because of the backport to stable this gets a little more
> complex.
> 
> Unless your patches to add SMP are going to be applied to pre-4.6 kernels,
> then you will not suffer the race condition. The potential deadlock is the
> only pitfall you need to guard against - which will be OK if you put the
> clock sync before marking the CPU online.
> 
> Thanks,
> Matt

Hi Matt,

Thanks for the details.  I will make the patch and test it out.

On a side note, I was thinking to pull the sync code out into asm-generic in
case any other architectures want to use it, it seems generic enough to work for
other architectures.  Any thoughts?

-Stafford
