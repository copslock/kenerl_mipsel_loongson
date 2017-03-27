Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2017 23:30:36 +0200 (CEST)
Received: from resqmta-ch2-07v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:39]:35038
        "EHLO resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993201AbdC0Va3YhItS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Mar 2017 23:30:29 +0200
Received: from resomta-ch2-06v.sys.comcast.net ([69.252.207.102])
        by resqmta-ch2-07v.sys.comcast.net with SMTP
        id scDUc2DSLU9z5scDbcy7bI; Mon, 27 Mar 2017 21:30:27 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-06v.sys.comcast.net with SMTP
        id scDace5XieyvGscDac50Li; Mon, 27 Mar 2017 21:30:27 +0000
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: IP27 lock up issue, maybe timer related?
Message-ID: <541cc7d0-c819-8d1a-a400-2d485351e74c@gentoo.org>
Date:   Mon, 27 Mar 2017 17:30:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC5cI7pRjPqNfPDC51YeDNyCuFONMpHwBnyaDZxPMGuPR5++puYj6vVZRJanvasIdnYj423MGjZsCdbu7erTgG0SYDS6MjId32puXEoDHfgR4nspW4ot
 6oXmje7rIdcad0lmcyMKSUHWNLx3OTDYFClaAi9HE5NTVDBp7aROyJW8VqoGsIORRzyA1pH/4nbPZcGWOApd2FS/pxBpN8MRFBg=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57454
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

Some more digging I did over the weekend on the IP27 lock up issue led to some
new observations.

First off, I ended up changing the IRIX-style HUB_S/HUB_L macros to use
__raw_readq/__raw_writeq, since I know those versions disable local interrupts,
and was running out of ideas to try.  That appears to have cleaned up the
register state when I crash the machine and I appear to get usable data out of
several registers now (but I have to send an NMI to the CPU first, so it's some
neat hardware trick).

This leads to only one CPU appearing to be affected either by a data bus error
or getting "stuck".  Stuck meaning, in a few instances, three CPUs were last in
an idle loop and one was at the bottom of arch_local_irq_restore from
arch/mips/lib/mips-atomic.c.  In other instances, two or more CPUs were stuck
in arch_local_irq_restore.

