Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 13:18:46 +0100 (CET)
Received: from mtagate1.uk.ibm.com ([194.196.100.161]:48364 "EHLO
        mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493406Ab1AQMSm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 13:18:42 +0100
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
        by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p0HCIVRU005433;
        Mon, 17 Jan 2011 12:18:31 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com [9.149.37.247])
        by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p0HCIVLV897124;
        Mon, 17 Jan 2011 12:18:33 GMT
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
        by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p0HCIQ9k006694;
        Mon, 17 Jan 2011 05:18:28 -0700
Received: from mschwide.boeblingen.de.ibm.com (dyn-9-152-212-22.boeblingen.de.ibm.com [9.152.212.22])
        by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id p0HCIOAS006651;
        Mon, 17 Jan 2011 05:18:24 -0700
Date:   Mon, 17 Jan 2011 13:18:23 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
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
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
 smp_send_reschedule()
Message-ID: <20110117131823.410e515c@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <1295262433.30950.53.camel@laptop>
References: <1295262433.30950.53.camel@laptop>
Organization: IBM Corporation
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.20.1; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <schwidefsky@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwidefsky@de.ibm.com
Precedence: bulk
X-list: linux-mips

On Mon, 17 Jan 2011 12:07:13 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> I visited existing smp_send_reschedule() implementations and tried to
> add a call to scheduler_ipi() in their handler part, but esp. for MIPS
> I'm not quite sure I actually got all of them.
>  
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 94cf510..61789e8 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -163,12 +163,12 @@ static void do_ext_call_interrupt(unsigned int ext_int_code,
>  
>  	/*
>  	 * handle bit signal external calls
> -	 *
> -	 * For the ec_schedule signal we have to do nothing. All the work
> -	 * is done automatically when we return from the interrupt.
>  	 */
>  	bits = xchg(&S390_lowcore.ext_call_fast, 0);
>  
> +	if (test_bit(ec_schedule, &bits))
> +		scheduler_ipi();
> +
>  	if (test_bit(ec_call_function, &bits))
>  		generic_smp_call_function_interrupt();
>  

s390 bits are fine.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
