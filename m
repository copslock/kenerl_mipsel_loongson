Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 13:00:38 +0100 (CET)
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53632 "EHLO
        caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493402Ab1AQMAf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jan 2011 13:00:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=arm.linux.org.uk; s=caramon;
        h=Sender:In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=7AKuFHemzEnJi+i4xATR5kcPnaWlSIRczl7azc6AofU=;
        b=RmA2l1K16s4CX9DI/ZvKJHtxE9CJqPxjfCuNj2RslMfCoRce9tfhMTkO6Fw4f26ipjcXW6Ut6rEaT3KfRuEPyLX5T+G6HP6Y0D8NLCZ5LM7NbkE6BpyC3KMnFc6sZNiCdVnOD8K9qCS5DJp+dhc1NrX9adCDqO2825+HpyPqeRA=;
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86])
        by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <linux@arm.linux.org.uk>)
        id 1PeniZ-0002KC-4C; Mon, 17 Jan 2011 11:57:51 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.72)
        (envelope-from <linux@n2100.arm.linux.org.uk>)
        id 1PeniW-0005QM-Uw; Mon, 17 Jan 2011 11:57:48 +0000
Date:   Mon, 17 Jan 2011 11:57:48 +0000
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
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net,
        xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] sched: provide scheduler_ipi() callback in response to
        smp_send_reschedule()
Message-ID: <20110117115748.GA20615@n2100.arm.linux.org.uk>
References: <1295262433.30950.53.camel@laptop> <20110117112637.GA18599@n2100.arm.linux.org.uk> <1295263884.30950.54.camel@laptop> <1295264509.30950.59.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1295264509.30950.59.camel@laptop>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <linux+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Mon, Jan 17, 2011 at 12:41:49PM +0100, Peter Zijlstra wrote:
> ===================================================================
> --- linux-2.6.orig/arch/arm/kernel/smp.c
> +++ linux-2.6/arch/arm/kernel/smp.c
> @@ -575,10 +575,7 @@ asmlinkage void __exception do_IPI(struc
>  				break;
>  
>  			case IPI_RESCHEDULE:
> -				/*
> -				 * nothing more to do - eveything is
> -				 * done on the interrupt return path
> -				 */
> +				scheduler_ipi();
>  				break;
>  
>  			case IPI_CALL_FUNC:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
