Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 20:05:56 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:5165 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S21939935AbYJTTFw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2008 20:05:52 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: panic logic defeats arch dependent code 
Date:	Mon, 20 Oct 2008 12:05:43 -0700
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C501307489@exchange.ZeugmaSystems.local>
In-Reply-To: <20081018124358.GC17322@linux-mips.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: panic logic defeats arch dependent code 
Thread-Index: AckxHzSgIhsqNmSQR5GVNcsp0HowPgBxj+Sg
References: <DDFD17CC94A9BD49A82147DDF7D545C50130734A@exchange.ZeugmaSystems.local> <20081018124358.GC17322@linux-mips.org>
From:	"Anirban Sinha" <ASinha@zeugmasystems.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Return-Path: <ASinha@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ASinha@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Hi Ralf:

Thanks for responding and posting the patch. There is actually a another
important issue of a more general nature. I have already posted this in
the general Linux kernel mailing list under the subject "panic() logic".
The crux of the issue is:

The panic() call does a smp_send_stop() pretty early in the call
process for SMP systems. smp_send_stop basically marks all the other
cores as 'down' and
updates the cpu bitmap. One implication of this is that you cannot do
an IPI later on to other cores. However, interestingly, mips sibyte
processor tries to do a cfe_exit() through an IPI as a part of
emergency_reboot() that is called pretty late in the panic() logic. 

As a consequence of this, if a panic happens on a back core, the system
simply hangs and never actually does a "rebooting in 5 sec" thing. 

I believe the way panic logic is organized is in conflict with the
requirements of some archs, for example our mips sibyte arch. Currently,
the arch independent logic defeats the main purpose of the arch
dependent emergency_restart() function which is to restart the system.
In a vast majority of the cases, we do have a perfectly sane and
functional front core and we are just not able to gracefully reboot the
system because we are limited by the way panic() handles the shutdown
logic. If there are other archs that does a similar specific operation
for the front core as a part of 'emergency restart', they are all
defeated.

I believe, the way to solve this problem is that the archs themselves
take the responsibility of shutting down the core and not the generic
panic() call. The actual power down mechanism is arch dependent anyway,
so I guess it can be made to be a part of emergency_shutdown(). The arch
independent kernel code will then simply do the necessary arch
independent things to handle panic and simply call emergency_reboot() to
do the rest of the arch specific stuff, including powering down the
cores.

What do you think? 

Thanks.

Ani


>-----Original Message-----
>From: Ralf Baechle [mailto:ralf@linux-mips.org]
>Sent: Saturday, October 18, 2008 5:44 AM
>To: Anirban Sinha
>Cc: linux-mips@linux-mips.org
>Subject: Re: stop_this_cpu - redundant code?
>
>On Fri, Oct 17, 2008 at 07:57:12PM -0700, Anirban Sinha wrote:
>
>> This function  (stop_this_cpu) in /arch/mips/kernel/smp.c does a
>> local_irq_enable() and the adjacent comment says that it's because it
>> may need to service _machine_restart IPI. Unfortunately,
>> smp_call_function only sends IPIs to cores that are still online ( it
>> uses the cpu_online_map U all_but_myself_map in
>> smp_call_function_map()).
>
>Usually a system would be restarted through some hardware mechanism -
>probably a reset - anyway.
>
>> So the bottom-line is, should we still keep the local irqs enabled or
>is
>> this code totally redundant? I have seen other similar functions in
>> other archs where they actually disable the local irqs.
>
>You're right.  The code is ancient old and once uppon a time it made
>sense
>to do things this way but the MIPS version was never updates.
>Stop_this_cpu
>also should try to minimize the power consumption by using the WAIT
>instruction or whatever else a particular process has to offer.
>
>I didn't try to optimize this for the 34K where a TC could try to halt
>itself - there isn't really a point, I think.
>
>A few other architectures are explicitly disabling interrupts but
that's
>also redundant because smp_call_function() invokes the function on
other
>processors with interrupts disabled.
>
>Thanks for posting this,
>
>  Ralf
>
>Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
>
>diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
>index 7b59cfb..b79ea70 100644
>--- a/arch/mips/kernel/smp.c
>+++ b/arch/mips/kernel/smp.c
>@@ -163,8 +163,10 @@ static void stop_this_cpu(void *dummy)
> 	 * Remove this CPU:
> 	 */
> 	cpu_clear(smp_processor_id(), cpu_online_map);
>-	local_irq_enable();	/* May need to service _machine_restart
>IPI */
>-	for (;;);		/* Wait if available. */
>+	for (;;) {
>+		if (cpu_wait)
>+			(*cpu_wait)();		/* Wait if available. */
>+	}
> }
>
> void smp_send_stop(void)
