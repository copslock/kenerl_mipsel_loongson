Received:  by oss.sgi.com id <S305165AbQAOR0K>;
	Sat, 15 Jan 2000 09:26:10 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:51557 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQAORZq>;
	Sat, 15 Jan 2000 09:25:46 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id JAA17452; Sat, 15 Jan 2000 09:22:57 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA70204
	for linux-list;
	Sat, 15 Jan 2000 09:17:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA67924
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 15 Jan 2000 09:17:15 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA02836
	for <linux@cthulhu.engr.sgi.com>; Sat, 15 Jan 2000 09:17:13 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA00725;
	Sat, 15 Jan 2000 09:17:06 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA21268;
	Sat, 15 Jan 2000 09:17:01 -0800 (PST)
Message-ID: <005e01bf5f7d$fc1cf490$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Linux/MIPS" <linux@cthulhu.engr.sgi.com>
Subject: Re: kernel sources?
Date:   Sat, 15 Jan 2000 18:28:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

-----Original Message-----
From: Ralf Baechle <ralf@oss.sgi.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux/MIPS <linux@cthulhu.engr.sgi.com>
Date: Saturday, January 15, 2000 1:56 AM
Subject: Re: kernel sources?


>On Thu, Jan 13, 2000 at 05:03:39PM +0100, Geert Uytterhoeven wrote:
>
>> I used the R5000 CP0_COUNTER/CP0_COMPARE registers for the timer interrupt. I
>> know it's not accurate, but it's better than nothing. I still have to figure
>> out how more complex interrupts work in the MIPS source tree.
>
>It is accurate as driven by the CPU's clock.  It is just somewhat tricky to
>handle and even more tricky on some broken CPUs.  From an old email written
>by Bill Earl:
>
>[...]
>As far as I know, all R4000 processors, and possibly some R4400 processors,
>are affected.  The bug is that, if you read $count exactly when it equals
>$compare, the count/compare interrupt for that count/compare crossing is
>discarded.  The workaround from IRIX is appended.  The variable
>r4000_clock_war is set to 1 if the system is an Indy with an R4000 processor.
>The r4k_compare_shadow is set to the same value as $compare whenever $compare
>is updated (with interrupts masked while the variable and $compare are
>updated together).
>[...]

There is also a race condition inherent in many implementations of
the timer interrupt handler, and the main stream of the current
MIPS/Linux distributions is no exception.   The SGI code looks
a bit like this:

void indy_timer_interrupt(struct pt_regs *regs)
{
        unsigned long count;
        int irq = 7;

        /* Ack timer and compute new compare. */
        count = read_32bit_cp0_register(CP0_COUNT);
        /* This has races.  */
        if ((count - r4k_cur) >= r4k_offset) {
                /* If this happens to often we'll need to compensate.  */
                missed_heart_beats++;
                r4k_cur = count + r4k_offset;
        }
        else
            r4k_cur += r4k_offset;
        ack_r4ktimer(r4k_cur);
        kstat.irqs[0][irq]++;
        do_timer(regs);

        /* We update the Dallas time of day approx. every 11 minutes,
         * because of how the numbers work out we need to make
         * absolutely sure we do this update within 500ms before the
         * next second starts, thus the following code.
         */
        if ((time_status & STA_UNSYNC) == 0 &&
            xtime.tv_sec > last_rtc_update + 660 &&
            xtime.tv_usec >= 500000 - (tick >> 1) &&
            xtime.tv_usec <= 500000 + (tick >> 1)) {
                if (set_rtc_mmss(xtime.tv_sec) == 0)
                        last_rtc_update = xtime.tv_sec;
                else
                        /* do it again in 60 s */
                        last_rtc_update = xtime.tv_sec - 600;
        }
}

The inherent race is in the fact that the count is sampled
once at the beginnning of the routine and used throughout.
It is possible (with bad luck and sloppy drivers) to be very
late into the handler, so much so that the new time-out time
can be reached between the sample and the programming
of the compare register.  If that happens, one gets no timer
interrupt for a full wrap of the count register.   I first observed
this in OpenBSD, where the problem was worse, but Linux
has the same conceptual hole.  A more robust handler
looks a bit like this:

void p5064_timer_interrupt(struct pt_regs *regs)
{
        int irq = 7;

        if(r4k_offset != 0) {
                do {
                        kstat.irqs[0][irq]++;
                        do_timer(regs);

                        /* Historical comment/code:
                        * RTC time of day s updated approx. every 11
                        * minutes.  Because of how the numbers work out
                        * we need to make absolutely sure we do this update
                        * within 500ms before the * next second starts,
                        * thus the following code.
                        */
                        if ((time_status & STA_UNSYNC) == 0
                        && xtime.tv_sec > last_rtc_update + 660
                        && xtime.tv_usec >= 500000 - (tick >> 1)
                        && xtime.tv_usec <= 500000 + (tick >> 1))
                            if (set_rtc_mmss(xtime.tv_sec) == 0)
                                last_rtc_update = xtime.tv_sec;
                            else
                                /* do it again in 60 s */
                                last_rtc_update = xtime.tv_sec - 600;

                        r4k_cur += r4k_offset;
                        ack_r4ktimer(r4k_cur);
                } while (((unsigned long)read_32bit_cp0_register(CP0_COUNT)
                        - r4k_cur) < 0x7fffffff);
        } else ack_r4ktimer(0);
}

As Ralf says, it's very accurate *if* you have an accurate picture of
the CPU's clock frequency.  The usual mechanism of measuring
the progress of the count register against elapsed time on a TOD
clock has been known to be inaccurate on some platforms due
to skew between the visibility to software and the actual timing
event, so be careful.

            Kevin K.
__

Kevin D. Kissell
MIPS Technologies European Architecture Lab
kevink@mips.com
Tel. +33.4.78.38.70.67
FAX. +33.4.78.38.70.68
