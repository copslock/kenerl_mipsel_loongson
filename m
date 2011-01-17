Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 14:59:32 +0100 (CET)
Received: from ra.se.axis.com ([195.60.68.13]:41612 "EHLO ra.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493451Ab1AQN72 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 14:59:28 +0100
Received: from localhost (localhost [127.0.0.1])
        by ra.se.axis.com (Postfix) with ESMTP id E0FBE11E94;
        Mon, 17 Jan 2011 14:59:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
        by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id o3H1zUkHW+Z6; Mon, 17 Jan 2011 14:59:21 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
        by ra.se.axis.com (Postfix) with ESMTP id 8C2FA11E8F;
        Mon, 17 Jan 2011 14:59:14 +0100 (CET)
Received: from silver.se.axis.com (silver.se.axis.com [10.88.4.3])
        by thoth.se.axis.com (Postfix) with ESMTP id 2F5F234157;
        Mon, 17 Jan 2011 14:59:14 +0100 (CET)
Received: from silver.se.axis.com (localhost [127.0.0.1])
        by silver.se.axis.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p0HDxEs9031675;
        Mon, 17 Jan 2011 14:59:14 +0100
Received: (from jespern@localhost)
        by silver.se.axis.com (8.14.3/8.14.3/Submit) id p0HDwrUa031663;
        Mon, 17 Jan 2011 14:58:53 +0100
Date:   Mon, 17 Jan 2011 14:58:53 +0100
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Mike Frysinger <vapier@gentoo.org>,
        Mikael Starvik <starvik@axis.com>,
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
        "linux390@de.ibm.com" <linux390@de.ibm.com>,
        Paul Mundt <lethal@linux-sh.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Metcalf <cmetcalf@tilera.com>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "uclinux-dist-devel@blackfin.uclinux.org" 
        <uclinux-dist-devel@blackfin.uclinux.org>,
        linux-cris-kernel <linux-cris-kernel@axis.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "user-mode-linux-devel@lists.sourceforge.net" 
        <user-mode-linux-devel@lists.sourceforge.net>,
        "user-mode-linux-user@lists.sourceforge.net" 
        <user-mode-linux-user@lists.sourceforge.net>,
        "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
        "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
        smp_send_reschedule()
Message-ID: <20110117135852.GI9874@axis.com>
References: <1295262433.30950.53.camel@laptop> <20110117112637.GA18599@n2100.arm.linux.org.uk> <1295263884.30950.54.camel@laptop> <1295264509.30950.59.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295264509.30950.59.camel@laptop>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <jesper.nilsson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.nilsson@axis.com
Precedence: bulk
X-list: linux-mips

On Mon, Jan 17, 2011 at 12:41:49PM +0100, Peter Zijlstra wrote:
> Index: linux-2.6/arch/cris/arch-v32/kernel/smp.c
> ===================================================================
> --- linux-2.6.orig/arch/cris/arch-v32/kernel/smp.c
> +++ linux-2.6/arch/cris/arch-v32/kernel/smp.c
> @@ -340,15 +340,18 @@ irqreturn_t crisv32_ipi_interrupt(int ir
> 
>         ipi = REG_RD(intr_vect, irq_regs[smp_processor_id()], rw_ipi);
> 
> +       if (ipi.vector & IPI_SCHEDULE) {
> +               scheduler_ipi();
> +       }
>         if (ipi.vector & IPI_CALL) {
> -                func(info);
> +               func(info);
>         }
>         if (ipi.vector & IPI_FLUSH_TLB) {
> -                    if (flush_mm == FLUSH_ALL)
> -                        __flush_tlb_all();
> -                    else if (flush_vma == FLUSH_ALL)
> +               if (flush_mm == FLUSH_ALL)
> +                       __flush_tlb_all();
> +               else if (flush_vma == FLUSH_ALL)
>                         __flush_tlb_mm(flush_mm);
> -                    else
> +               else
>                         __flush_tlb_page(flush_vma, flush_addr);
>         }
> 

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
