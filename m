Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2017 22:53:16 +0100 (CET)
Received: from resqmta-po-06v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:165]:52020
        "EHLO resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993888AbdCUVxJx0StC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Mar 2017 22:53:09 +0100
Received: from resomta-po-14v.sys.comcast.net ([96.114.154.238])
        by resqmta-po-06v.sys.comcast.net with SMTP
        id qRiFcE2RlbempqRiFcUYQK; Tue, 21 Mar 2017 21:53:07 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-po-14v.sys.comcast.net with SMTP
        id qRiDcVFErWGiLqRiEcAR1o; Tue, 21 Mar 2017 21:53:07 +0000
Subject: Re: ARCS can't load CONFIG_DEBUG_LOCK_ALLOC kernel
To:     Ralf Baechle <ralf@linux-mips.org>
References: <8b2d7473-ba4d-f2c9-27e7-b1a30b95c4f8@gentoo.org>
 <a639551b-4338-e1fb-0cc7-e6ea34b94c2c@gentoo.org>
 <20170316140918.GH5512@linux-mips.org>
 <86da6dd2-7b02-cd0d-f152-00dfb134a3ec@gentoo.org>
 <20170316190629.GP5512@linux-mips.org>
 <13b0221d-c17a-7e5b-6bb5-702ee7d896c1@gentoo.org>
 <20170316205006.GE10914@linux-mips.org>
 <c969ac8f-2915-6d9c-cc59-0da77199b3a1@gentoo.org>
 <23538ffb-4ab5-22b5-d740-fbe5fadf8aa0@gentoo.org>
 <680b861f-c60f-441a-53ff-f79edb0ce044@gentoo.org>
 <20170319085504.GB14919@linux-mips.org>
Cc:     linux-mips@linux-mips.org
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <97850099-78b2-fd59-319c-4f514bb64560@gentoo.org>
Date:   Tue, 21 Mar 2017 17:52:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170319085504.GB14919@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOiHiokAB3iIj9cG09QBFFaXq0DX2eYLBrG5W1SGEYS8H8BDHqA76/PoVJyWVWi7P4pXfzYh5e4PXTSBagMHxJteHFxV0xoAXibMbDN8fESeYVB+yDMW
 ROObXDYnhDsPuakTBZXFJYLAa+K5aMMGCGUbLlv2u1rl/ZBGC4ABl8yrgp+qBZvEERn8ZBGiOqZtV5hvRQ1TFdJjn7UZIshu6dk=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 03/19/2017 04:55, Ralf Baechle wrote:
> On Sun, Mar 19, 2017 at 03:23:39AM -0400, Joshua Kinard wrote:
> 
>> The closest I've gotten to extracting info on the state of the machine is to
>> set the MSC debug switches to 0x1018 and then issue an immediate reset to have
>> it drop into POD dirty-exclusive as soon as possible.  Then running "why"
>> sometimes nets me a valid kernel address in EPC that tells me where the POD CPU
>> was last at.  Downside, I have four CPUs and MSC POD locks up if I try
>> switching to any of the other CPUs.  So I can't get a register dump off of the
>> other three.
> 
> Have you tried to send an NMI fro the MSC?  The PoD debugger is actually
> a fairly handy tool in such cases.

Oddly enough, sending NMI's from POD lets me switch CPUs to execute "why"
off of.  The POD "cpu" command doesn't appear to work right.  It'll just
lock up that console instead.  This allows me to grab the address in EPC
from all four CPUs after a lock up and that's how I've been doing my
debugging all weekend.


