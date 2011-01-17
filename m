Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 12:32:01 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56235 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493384Ab1AQLb6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 12:31:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=FmpukmRAlPYXttT1xL3xziuCJn0R7Pqonjrbtzap8vQ=;
        b=kRR/rurjiHul3StBV5eEZNkAF1fBpIIP6raT9ATA8PRoaFVj4lTB8962OWcceGuLh7Vlen7IWjLB+zlocKqLWrIvP778SRDynIOrnKH0tfk/KqswNz9GHFnXnRk4bqbJaoO9SqIQqEwB52/GuVOTInH1bpfokTS8bCnh20VLb5Y=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1PenEO-0002Gq-93; Mon, 17 Jan 2011 11:26:40 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1PenEL-0005Gh-LG; Mon, 17 Jan 2011 11:26:37 +0000
Date:   Mon, 17 Jan 2011 11:26:37 +0000
From:   Russell King - ARM Linux <linux@arm.linux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Richard Henderson <rth@twiddle.net>,
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
Message-ID: <20110117112637.GA18599@n2100.arm.linux.org.uk>
References: <1295262433.30950.53.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295262433.30950.53.camel@laptop>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Mon, Jan 17, 2011 at 12:07:13PM +0100, Peter Zijlstra wrote:
> diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
> index 42aa078..c4a570b 100644
> --- a/arch/alpha/kernel/smp.c
> +++ b/arch/alpha/kernel/smp.c
> @@ -587,6 +587,7 @@ handle_ipi(struct pt_regs *regs)
>  		case IPI_RESCHEDULE:
>  			/* Reschedule callback.  Everything to be done
>  			   is done by the interrupt return path.  */
> +			scheduler_ipi();
>  			break;
>  
>  		case IPI_CALL_FUNC:
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 9066473..ffde790 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -579,6 +579,7 @@ asmlinkage void __exception do_IPI(struct pt_regs *regs)
>  				 * nothing more to do - eveything is
>  				 * done on the interrupt return path
>  				 */
> +				scheduler_ipi();

Maybe remove the comment "everything is done on the interrupt return path"
as with this function call, that is no longer the case.

Looks like the same is true for Alpha as well?
