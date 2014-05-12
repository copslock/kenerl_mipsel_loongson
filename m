Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2014 15:01:24 +0200 (CEST)
Received: from mail-ee0-f54.google.com ([74.125.83.54]:40439 "EHLO
        mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822112AbaELNBUmsE3d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2014 15:01:20 +0200
Received: by mail-ee0-f54.google.com with SMTP id b57so4694186eek.13
        for <linux-mips@linux-mips.org>; Mon, 12 May 2014 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=POGQuvUeg0YmLMPUjlrWvEDvbkys9ABRfLojtZ/eBZk=;
        b=UmXqcomfOQdGPvaaeRaz0FQovh9a8FQ7sTipaPISQ96t+PvfXNtwjmZYi6h3+/h/Pa
         Sn7p5yv9W/qBKv54tDa6nxmUzQB+zGsuE0tEDUMqwQnYsdMXyZR1DQZUmoBxbrmda3hm
         UUzewl7HMrFKxkzybg6e3cTh6/FODxQFImyswB4l8mwsSSZyp6fH4Ik8e5F9YkjOvxSl
         qwr8o+fNZ+0fXXIgGWeZbcTGr2LxdfxED76N0tyD2llaBxU6/I6h7BaOGC2pKLlR6IEp
         cyQR/A8mzF6sD8wL0MvtAGs8eFSLWKB1WxQCILA/Av/lEG2ug0vWr6EMuhKgMAvGbl0U
         IENg==
X-Received: by 10.15.75.197 with SMTP id l45mr32587784eey.89.1399899675399;
        Mon, 12 May 2014 06:01:15 -0700 (PDT)
Received: from alberich ([2.174.248.214])
        by mx.google.com with ESMTPSA id u1sm32784723eex.31.2014.05.12.06.01.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 May 2014 06:01:14 -0700 (PDT)
Date:   Mon, 12 May 2014 15:01:10 +0200
From:   Andreas Herrmann <herrmann.der.user@googlemail.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 05/11] kvm tools, mips: Add MIPS support
Message-ID: <20140512130110.GA17255@alberich>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1399391491-5021-6-git-send-email-andreas.herrmann@caviumnetworks.com>
 <536D4571.6010302@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <536D4571.6010302@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herrmann.der.user@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herrmann.der.user@googlemail.com
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

