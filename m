Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2014 23:15:39 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:26310 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6854786AbaEIVPhO4H8V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2014 23:15:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 1A5D19C58371A;
        Fri,  9 May 2014 22:15:26 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 9 May 2014 22:15:29 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 9 May
 2014 22:15:29 +0100
Message-ID: <536D4571.6010302@imgtec.com>
Date:   Fri, 9 May 2014 22:15:29 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 05/11] kvm tools, mips: Add MIPS support
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1399391491-5021-6-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1399391491-5021-6-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Andreas,

On 06/05/14 16:51, Andreas Herrmann wrote:
> From: David Daney <david.daney@cavium.com>
> 
> So far this was tested with host running KVM using MIPS-VZ (on Cavium
> Octeon3). A paravirtualized mips kernel was used for the guest.
> 
> [andreas.herrmann:
>    * Renamed kvm__arch_periodic_poll to kvm__arch_read_term
>      because of commit fa817d892508b6d3a90f478dbeedbe5583b14da7
>      (kvm tools: remove periodic tick in favour of a polling thread)
>    * Added ioport__map_irq skeleton to fix build problem.
>    * Rely on TERM_MAX_DEVS instead of using other macros
>    * Adaptions for MMIO support
>    * Set coalesc offset
>    * Fixed compile warnings]
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>


> +static bool kvm_cpu__hypercall_write_cons(struct kvm_cpu *vcpu)
> +{
> +	int term = (int)vcpu->kvm_run->hypercall.args[0];
> +	u64 addr = vcpu->kvm_run->hypercall.args[1];
> +	int len = (int)vcpu->kvm_run->hypercall.args[2];
> +	char *host_addr;
> +
> +	if (term < 0 || term >= TERM_MAX_DEVS) {
> +		pr_warning("hypercall_write_cons term out of range <%d>", term);
> +		return false;
> +	}
> +	if (len <= 0) {
> +		pr_warning("hypercall_write_cons len out of range <%d>", len);
> +		return false;
> +	}
> +
> +	if ((addr & 0xffffffffc0000000ull) == 0xffffffff80000000ull)
> +		addr &= 0x1ffffffful; /* Convert KSEG{0,1} to physical. */
> +	if ((addr & 0xc000000000000000ull) == 0x8000000000000000ull)
> +		addr &= 0x07ffffffffffffffull; /* Convert XKPHYS to pysical */
> +
> +	host_addr = guest_flat_to_host(vcpu->kvm, addr);
> +	if (!host_addr) {
> +		pr_warning("hypercall_write_cons unmapped physaddr %llx", (unsigned long long)addr);
> +		return false;
> +	}
> +
> +	term_putc(host_addr, len, term);

Does len need to be range checked?

> +void kvm_cpu__show_registers(struct kvm_cpu *vcpu)
> +{
> +	struct kvm_regs regs;
> +
> +	if (ioctl(vcpu->vcpu_fd, KVM_GET_REGS, &regs) < 0)
> +		die("KVM_GET_REGS failed");
> +	dprintf(debug_fd, "\n Registers:\n");
> +	dprintf(debug_fd,   " ----------\n");
> +	dprintf(debug_fd, "$0   : %016lx %016lx %016lx %016lx\n",
> +		(unsigned long)regs.gpr[0], (unsigned long)regs.gpr[1],
> +		(unsigned long)regs.gpr[2], (unsigned long)regs.gpr[3]);

Presumably there's nothing stopping a 32-bit userland from creating a
64-bit guest? If that's the case should this all use unsigned long longs?

> +	dprintf(debug_fd, "$4   : %016lx %016lx %016lx %016lx\n",
> +		(unsigned long)regs.gpr[4], (unsigned long)regs.gpr[5],
> +		(unsigned long)regs.gpr[6], (unsigned long)regs.gpr[7]);
> +	dprintf(debug_fd, "$8   : %016lx %016lx %016lx %016lx\n",
> +		(unsigned long)regs.gpr[8], (unsigned long)regs.gpr[9],
> +		(unsigned long)regs.gpr[10], (unsigned long)regs.gpr[11]);
> +	dprintf(debug_fd, "$12  : %016lx %016lx %016lx %016lx\n",
> +		(unsigned long)regs.gpr[12], (unsigned long)regs.gpr[13],
> +		(unsigned long)regs.gpr[14], (unsigned long)regs.gpr[15]);
> +	dprintf(debug_fd, "$16  : %016lx %016lx %016lx %016lx\n",
> +		(unsigned long)regs.gpr[16], (unsigned long)regs.gpr[17],
> +		(unsigned long)regs.gpr[18], (unsigned long)regs.gpr[19]);
> +	dprintf(debug_fd, "$20  : %016lx %016lx %016lx %016lx\n",
> +		(unsigned long)regs.gpr[20], (unsigned long)regs.gpr[21],
> +		(unsigned long)regs.gpr[22], (unsigned long)regs.gpr[23]);
> +	dprintf(debug_fd, "$24  : %016lx %016lx %016lx %016lx\n",
> +		(unsigned long)regs.gpr[24], (unsigned long)regs.gpr[25],
> +		(unsigned long)regs.gpr[26], (unsigned long)regs.gpr[27]);
> +	dprintf(debug_fd, "$28  : %016lx %016lx %016lx %016lx\n",
> +		(unsigned long)regs.gpr[28], (unsigned long)regs.gpr[29],
> +		(unsigned long)regs.gpr[30], (unsigned long)regs.gpr[31]);
> +
> +	dprintf(debug_fd, "hi   : %016lx\n", (unsigned long)regs.hi);
> +	dprintf(debug_fd, "lo   : %016lx\n", (unsigned long)regs.lo);
> +	dprintf(debug_fd, "epc  : %016lx\n", (unsigned long)regs.pc);
> +
> +	dprintf(debug_fd, "\n");
> +}

Cheers
James
