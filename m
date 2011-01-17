Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 14:52:38 +0100 (CET)
Received: from usmamail.tilera.com ([206.83.70.70]:58254 "EHLO
        USMAMAIL.TILERA.COM" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493451Ab1AQNwf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 14:52:35 +0100
Received: from [192.168.1.103] (24.34.76.130) by
 USMAExch2.tad.internal.tilera.com (10.3.0.33) with Microsoft SMTP Server id
 14.0.694.0; Mon, 17 Jan 2011 08:52:26 -0500
Message-ID: <4D344995.80701@tilera.com>
Date:   Mon, 17 Jan 2011 08:52:21 -0500
From:   Chris Metcalf <cmetcalf@tilera.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Hirokazu Takata <takata@linux-m32r.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Howells <dhowells@redhat.com>,
        Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
        Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        <linux390@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        <linux-alpha@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <uclinux-dist-devel@blackfin.uclinux.org>,
        <linux-cris-kernel@axis.com>, <linux-ia64@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <linux-parisc@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-s390@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <user-mode-linux-devel@lists.sourceforge.net>,
        <user-mode-linux-user@lists.sourceforge.net>,
        <xen-devel@lists.xensource.com>, <virtualization@lists.osdl.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
 smp_send_reschedule()
References: <1295262433.30950.53.camel@laptop>   <20110117112637.GA18599@n2100.arm.linux.org.uk>         <1295263884.30950.54.camel@laptop> <1295264509.30950.59.camel@laptop>
In-Reply-To: <1295264509.30950.59.camel@laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-Path: <cmetcalf@tilera.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cmetcalf@tilera.com
Precedence: bulk
X-list: linux-mips

On 1/17/2011 6:41 AM, Peter Zijlstra wrote:
> Index: linux-2.6/arch/tile/kernel/smp.c
> ===================================================================
> --- linux-2.6.orig/arch/tile/kernel/smp.c
> +++ linux-2.6/arch/tile/kernel/smp.c
> @@ -184,12 +184,8 @@ void flush_icache_range(unsigned long st
>  /* Called when smp_send_reschedule() triggers IRQ_RESCHEDULE. */
>  static irqreturn_t handle_reschedule_ipi(int irq, void *token)
>  {
> -       /*
> -        * Nothing to do here; when we return from interrupt, the
> -        * rescheduling will occur there. But do bump the interrupt
> -        * profiler count in the meantime.
> -        */
>         __get_cpu_var(irq_stat).irq_resched_count++;
> +       scheduler_ipi();
>
>         return IRQ_HANDLED;
>  }

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
