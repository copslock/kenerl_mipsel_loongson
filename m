Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Feb 2011 14:53:40 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:34955 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491092Ab1BGNxe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Feb 2011 14:53:34 +0100
Received: from j77219.upc-j.chello.nl ([24.132.77.219] helo=dyad.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
        id 1PmRX2-00068z-S8
        for linux-mips@linux-mips.org; Mon, 07 Feb 2011 13:53:32 +0000
Received: by dyad.programming.kicks-ass.net (Postfix, from userid 65534)
        id AE9CA2425A; Mon,  7 Feb 2011 14:56:49 +0100 (CET)
Received: from [IPv6:::1] (dyad [192.168.0.60])
        by dyad.programming.kicks-ass.net (Postfix) with ESMTP id 4C95C2424A;
        Mon,  7 Feb 2011 14:56:28 +0100 (CET)
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
 smp_send_reschedule()
From:   Peter Zijlstra <peterz@infradead.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
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
In-Reply-To: <1297034792.14982.10.camel@pasglop>
References: <1295262433.30950.53.camel@laptop>
         <1297034792.14982.10.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 07 Feb 2011 14:54:19 +0100
Message-ID: <1297086859.13327.16.camel@laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 7bit
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
Precedence: bulk
X-list: linux-mips

On Mon, 2011-02-07 at 10:26 +1100, Benjamin Herrenschmidt wrote:
> You missed:
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 9813605..467d122 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -98,6 +98,7 @@ void smp_message_recv(int msg)
>                 break;
>         case PPC_MSG_RESCHEDULE:
>                 /* we notice need_resched on exit */
> +               scheduler_ipi();
>                 break;
>         case PPC_MSG_CALL_FUNC_SINGLE:
>                 generic_smp_call_function_single_interrupt();
> 
> Fold that in and add:
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Thanks Ben!