On Fri, May 09, 2014 at 10:15:29PM +0100, James Hogan wrote:
> Hi Andreas,
> 
> On 06/05/14 16:51, Andreas Herrmann wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > So far this was tested with host running KVM using MIPS-VZ (on Cavium
> > Octeon3). A paravirtualized mips kernel was used for the guest.
> > 
> > [andreas.herrmann:
> >    * Renamed kvm__arch_periodic_poll to kvm__arch_read_term
> >      because of commit fa817d892508b6d3a90f478dbeedbe5583b14da7
> >      (kvm tools: remove periodic tick in favour of a polling thread)
> >    * Added ioport__map_irq skeleton to fix build problem.
> >    * Rely on TERM_MAX_DEVS instead of using other macros
> >    * Adaptions for MMIO support
> >    * Set coalesc offset
> >    * Fixed compile warnings]
> > 
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> 
> 
> > +static bool kvm_cpu__hypercall_write_cons(struct kvm_cpu *vcpu)
> > +{
> > +	int term = (int)vcpu->kvm_run->hypercall.args[0];
> > +	u64 addr = vcpu->kvm_run->hypercall.args[1];
> > +	int len = (int)vcpu->kvm_run->hypercall.args[2];
> > +	char *host_addr;
> > +
> > +	if (term < 0 || term >= TERM_MAX_DEVS) {
> > +		pr_warning("hypercall_write_cons term out of range <%d>", term);
> > +		return false;
> > +	}
> > +	if (len <= 0) {
> > +		pr_warning("hypercall_write_cons len out of range <%d>", len);
> > +		return false;
> > +	}
> > +
> > +	if ((addr & 0xffffffffc0000000ull) == 0xffffffff80000000ull)
> > +		addr &= 0x1ffffffful; /* Convert KSEG{0,1} to physical. */
> > +	if ((addr & 0xc000000000000000ull) == 0x8000000000000000ull)
> > +		addr &= 0x07ffffffffffffffull; /* Convert XKPHYS to pysical */
> > +
> > +	host_addr = guest_flat_to_host(vcpu->kvm, addr);
> > +	if (!host_addr) {
> > +		pr_warning("hypercall_write_cons unmapped physaddr %llx", (unsigned long long)addr);
> > +		return false;
> > +	}
> > +
> > +	term_putc(host_addr, len, term);
> 
> Does len need to be range checked?

len <= 0 is checked above.
I don't think an upper boundery check is required.
term_putc (using write) should be able to handle it.
No?

> > +void kvm_cpu__show_registers(struct kvm_cpu *vcpu)
> > +{
> > +	struct kvm_regs regs;
> > +
> > +	if (ioctl(vcpu->vcpu_fd, KVM_GET_REGS, &regs) < 0)
> > +		die("KVM_GET_REGS failed");
> > +	dprintf(debug_fd, "\n Registers:\n");
> > +	dprintf(debug_fd,   " ----------\n");
> > +	dprintf(debug_fd, "$0   : %016lx %016lx %016lx %016lx\n",
> > +		(unsigned long)regs.gpr[0], (unsigned long)regs.gpr[1],
> > +		(unsigned long)regs.gpr[2], (unsigned long)regs.gpr[3]);
> 
> Presumably there's nothing stopping a 32-bit userland from creating a
> 64-bit guest?

Yes, that can be run.

> If that's the case should this all use unsigned long longs?

... and yes it creates wrong register dump.

Will fix this.

> > +	dprintf(debug_fd, "$4   : %016lx %016lx %016lx %016lx\n",
> > +		(unsigned long)regs.gpr[4], (unsigned long)regs.gpr[5],
> > +		(unsigned long)regs.gpr[6], (unsigned long)regs.gpr[7]);
> > +	dprintf(debug_fd, "$8   : %016lx %016lx %016lx %016lx\n",
> > +		(unsigned long)regs.gpr[8], (unsigned long)regs.gpr[9],
> > +		(unsigned long)regs.gpr[10], (unsigned long)regs.gpr[11]);
> > +	dprintf(debug_fd, "$12  : %016lx %016lx %016lx %016lx\n",
> > +		(unsigned long)regs.gpr[12], (unsigned long)regs.gpr[13],
> > +		(unsigned long)regs.gpr[14], (unsigned long)regs.gpr[15]);
> > +	dprintf(debug_fd, "$16  : %016lx %016lx %016lx %016lx\n",
> > +		(unsigned long)regs.gpr[16], (unsigned long)regs.gpr[17],
> > +		(unsigned long)regs.gpr[18], (unsigned long)regs.gpr[19]);
> > +	dprintf(debug_fd, "$20  : %016lx %016lx %016lx %016lx\n",
> > +		(unsigned long)regs.gpr[20], (unsigned long)regs.gpr[21],
> > +		(unsigned long)regs.gpr[22], (unsigned long)regs.gpr[23]);
> > +	dprintf(debug_fd, "$24  : %016lx %016lx %016lx %016lx\n",
> > +		(unsigned long)regs.gpr[24], (unsigned long)regs.gpr[25],
> > +		(unsigned long)regs.gpr[26], (unsigned long)regs.gpr[27]);
> > +	dprintf(debug_fd, "$28  : %016lx %016lx %016lx %016lx\n",
> > +		(unsigned long)regs.gpr[28], (unsigned long)regs.gpr[29],
> > +		(unsigned long)regs.gpr[30], (unsigned long)regs.gpr[31]);
> > +
> > +	dprintf(debug_fd, "hi   : %016lx\n", (unsigned long)regs.hi);
> > +	dprintf(debug_fd, "lo   : %016lx\n", (unsigned long)regs.lo);
> > +	dprintf(debug_fd, "epc  : %016lx\n", (unsigned long)regs.pc);
> > +
> > +	dprintf(debug_fd, "\n");
> > +}
> 
> Cheers
> James

Thanks,
Andreas
