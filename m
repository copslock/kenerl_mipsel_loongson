Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Mar 2010 00:24:37 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:58465 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492517Ab0CSXYd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Mar 2010 00:24:33 +0100
Received: by gyg10 with SMTP id 10so1822975gyg.36
        for <linux-mips@linux-mips.org>; Fri, 19 Mar 2010 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=n9HgQ/Q1wl9/cIMVFDMNNyP7wJhGBkdkjmlagsmOJ1o=;
        b=vVQ5ZYZVXBwZNqF9nbHBheAHIdO3U29W+QZZKabtGa6gm5taeNMYwYjeq5ZpQ7rzm4
         kDOv6sUgq+9SYro0WDLIhVh03HtBd/fCmttiYhUWZNpVEDDF6ydbVAG/kXzaJXjWUarZ
         xjIXwnmcmhDqZKhX2f040+aqoWvtJYCe8NeoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=wlqq23bzBYV7qtOMFDzentuJYxNQJo1qTOU40tC2fjvxhK22V+7nBiiLCbbpGv0S3g
         KHwpM/4x1YGlU8XHxso0/4Q2EL4nAZXAD/Z6Hf3/3NwA9+c9e/QW24cmvOrTrhPryBYn
         5i10pM3aWRlkoQ+G3jnRIHXo3LAUjYEOOMtrY=
Received: by 10.151.25.21 with SMTP id c21mr66845ybj.169.1269041065750;
        Fri, 19 Mar 2010 16:24:25 -0700 (PDT)
Received: from [10.0.0.92] (cpe-76-173-26-187.socal.res.rr.com [76.173.26.187])
        by mx.google.com with ESMTPS id 8sm500153yxg.67.2010.03.19.16.24.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 16:24:25 -0700 (PDT)
Message-ID: <4BA407AC.5030506@gmail.com>
Date:   Fri, 19 Mar 2010 16:24:28 -0700
From:   "Justin P. Mattock" <justinmattock@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091114 Lightning/1.0pre Thunderbird/3.0b4
MIME-Version: 1.0
To:     Randy Dunlap <rdunlap@xenotime.net>
CC:     trivial@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-audit@redhat.com, uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, selinux@tycho.nsa.gov,
        sparclinux@vger.kernel.org, x86@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Cosmetic:Partially remove deprecated __initcall() and
 change to
References: <1269028291-9103-1-git-send-email-justinmattock@gmail.com> <4BA40115.2000509@xenotime.net>
In-Reply-To: <4BA40115.2000509@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <justinmattock@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinmattock@gmail.com
Precedence: bulk
X-list: linux-mips

On 03/19/2010 03:56 PM, Randy Dunlap wrote:
> On 03/19/10 12:51, Justin P. Mattock wrote:
>> After doing some things on a small issue,
>> I noticed through web surfing, that there were patches
>> submitted pertaining that __initcall is deprecated,
>> and device_initcall should be used.
>
> Where was this discussion?  Do you have any pointers to it?
>

The best info on this is scripts/checkpatch.pl
line #2664

when I found this I just did a quick search of __initcall
(which gives hits here and there)
https://patchwork.kernel.org/patch/23344/
(also found others at around 2008 or so)

> I don't see any mention of __initcall being deprecated in
> Linus' mainline git tree, or in linux-next, or in mmotm.
> Where are those patches?
>

I don't know(I'm out of the social pipeline when it comes to Linux news, 
and updates)..
like in the explanation part of the patch
I was looking into something else, then ran into this,
so as a break(from what I was originally doing)
decided to do this and submit.

>
>> So as a change of subject(since what I was looking at
>> was frustrating me),I decided to grep the whole tree
>> and make the change(partially).
>>
>> Currently I'm running this patch on my system, kernel compiles
>> without any errors or warnings.(thought there would be a speed increase
>> but didn't see much(if any)).
>
> No, __initcall(x) is just a shorthand version of typing
> device_initcall(x).  They do the same thing.
>

yep, that's what I found out as well(reason for the cosmetic
in the subject line).