>> 2A 000: Done initializing klconfig.
>> 2A 000: Discovering NUMAlink connectivity .........             DONE
>> 2A 000: Found 2 objects (2 hubs, 0 routers) in 511413 usec
>> 1B 000: Testing/Initializing memory ...............             DONE
>> 2A 000: Waiting for peers to complete discovery....             Reading link 0
>> (addr 0x92000000
>> 2A 000: 00000004) failed
>> 1B 000: CPU B switching to UALIAS
>> 1B 000: CPU B now running out of UALIAS
>> 2A 000: Reading link 0 (addr 0x9200000000000004) failed
>> 1B 000: Skipping secondary cache diags
>> 1B 000: CPU B switching stack into UALIAS and invalidating D-cache
>> 1B 000: CPU B switching into node 0 cached RAM
>> 1B 000: CPU B running cached
>> 2A 000: Reading link 0 (addr 0x9200000000000004) failed
>> 2A 000: Reading link 0 (addr 0x9200000000000004) failed
> 
> I thought that kind of messages was indicating a hardware issue.

As far as I can tell, it doesn't appear to be.  A cold boot usually
resolves this issue.  It happens randomly, and not at all on Sunday.


>> Then it gets a general exception and drops to POD Dex:
>> 1B 000: Local Slave : Waiting for my NASID ...
>> 1B 000: CPU B switching to UALIAS
>> 1B 000: CPU B running in UALIAS
>> 1B 000: CPU B Flushing and invalidating caches
>> 1B 000: CPU B switching to node 0 cached RAM
>> 1B 000: CPU B running cached
>> 1A 000:
>> 1A 000: *** General Exception on node 0
>> 1A 000: *** EPC: 0xc00000001fc473dc (0xc00000001fc473dc)
>> 1A 000: *** Press ENTER to continue.
>> 1A 000: POD MSC Dex>
>>
>> If this is a hardware lock up, that might explain why kgdb isn't useful at that
>> point.  POD lets me dump the CRBs and PI error spool, but I'm not sure how
>> useful that information is w/o SGI's internal documents.
> 
> I still haven't forgotten everything (I hope) so maybe you could post that
> information anyway just to use the small chance there ight be something
> useful in there?

I hope you haven't forgotten everything.  How many people left actually
still care about about these platforms? :)

That said, CRBs didn't contain anything useful.  All initialized to zero,
except CRB D, which only held 0x00000000000000ff in all 15 of its
registers.

So that said, here's what I spent all of Sunday and a little of Monday
night doing:

1. Boot into userland, allow md to finish any resyncs, delete the dummy
file "FOO" being created, sync

2. Re-run this dd command:
dd if=/dev/urandom of=/usr/space/bonnie++/FOO bs=1M count=24000 status=progress

If that command actually completes, it takes about ~35-40mins.  In a couple
of instances, it actually finished, but in most instances, the system would
lock up anywhere from 5 seconds after launching to 25mins later.  I even
made a video capture of my two serial windows and ssh console when the
system locks up that I can put onto Youtube if interested.

Once the system locked up, I:

1. Switched to the MSC.
2. Set debug bits 0x1018 to force POD Dex mode.
3. Reset the system.
4. Run "why" on the first CPU to come up and record the value of EPC.
5. Issue an NMI to the other CPU on that node to force it into POD
6. Run "why" and record the value of EPC.
7. Switch to IOC3 console.
8. Issue an NMI to the other node to force it into POD on MSC.
9. Run "why" and record EPC.
10. Repeat for last CPU.
11. Clear debug bits, reset system, repeat all over again.

I don't know why issuing the NMI's works to switch the active CPU in POD
around.  POD's own "cpu" command just locks the console up when you try to
switch CPUs.  Not sure if it's a bug in the POD software I have in my PROM
image (which is 6.156, the latest SGI made AFAIK).

I've also determined that EPC is the only register that's reliable to hold
data left over from the lockup.  The PROM scrambles the remaining
registers.  I verified this by periodically recompiling my kernel with
different options or a different compiler version to make sure the function
addresses were different, and EPC would still point at the addresses of
very specific functions when the system locked up.

Using the EPC values, I looked those up in GDB for each cycle and kept a
listing of where all four CPUs were last at when the machine stopped.  
Going by that, I've compiled a non-exhaustive list of the most common
functions, one or more of which might be where the underlying problem is
at:

