Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Feb 2011 14:20:09 +0100 (CET)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:43452 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab1BRNUG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Feb 2011 14:20:06 +0100
Received: by qwj9 with SMTP id 9so3193391qwj.36
        for <linux-mips@linux-mips.org>; Fri, 18 Feb 2011 05:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=DT/reja8bgdkEnNAI76RNRcho/X4/K2zAvnnbs4YD6c=;
        b=epEpxscqFJwu9KKkVBXYZTIMzQ/ZRWXyajWTKZOo8kGSnzwL6AKI7i/RVb2zEdxy87
         4gZJskfuv24R6Twd7CF7g+AwcvKerKm7NEEK6uiF1XjcgFYnOCNVbLJxyvgpm9+3X2hg
         bHaX7sDYTQ0opsbAe1qDq09UsC+x+bbNSZuRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=BcplEk/n6ZwHLZzvSY6yozEZJ7t0D397X6bvqp/0A83dIOKRv1W3Vc/49xv/xRqGOv
         XnXCllEiikoBJogo0GehqWPH3wLN3i/VM8o2WJqZRZaS1hlfYfXsezGOwyWgVvOIg0Ex
         IcBUjmoPS6Q4uQEz6L85Ltbqgs12r72Y8xK8Y=
Received: by 10.229.91.145 with SMTP id n17mr501884qcm.258.1298035198542;
        Fri, 18 Feb 2011 05:19:58 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id nb15sm1529657qcb.38.2011.02.18.05.19.54
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 05:19:56 -0800 (PST)
Subject: Re: some questions about kernel source
From:   Anoop P A <anoop.pa@gmail.com>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
In-Reply-To: <AANLkTik9OJjgUThRW2tUvQy=pDNz58twJC7psASgu5CK@mail.gmail.com>
References: <AANLkTin_CMzhGmCMKfg+FMkKQue=XzwuEOZkLDMLE_to@mail.gmail.com>
         <220544EE49E5824C9DE242B5ACE58C3041639ACA@EMBX01-BNG.jnpr.net>
         <AANLkTinoCrk0Jfo_vD7qrtenSEHbY_c=foGePLcx-oe-@mail.gmail.com>
         <AANLkTikxjRtJ9igCh75yVcAHnWqFts2FbMbK+7dOBf7B@mail.gmail.com>
         <AANLkTinjCAQAn00Jwn-Nbu_thr-E4fcTW-tgqKo19c_j@mail.gmail.com>
         <AANLkTik9OJjgUThRW2tUvQy=pDNz58twJC7psASgu5CK@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 18 Feb 2011 19:12:08 +0530
Message-ID: <1298036528.9950.11.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2011-02-18 at 15:12 +0800, loody wrote:
> Hi all:
> 
> 2011/2/18 John Mahoney <jmahoney@waav.com>:
> > On Thu, Feb 17, 2011 at 9:17 AM, loody <miloody@gmail.com> wrote:
> >> hi :-)
> >>
> >> 2011/2/16 Mulyadi Santosa <mulyadi.santosa@gmail.com>:
> >>> Hi :)
> >>>
> >>> On Wed, Feb 16, 2011 at 12:59, Rajat Jain <rajatjain@juniper.net> wrote:
> >>>> Hello loody,
> >>>>
> >>>>> 1. in kernel/trace, I always see "__read_mostly" at the end of
> >>>>> parameter is that a compiler optimization parameter?
> >>>>
> >>>> Yes, it is a hint to the compiler that the parameter is mostly read, thus if the compiler has to make a decision between optimizing one of the read / write paths, it will optimize the read path even at the expense of write path.
> >>>
> >>>
> >>> To be precise, they will be grouped into same cache line as much as
> >>> possible. By doing so, those cache line won't be invalidated so often
> >>> (keeping them "hot" :) hehehhe )
> >>
> >> I cannot find it on the gcc manual.
> >> is it a option in kernel for kernel usage?
> >> if so, where I can found them.
> >> If not, can I use it on normal user level program?
> >>
> >
> > It is a macro defined for x86 as:
> >
> > #define __read_mostly __attribute__((__section__(".data..read_mostly")))
> I try to find "__read_mostly" of mips arch and below are the results I
> grep on arch/
> 
> ......
> ia64/xen/hypervisor.c:29:struct shared_info *HYPERVISOR_shared_info
> __read_mostly =
> mips/kernel/irq_txx9.c:58:static struct txx9_irc_reg __iomem
> *txx9_ircptr __read_mostly;
> mips/kernel/irq_txx9.c:63:} txx9irq[TXx9_MAX_IR] __read_mostly;
> mips/kernel/setup.c:35:struct cpuinfo_mips cpu_data[NR_CPUS] __read_mostly;
> mips/kernel/setup.c:55:unsigned long mips_machtype __read_mostly = MACH_UNKNOWN;
> mips/kernel/setup.c:72:const unsigned long mips_io_port_base __read_mostly = -1;
> mips/kernel/smp.c:58:cpumask_t cpu_sibling_map[NR_CPUS] __read_mostly;
> mips/kernel/process.c:329:static struct mips_frame_info schedule_mfi
> __read_mostly;
> mips/txx9/generic/irq_tx4939.c:50:} tx4939irq[TX4939_NUM_IR] __read_mostly;
> mips/mm/c-r4k.c:67:static unsigned long icache_size __read_mostly;
> mips/mm/c-r4k.c:68:static unsigned long dcache_size __read_mostly;
> mips/mm/c-r4k.c:69:static unsigned long scache_size __read_mostly;
> parisc/mm/init.c:543:unsigned long *empty_zero_page __read_mostly;
> parisc/include/asm/cache.h:31:#define __read_mostly
> __attribute__((__section__(".data.read_mostly")))
> .....
> x86/vdso/vdso32-setup.c:57:unsigned int __read_mostly vdso_enabled =
> VDSO_DEFAULT;
> x86/include/asm/cache.h:10:#define __read_mostly
> __attribute__((__section__(".data.read_mostly")))
> 
> 
> Does Mips arch not use this option?

arch/mips/include/asm/cache.h:#define __read_mostly
__attribute__((__section__(".data.read_mostly")))