>> Biggest problem I have though is testing this on other hardware types
>> (I only have a macbook,and an iMac).
>> So please if you have the access to other arch/hardware types please
>> test.
>>
>> Now what I mean by partially is the __initcall function is still
>> there, so(if any) userspace apps/libs depend on this it's there
>> so they dont break and/or any other subsystem, that needs time
>> to make the changes.
>
> The only thing that might be affected is building out-of-tree drivers,
> but those are easy to fix.
>

alright..main concern is making sure things don't break in the 
kernel(even though things do).

I can have a go at the header files, submit
then if it's something people agree they want to do, then they
can go from there(if not it's fine as well).

>> Note:
>> the remaining files that still have __initcall in them are:
>> (according to grep)
>>
>> arch/um/include/shared/init.h
>> include/linux/init.h
>> scripts/checkpatch.pl
>>
>> either I or somebody else, can change this(although a bit
>> concerned about breaking things).
>>
>> Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>> ---
>>   Documentation/DocBook/kernel-hacking.tmpl    |    4 ++--
>>   Documentation/cpu-freq/cpu-drivers.txt       |    2 +-
>>   Documentation/kbuild/makefiles.txt           |    2 +-
>>   arch/arm/mach-at91/leds.c                    |    2 +-
>>   arch/arm/mach-clps711x/p720t.c               |    2 +-
>>   arch/arm/mach-ebsa110/leds.c                 |    2 +-
>>   arch/arm/mach-footbridge/cats-hw.c           |    2 +-
>>   arch/arm/mach-footbridge/ebsa285-leds.c      |    2 +-
>>   arch/arm/mach-footbridge/netwinder-hw.c      |    2 +-
>>   arch/arm/mach-footbridge/netwinder-leds.c    |    2 +-
>>   arch/arm/mach-ks8695/leds.c                  |    2 +-
>>   arch/arm/mach-omap1/leds.c                   |    2 +-
>>   arch/arm/mach-omap1/pm.c                     |    2 +-
>>   arch/arm/mach-orion5x/db88f5281-setup.c      |    2 +-
>>   arch/arm/mach-orion5x/rd88f5182-setup.c      |    2 +-
>>   arch/arm/mach-pxa/generic.c                  |    2 +-
>>   arch/arm/mach-pxa/pxa25x.c                   |    2 +-
>>   arch/arm/mach-shark/leds.c                   |    2 +-
>>   arch/blackfin/kernel/bfin_gpio.c             |    2 +-
>>   arch/blackfin/mach-common/pm.c               |    2 +-
>>   arch/cris/arch-v10/kernel/debugport.c        |    2 +-
>>   arch/cris/arch-v10/kernel/fasttimer.c        |    2 +-
>>   arch/cris/arch-v10/mm/init.c                 |    2 +-
>>   arch/cris/arch-v32/kernel/fasttimer.c        |    2 +-
>>   arch/cris/arch-v32/kernel/pinmux.c           |    2 +-
>>   arch/cris/arch-v32/kernel/signal.c           |    2 +-
>>   arch/cris/arch-v32/mach-a3/io.c              |    2 +-
>>   arch/cris/arch-v32/mach-a3/pinmux.c          |    2 +-
>>   arch/cris/arch-v32/mach-fs/io.c              |    2 +-
>>   arch/cris/arch-v32/mach-fs/pinmux.c          |    2 +-
>>   arch/cris/kernel/profile.c                   |    2 +-
>>   arch/cris/kernel/time.c                      |    2 +-
>>   arch/cris/kernel/traps.c                     |    2 +-
>>   arch/frv/kernel/gdb-stub.c                   |    2 +-
>>   arch/frv/kernel/pm-mb93093.c                 |    2 +-
>>   arch/frv/kernel/pm.c                         |    2 +-
>>   arch/frv/kernel/sysctl.c                     |    2 +-
>>   arch/h8300/kernel/gpio.c                     |    2 +-
>>   arch/ia64/hp/sim/simeth.c                    |    2 +-
>>   arch/ia64/hp/sim/simserial.c                 |    2 +-
>>   arch/ia64/kernel/audit.c                     |    2 +-
>>   arch/ia64/kernel/crash.c                     |    2 +-
>>   arch/ia64/kernel/cyclone.c                   |    2 +-
>>   arch/ia64/kernel/perfmon.c                   |    2 +-
>>   arch/ia64/kernel/setup.c                     |    2 +-
>>   arch/ia64/kernel/uncached.c                  |    2 +-
>>   arch/ia64/kernel/unwind.c                    |    2 +-
>>   arch/ia64/mm/init.c                          |    2 +-
>>   arch/mips/Makefile                           |    2 +-
>>   arch/mips/kernel/unaligned.c                 |    2 +-
>>   arch/mips/lasat/sysctl.c                     |    2 +-
>>   arch/mips/math-emu/cp1emu.c                  |    2 +-
>>   arch/mips/nxp/pnx8550/common/proc.c          |    2 +-
>>   arch/mips/sibyte/sb1250/bus_watcher.c        |    2 +-
>>   arch/mn10300/kernel/gdb-stub.c               |    2 +-
>>   arch/mn10300/kernel/mn10300-serial.c         |    2 +-
>>   arch/mn10300/kernel/profile.c                |    2 +-
>>   arch/parisc/kernel/pci-dma.c                 |    2 +-
>>   arch/parisc/kernel/pdc_chassis.c             |    2 +-
>>   arch/powerpc/kernel/audit.c                  |    2 +-
>>   arch/powerpc/kernel/idle.c                   |    2 +-
>>   arch/powerpc/kernel/irq.c                    |    2 +-
>>   arch/powerpc/kernel/proc_powerpc.c           |    2 +-
>>   arch/powerpc/kernel/prom.c                   |    4 ++--
>>   arch/powerpc/kernel/rtas-proc.c              |    2 +-
>>   arch/powerpc/kernel/rtasd.c                  |    2 +-
>>   arch/powerpc/kernel/sysfs.c                  |    2 +-
>>   arch/powerpc/kernel/tau_6xx.c                |    2 +-
>>   arch/powerpc/kernel/vio.c                    |    2 +-
>>   arch/powerpc/platforms/iseries/lpevents.c    |    2 +-
>>   arch/powerpc/platforms/iseries/mf.c          |    2 +-
>>   arch/powerpc/platforms/iseries/proc.c        |    2 +-
>>   arch/powerpc/platforms/iseries/viopath.c     |    2 +-
>>   arch/powerpc/platforms/pseries/eeh.c         |    2 +-
>>   arch/powerpc/platforms/pseries/hvCall_inst.c |    2 +-
>>   arch/powerpc/platforms/pseries/power.c       |    2 +-
>>   arch/powerpc/platforms/pseries/ras.c         |    2 +-
>>   arch/powerpc/platforms/pseries/reconfig.c    |    2 +-
>>   arch/powerpc/xmon/xmon.c                     |    2 +-
>>   arch/s390/appldata/appldata_base.c           |    2 +-
>>   arch/s390/kernel/audit.c                     |    2 +-
>>   arch/s390/kernel/compat_exec_domain.c        |    2 +-
>>   arch/s390/kernel/ipl.c                       |    2 +-
>>   arch/s390/kernel/topology.c                  |    2 +-
>>   arch/sh/boards/board-edosk7760.c             |    2 +-
>>   arch/sh/boards/board-sh7785lcr.c             |    2 +-
>>   arch/sh/boards/mach-cayman/setup.c           |    2 +-
>>   arch/sh/boards/mach-landisk/setup.c          |    2 +-
>>   arch/sh/boards/mach-r2d/setup.c              |    2 +-
>>   arch/sh/boards/mach-sdk7786/setup.c          |    2 +-
>>   arch/sh/boards/mach-se/7206/setup.c          |    2 +-
>>   arch/sh/boards/mach-se/7751/setup.c          |    2 +-
>>   arch/sh/boards/mach-sh03/setup.c             |    2 +-
>>   arch/sh/kernel/traps_64.c                    |    2 +-
>>   arch/sparc/kernel/apc.c                      |    2 +-
>>   arch/sparc/kernel/audit.c                    |    2 +-
>>   arch/sparc/kernel/mdesc.c                    |    2 +-
>>   arch/sparc/kernel/pmc.c                      |    2 +-
>>   arch/um/drivers/mconsole_kern.c              |    8 ++++----
>>   arch/um/drivers/net_kern.c                   |    2 +-
>>   arch/um/drivers/stderr_console.c             |    2 +-
>>   arch/um/drivers/ubd_kern.c                   |    4 ++--
>>   arch/um/kernel/exitcode.c                    |    2 +-
>>   arch/um/kernel/physmem.c                     |    2 +-
>>   arch/um/os-Linux/aio.c                       |    4 ++--
>>   arch/um/os-Linux/skas/mem.c                  |    2 +-
>>   arch/um/os-Linux/skas/process.c              |    2 +-
>>   arch/um/os-Linux/umid.c                      |    2 +-
>>   arch/um/sys-i386/tls.c                       |    2 +-
>>   arch/x86/kernel/audit_64.c                   |    2 +-
>>   arch/x86/kernel/tlb_uv.c                     |    4 ++--
>>   arch/x86/kernel/vsyscall_64.c                |    4 ++--
>>   arch/x86/mm/dump_pagetables.c                |    2 +-
>>   arch/x86/vdso/vdso32-setup.c                 |    4 ++--
>>   arch/x86/vdso/vma.c                          |    2 +-
>>   arch/xtensa/platforms/iss/console.c          |    2 +-
>>   drivers/net/arm/am79c961a.c                  |    2 +-
>>   drivers/net/hamradio/baycom_epp.c            |    1 +
>>   drivers/net/hamradio/baycom_par.c            |    1 +
>>   drivers/net/hamradio/baycom_ser_fdx.c        |    1 +
>>   drivers/net/hamradio/baycom_ser_hdx.c        |    1 +
>>   drivers/s390/char/sclp_cmd.c                 |    2 +-
>>   drivers/s390/char/sclp_config.c              |    2 +-
>>   drivers/s390/char/sclp_cpi_sys.c             |    2 +-
>>   drivers/s390/char/sclp_vt220.c               |    2 +-
>>   drivers/s390/cio/blacklist.c                 |    2 +-
>>   drivers/staging/rtl8192u/ieee80211/api.c     |    2 +-
>>   fs/aio.c                                     |    2 +-
>>   fs/compat_ioctl.c                            |    2 +-
>>   ipc/ipc_sysctl.c                             |    2 +-
>>   ipc/mqueue.c                                 |    2 +-
>>   ipc/util.c                                   |    2 +-
>>   kernel/audit.c                               |    2 +-
>>   kernel/audit_tree.c                          |    2 +-
>>   kernel/dma.c                                 |    2 +-
>>   kernel/futex.c                               |    2 +-
>>   kernel/lockdep_proc.c                        |    2 +-
>>   kernel/pid_namespace.c                       |    2 +-
>>   kernel/posix-cpu-timers.c                    |    2 +-
>>   kernel/posix-timers.c                        |    2 +-
>>   kernel/resource.c                            |    2 +-
>>   kernel/sched_debug.c                         |    2 +-
>>   kernel/time/timer_list.c                     |    2 +-
>>   kernel/time/timer_stats.c                    |    2 +-
>>   kernel/tracepoint.c                          |    2 +-
>>   kernel/utsname_sysctl.c                      |    2 +-
>>   lib/audit.c                                  |    2 +-
>>   lib/debugobjects.c                           |    2 +-
>>   mm/bounce.c                                  |    2 +-
>>   mm/memory.c                                  |    2 +-
>>   mm/mm_init.c                                 |    2 +-
>>   mm/slab.c                                    |    2 +-
>>   mm/slub.c                                    |    2 +-
>>   mm/swapfile.c                                |    2 +-
>>   net/ipv4/syncookies.c                        |    2 +-
>>   net/ipv4/sysctl_net_ipv4.c                   |    2 +-
>>   security/keys/proc.c                         |    2 +-
>>   security/selinux/hooks.c                     |    2 +-
>>   security/selinux/netif.c                     |    2 +-
>>   security/selinux/netlink.c                   |    2 +-
>>   security/selinux/netnode.c                   |    2 +-
>>   security/selinux/netport.c                   |    2 +-
>>   security/selinux/selinuxfs.c                 |    2 +-
>>   security/selinux/ss/services.c               |    2 +-
>>   security/smack/smackfs.c                     |    2 +-
>>   sound/last.c                                 |    2 +-
>>   166 files changed, 176 insertions(+), 172 deletions(-)
>
>