mem_serial_in (./arch/mips/include/asm/io.h:428)
ioc3_mdio_read (drivers/net/ethernet/sgi/ioc3-eth.c:478)
arch_local_irq_save (arch/mips/lib/mips-atomic.c:66)
arch_local_irq_restore (arch/mips/lib/mips-atomic.c:109)
do_idle (kernel/sched/idle.c:154)
hub_rt_read (arch/mips/sgi-ip27/ip27-timer.c:145)
spin_dump (kernel/locking/spinlock_debug.c:58)

The ones that stand out the most to me are arch_local_irq_restore and
spin_dump.  This is what GDB said about spin_dump:

(gdb) l *0xa800000000096ba0
0xa800000000096ba0 is in spin_dump (kernel/locking/spinlock_debug.c:56).
51
52      static void spin_dump(raw_spinlock_t *lock, const char *msg)
53      {
54              struct task_struct *owner = NULL;
55
56              if (lock->owner && lock->owner != SPINLOCK_OWNER_INIT)
57                      owner = lock->owner;
58              printk(KERN_EMERG "BUG: spinlock %s on CPU#%d, %s/%d\n",
59                      msg, raw_smp_processor_id(),
60                      current->comm, task_pid_nr(current));

Which tells me the system was about to report a spinlock lockup somewhere
before it halted.  I tried setting a kgdb breakpoint on line 56, but the
machine is halting before it can actually execute the breakpoint, as in
one of my runs, one of the CPUs was literally in the middle of executing
"nmi_handler" from genex.S, and I only saw this when I had an active
breakpoint set.

So I think my suspicion of this being a spinlock lockup is on the right
path, and it's grave enough that it halts the entire machine.  Problem is,
we're locking up so fast that existing kernel infrastructure can't report
//what// spinlock is the one deadlocking.  I can't rely on leftover data
in the CPU's own registers, and I don't know if it's possible to dump
kernel memory from POD mode in a way that can be decoded into something
useful to trace down what happened.

---

The other standout function is arch_local_irq_restore.  This is what that
looks like in GDB:

0xa800000000325148 is in arch_local_irq_restore (arch/mips/lib/mips-atomic.c:109).
104             "       .set    pop                                             \n"
105             : [flags] "=r" (__tmp1)
106             : "0" (flags)
107             : "memory");
108
109             preempt_enable();
110     }
111     EXPORT_SYMBOL(arch_local_irq_restore);
112
113     #endif /* !CONFIG_CPU_MIPSR2 && !CONFIG_CPU_MIPSR6 */

Or the asm dump:
a800000000325130 <arch_local_irq_restore>:
a800000000325130:       40016000        mfc0    at,$12
a800000000325134:       30840001        andi    a0,a0,0x1
a800000000325138:       3421001f        ori     at,at,0x1f
a80000000032513c:       3821001f        xori    at,at,0x1f
a800000000325140:       00812025        or      a0,a0,at
a800000000325144:       40846000        mtc0    a0,$12
a800000000325148:       03e00008        jr      ra
a80000000032514c:       00000000        nop

Each time the machine has locked up and EPC points at
arch_local_irq_restore, it's always been on the address of that "ja"
instruction, regardless of which CPU I got that EPC value off of.  But I
don't know if that instruction is responsible for the lock up (I doubt it).

I am also noticing that sometimes when a lockup happens, one or more of the
other CPUs is in the middle of a read[bwlq]/write[bwlq] operation.  In a
test I just ran before writing this e-mail, two of the CPUs were in the
middle of read/write tasks (this is from a kernel with my patchset on top,
so this function is from the IOC3 metadriver, but the same problem has been
seen in mem_serial_in from a vanilla lmo git tree):

CPU 2B:
0xa8000000003a6138 is in ioc3_serial_in (./arch/mips/include/asm/io.h:428).
423                                                                             \
424     __BUILD_MEMORY_PFX(__raw_, bwlq, type)                                  \
425     __BUILD_MEMORY_PFX(, bwlq, type)                                        \
426     __BUILD_MEMORY_PFX(__mem_, bwlq, type)                                  \
427
428     BUILDIO_MEM(b, u8)
429     BUILDIO_MEM(w, u16)
430     BUILDIO_MEM(l, u32)
431     BUILDIO_MEM(q, u64)
432

