Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2003 08:06:32 +0000 (GMT)
Received: from p508B69C2.dip.t-dialin.net ([IPv6:::ffff:80.139.105.194]:60590
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225197AbTA2IGc>; Wed, 29 Jan 2003 08:06:32 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0T86Rr16755;
	Wed, 29 Jan 2003 09:06:27 +0100
Date: Wed, 29 Jan 2003 09:06:27 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: Juan Quintela <quintela@mandrakesoft.com>,
	linux-mips@linux-mips.org
Subject: Re: [RFC & PATCH]  fixing tlb flush race problem on smp
Message-ID: <20030129090627.D7741@linux-mips.org>
References: <20030121143726.C16939@mvista.com> <86bs297hpd.fsf@trasno.mitica> <20030127170346.S11633@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030127170346.S11633@mvista.com>; from jsun@mvista.com on Mon, Jan 27, 2003 at 05:03:46PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 27, 2003 at 05:03:46PM -0800, Jun Sun wrote:

> I also find a stupid typo and a subtle hole in my original patch.
> Here is an updated version, for 2.4/mips only.  If it looks ok, I 
> will extend to other sub-arches/trees.
> 
> This new one is pretty nice in that all mmu related operations
> are put into one file and it is much easier to ensure correctness
> later.

I like this one.

> +
> +	/*
> +	 * Mark current->active_mm as not "active" anymore.
> +	 * We don't want to mislead possible IPI tlb flush routines.
> +	 */
> +	clear_bit(cpu, &prev->cpu_vm_mask);
> +	set_bit(cpu, &next->cpu_vm_mask);
> +
> +	local_irq_restore(flags);

I don't think it's necessary to protect the clear_bit and set_bit operations
with local_irq_save ... local_irq_restore.

In addition because switch_mm is always called with interrupts enabled you
can simplify that to local_irq_disable ... local_irq_enable.

  Ralf