In the stuck case, a constant theme I keep noticing is one of the register
values holds the address 0x9200000001030100, which is PI_RT_COUNT in I/O space
(Hub's realtime counter) on node 1.  It looks like some kind of clash where a
previous timer interrupt is leaving behind stale data in the registers, and the
resumed state of the CPU tries to use that data and halts.  E.g., in one crash
using a mainline kernel with minor patching to make it work, this is the POD
"why" and register dump off CPU 2A and 2B (node 1, or 2nd node board):

2A 000: POD MSC Dex> why
2A 000:  EPC    : 0xa800000000326fa8 (0xa800000000326fa8)
2A 000:  ERREPC : 0xc00000001fc5ad5c (0xc00000001fc5ad5c)
2A 000:  CACERR : 0x0000000000012108
2A 000:  Status : 0x0000000024407c80
2A 000:  BadVA  : 0xc0000000009c55c8 (0xc0000000009c55c8)
2A 000:  RA     : 0xc00000001fc13500 (0xc00000001fc13500)
2A 000:  SP     : 0xa800000000103650
2A 000:  A0     : 0x0000000024400080
2A 000:  Cause  : 0x0000000000008000 (INT:8-------)
2A 000:  Reason : 249 (NMI while executing in PROM.)
2A 000:  POD mode was called from: 0xc00000001fc02508 (0xc00000001fc02508)

2A 000: POD MSC Dex> pr
2A 000: r00/r0: 0x0000000000000000    r01/at: 0x0000000000000000
2A 000: r02/v0: 0x0000000000000000    r03/v1: 0x0000000000000001
2A 000: r04/a0: 0x0000000024400080    r05/a1: 0xffff920000000103
2A 000: r06/a2: 0x000000000000000a    r07/a3: 0x0000000000000000
2A 000: r08/a4: 0x0000000000000000    r09/a5: 0x0000000000000020
2A 000: r10/a6: 0xa8000000001036e0    r11/a7: 0x0000000000000000
2A 000: r12/t0: 0x000000000000002a    r13/t1: 0x000000000000004c
2A 000: r14/t2: 0x0000000000000068    r15/t3: 0x00000140a4436020
2A 000: r16/s0: 0x0000000000dd7210    r17/s1: 0x000000000000008c
2A 000: r18/s2: 0xffffffffffffffff    r19/s3: 0xc00000001fc74d70
2A 000: r20/s4: 0x00000000000f4240    r21/s5: 0xa800000000103a0f
2A 000: r22/s6: 0x0000000000000000    r23/s7: 0x00000000000000fc
2A 000: r24/t8: 0x0000000000000001    r25/t9: 0x0000000000000001
2A 000: r26/k0: 0x9200000001220050    r27/k1: 0x000000000000001e
2A 000: r28/gp: 0xc00000001fce5028    r29/sp: 0xa800000000103650
2A 000: r30/fp: 0x0000000000000000    r31/ra: 0xc00000001fc13500

2B 000: POD MSC Dex> why
2B 000:  EPC    : 0xa800000000326fa8 (0xa800000000326fa8)
2B 000:  ERREPC : 0xc00000001fc5ad4c (0xc00000001fc5ad4c)
2B 000:  CACERR : 0x0000000008080c10
2B 000:  Status : 0x0000000024407c80
2B 000:  BadVA  : 0xc0000000007f8768 (0xc0000000007f8768)
2B 000:  RA     : 0xc00000001fc398d8 (0xc00000001fc398d8)
2B 000:  SP     : 0xa8000000001033e0
2B 000:  A0     : 0x0000000024400080
2B 000:  Cause  : 0x0000000000008000 (INT:8-------)
2B 000:  Reason : 249 (NMI while executing in PROM.)
2B 000:  POD mode was called from: 0xc00000001fc02508 (0xc00000001fc02508)

2B 000: r00/r0: 0x0000000000000000    r01/at: 0x0000000000000000
2B 000: r02/v0: 0x00000000000000fe    r03/v1: 0x0000000000000001
2B 000: r04/a0: 0x0000000024400080    r05/a1: 0x9200000001030100
2B 000: r06/a2: 0x000000000000000a    r07/a3: 0x0000000000000000
2B 000: r08/a4: 0x0000000000000002    r09/a5: 0xa800000000103578
2B 000: r10/a6: 0x0000000000000060    r11/a7: 0xa8000000001035d8
2B 000: r12/t0: 0x00000000000f4240    r13/t1: 0x0000000000000002
2B 000: r14/t2: 0x0000000000000001    r15/t3: 0x0000000000000001
2B 000: r16/s0: 0x9200000001a20000    r17/s1: 0x00000000000000e3
2B 000: r18/s2: 0x00000000000000eb    r19/s3: 0x00000000011ad00c
2B 000: r20/s4: 0x00000000000000eb    r21/s5: 0x0000000000000000
2B 000: r22/s6: 0x0000000000000000    r23/s7: 0x00000000000000fc
2B 000: r24/t8: 0x0000000000000004    r25/t9: 0x0000000000000001
2B 000: r26/k0: 0x9200000001220058    r27/k1: 0x000000000000001e
2B 000: r28/gp: 0xc00000001fce5028    r29/sp: 0xa8000000001033e0
2B 000: r30/fp: 0x0000000000000000    r31/ra: 0xc00000001fc398d8

The address 0xa800000000326fa8 in both CPU's EPC register is
arch_local_irq_restore, line 109:

    a800000000326f90 <arch_local_irq_restore>:
    a800000000326f90:       40016000        mfc0    at,$12
    a800000000326f94:       30840001        andi    a0,a0,0x1
    a800000000326f98:       3421001f        ori     at,at,0x1f
    a800000000326f9c:       3821001f        xori    at,at,0x1f
    a800000000326fa0:       00812025        or      a0,a0,at
    a800000000326fa4:       40846000        mtc0    a0,$12
--> a800000000326fa8:       03e00008        jr      ra
    a800000000326fac:       00000000        nop

This bit of assembly only uses registers a0 and at, which in the above register
dump, a0 appears to hold some older value of $12 (CP0_STATUS), and at is
zero'ed out (possibly from the NMI restart).  Additionally, k0 is pointing at
the I/O address for a LED soldered on the node board for each CPU, and for CPU
2B, s0 holds an I/O address to HUB's MD register space, specifically the MSC
UART (so both are probably junk data from my use of MSC in POD Dex mode).

What's interesting to me in this specific instance is register a1 on CPU 2B
holds PI_RT_COUNT (0x9200000001030100), but on CPU 2A, the same value looks
like it's been overwritten by shifting right 16 bits and 63:48 filled in with
1's.  That's not used by arch_local_irq_restore, but it may have been used by a
previous state of the CPU, which is why I suspect the registers are getting
accidentally clobbered.

The constant theme is seeing PI_RT_COUNT's address popping into registers that
look like they contain data from other CPU states, which suggests to me that
it's some kind of race that may involve changing the CPU's interrupt state as
well as the IP27 timer code, because I know that on IP27, we have one counter,
but two compare registers, and the timer interrupt is always firing.  However,
in hub_rt_read, all reads from PI_RT_COUNT appear to be locked to the first CPU
on the nodeboard via REMOTE_HUB_L:

static u64 hub_rt_read(struct clocksource *cs)
{
	return REMOTE_HUB_L(cputonasid(0), PI_RT_COUNT);
}

I wonder if this clashes at all with rt_next_event, in which both CPUs can
access PI_RT_COUNT locally with LOCAL_HUB_L:

static int rt_next_event(unsigned long delta, struct clock_event_device *evt)
{
	unsigned int cpu = smp_processor_id();
	int slice = cputoslice(cpu);
	unsigned long cnt;

	cnt = LOCAL_HUB_L(PI_RT_COUNT);
	cnt += delta;
	LOCAL_HUB_S(PI_RT_COMPARE_A + PI_COUNT_OFFSET * slice, cnt);

	return LOCAL_HUB_L(PI_RT_COUNT) >= cnt ? -ETIME : 0;
}

If you take this as a possible contention point, and then hammer the system
with lots of I/O activity, such as writing out a large file to disk, and maybe
keep transmitting data over serial or ethernet, you get to a point where you
somehow deadlock the HUB on a specific nodeboard.  Which stops the system dead
because Linux doesn't currently set up detailed HUB link error reporting, so we
don't get signaled about one HUB losing contact with the other HUB.

Does that sound at all plausible?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
