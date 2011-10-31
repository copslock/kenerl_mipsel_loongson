Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2011 19:14:41 +0100 (CET)
Received: from e36.co.us.ibm.com ([32.97.110.154]:54720 "EHLO
        e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903565Ab1JaSOg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2011 19:14:36 +0100
Received: from /spool/local
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <johnstul@us.ibm.com>;
        Mon, 31 Oct 2011 12:14:20 -0600
Received: from d03relay01.boulder.ibm.com ([9.17.195.226])
        by e36.co.us.ibm.com ([192.168.1.136]) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 31 Oct 2011 12:14:11 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
        by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p9VICsta305414
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 12:12:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p9VICksF022295
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 12:12:53 -0600
Received: from [9.65.8.74] (sig-9-65-8-74.mts.ibm.com [9.65.8.74])
        by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p9VICiVR021926;
        Mon, 31 Oct 2011 12:12:44 -0600
Message-ID: <1320084763.8964.22.camel@js-netbook>
Subject: Re: [MIPS]clocks_calc_mult_shift() may gen a too big mult value
From:   John Stultz <johnstul@us.ibm.com>
To:     zhangfx <zhangfx@lemote.com>
Cc:     Chen Jie <chenj@lemote.com>, Yong Zhang <yong.zhang0@gmail.com>,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        tglx@linutronix.de, yanhua <yanh@lemote.com>,
        =?UTF-8?Q?=E9=A1=B9=E5=AE=87?= <xiangy@lemote.com>,
        =?UTF-8?Q?=E5=AD=99=E6=B5=B7=E5=8B=87?= <sunhy@lemote.com>
Date:   Mon, 31 Oct 2011 14:12:43 -0400
In-Reply-To: <4EAEA9AF.1060904@lemote.com>
References: <CAGXxSxXmgzxN361Cko1fY_+oWwfgjXLhS61gtvqB8YYXHXZVyw@mail.gmail.com>
         <CAM2zO=CodQLE05ZNOOba3jv_qJ5XuZj3yrnS0aHCOj+cp_24Xw@mail.gmail.com>
         <CAGXxSxUHGN99hXK8K5k9ayVfMenAWAbWVpqkotix_JyUbPCU+w@mail.gmail.com>
         <1320066197.2266.11.camel@js-netbook> <4EAEA9AF.1060904@lemote.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.0- 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
x-cbid: 11103118-3352-0000-0000-0000007BE7BC
X-archive-position: 31333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: johnstul@us.ibm.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 22067

On Mon, 2011-10-31 at 21:59 +0800, zhangfx wrote:
> > Could you annotate clocks_calc_mult_shift() a little bit to see where
> > things might be going wrong?
> Let me give some real world data:
> in one machine with 500MHz freq,
> the calculated freq = 500084016, and clocks_calc_mult_shift() give
>    mult = 4294245725
>    shift = 30
> 
> but in the 1785th call to update_wall_time, due to error correction 
> algorithm, the mult become 4293964632,
> in next update_wall_time, the ntp_error is 0x301c93b7927c, which lead to 
> an adj of 20, then mult is overflow:
>     mult = 4293964632 + (1<<20) = 45912
> with this mult, if anyone call timekeeping_get_ns or others using mult, 
> the time concept will be extremely wrong, so some sleep will 
> (almost)never return => virtually hang
> 
> We are not abosulately sure that the error source is normal, but anyway 
> it is a possible for the code to overflow, and it will cause hang.
> 
> For this case, the timekeeping_bigadjust should be able to control adj 
> to a maximum of around 20 with the lookahead for any error. So if the 
> mult is chosen at shift = 29, then mult becomes 4294245725/2, it will 
> not be possible to be overflowed.
> 
> In short, choosing a mult close to 2^32 is dangerous. But I don't know 
> what's the best way to avoid it for general cases, because I don't know 
> how big error can be and the adj can be for different systems.

Ah. Ok, sorry for being so slow to understand.

So yea, I think you're right that the issue seems to be that for certain
feq values, the resulting mult,shift pair is optimized a little too far,
and we don't leave enough room for ntp adjustments to mult, without the
possibility of overflowing mult.

The following patch should handle it (although I'm at a conf right now,
so I couldn't test it), although I might be trying to be too smart here.
Rather then just checking if mult is larger then 0xf0000000, we try to
quantify the largest valid mult adjustment, and then make sure mult +
that value doesn't overflow. NTP limits adjustments to 500ppm, but the
kernel might have to deal with larger internal adjustments. Probably we
could be safe ruling out larger then 5% adjustments.

So then its just a matter of 1/2^4. So the largest mult adjustment
should be 1 << (cs->shift - 4)

Does this seem reasonable? Let me know if this seems to work for you.

Thomas: does this fix look like its in a reasonable spot? I don't want
to clutter up the calc_mult_shift() code up since this really only
applies to clocksources and not clockevents.

NOT TESTED & NOT FOR INCLUSION (YET)
Signed-off-by: John Stultz <john.stultz@linaro.org>
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cf52fda..73518d2 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -640,7 +640,7 @@ static void clocksource_enqueue(struct clocksource *cs)
 void __clocksource_updatefreq_scale(struct clocksource *cs, u32 scale, u32 freq)
 {
 	u64 sec;
-
+	u32 maxadj;
 	/*
 	 * Calc the maximum number of seconds which we can run before
 	 * wrapping around. For clocksources which have a mask > 32bit
@@ -661,6 +661,22 @@ void __clocksource_updatefreq_scale(struct clocksource *cs, u32 scale, u32 freq)
 
 	clocks_calc_mult_shift(&cs->mult, &cs->shift, freq,
 			       NSEC_PER_SEC / scale, sec * scale);
+
+	/*
+	 * Since mult may be adjusted by ntp, add an extra saftey margin
+	 * for clocksources that have large mults, to avoid overflow.
+	 *
+	 * Assume we won't try to correct for more then 5% adjustments
+	 * (50,000 ppm), which approximates to 1/16 or 1/2^4.
+	 * Thus 1 << (shift - 4) is the largest mult adjustment we'll
+	 * support.
+	 */
+	maxadj = 1 << (shift-4);
+	if ((cs->mult + maxadj < cs->mult) || (cs->mult - maxadj > cs->mult)) {
+		cs->mult >>= 1;
+		cs->shift--;
+	}
+
 	cs->max_idle_ns = clocksource_max_deferment(cs);
 }
 EXPORT_SYMBOL_GPL(__clocksource_updatefreq_scale);