a8000000003a6120 <ioc3_serial_in>:
a8000000003a6120:       908200b1        lbu     v0,177(a0)
a8000000003a6124:       dc830020        ld      v1,32(a0)
a8000000003a6128:       00452804        sllv    a1,a1,v0
a8000000003a612c:       38a50003        xori    a1,a1,0x3
a8000000003a6130:       0065282d        daddu   a1,v1,a1
a8000000003a6134:       38a50003        xori    a1,a1,0x3
a8000000003a6138:       90a20000        lbu     v0,0(a1)
a8000000003a613c:       03e00008        jr      ra
a8000000003a6140:       304200ff        andi    v0,v0,0xff
a8000000003a6144:       00000000        nop


CPU 2A:
0xa8000000003e6410 is in qla1280_queuecommand (./arch/mips/include/asm/io.h:429).
424     __BUILD_MEMORY_PFX(__raw_, bwlq, type)                                  \
425     __BUILD_MEMORY_PFX(, bwlq, type)                                        \
426     __BUILD_MEMORY_PFX(__mem_, bwlq, type)                                  \
427
428     BUILDIO_MEM(b, u8)
429     BUILDIO_MEM(w, u16)
430     BUILDIO_MEM(l, u32)
431     BUILDIO_MEM(q, u64)
432
433     #define __BUILD_IOPORT_PFX(bus, bwlq, type)                             \

a8000000003e6360 <qla1280_queuecommand>:
a8000000003e6360:       67bdff90        daddiu  sp,sp,-112
a8000000003e6364:       ffbf0068        sd      ra,104(sp)
...
a8000000003e6404:       97c41728        lhu     a0,5928(s8)
a8000000003e6408:       64630078        daddiu  v1,v1,120
a8000000003e640c:       38630002        xori    v1,v1,0x2
a8000000003e6410:       94650000        lhu     a1,0(v1)
a8000000003e6414:       30a5ffff        andi    a1,a1,0xffff
a8000000003e6418:       0085182a        slt     v1,a0,a1
a8000000003e641c:       14600002        bnez    v1,a8000000003e6428 <qla1280_queuecommand+0xc8>

---

I've also tried dumping the HUB error state after reset by setting the debug bits to 0x1000, and that says this:

Erecting partition fences ................                        DONE
nasid 0 Reading peer hub nasid: 0x9200000021600000
xbow_update: updating slave nasid 1 on link 10
Update config for routers connected to hubs
Update config for hubs and hubless routers
CPU A flushing cache
 Hardware Error State at System Reset
 +  Errors on node Nasid 0x0 (0)
 +    IP27 in /hw/module/1/slot/n2
 +      HUB signalled following errors.
 +        HUB error interrupt register: 0x200000
 +          21: CPU A received uncorrectable error during uncached load
 End Hardware Error State (at System Reset)

But I'm not 100% sure I can trust that, since I believe I've seen it after
a clean reboot from userland as well.  Both vanilla lmo git and my patched
tree throw a panic if the kernel gets a HUB error interrupt.  I have
noticed that sometimes, when the system panics, it can halt the machine
before any panic info can be written out to the console.  But given
multiple runs, there's still a chance one of the panics will output
something.  Given the number of times I've crashed this machine lately, by
now, I should have gotten *something* out of it.  So I am discounting it
being a HUB error interrupt locking things up.  Just to be sure, I replaced
the panic() call with a basic printk(), and still didn't get any output on
the console.

I'll also have to enable the heavy diagnostics mode and let the machine
check itself, and maybe run bist from POD to be really sure it's not a
hardware issue.  I've got spare node boards in a closest that I can swap
the CPU PIMMS on if I suspect something's wrong with one of the HUBs.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens
us.  And our lives slip away, moment by moment, lost in that vast,
terrible in-between."

--Emperor Turhan, Centauri Republic
