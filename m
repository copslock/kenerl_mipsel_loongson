Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2014 15:38:13 +0200 (CEST)
Received: from mail-ee0-f47.google.com ([74.125.83.47]:46154 "EHLO
        mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818711AbaESNiHRtP40 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 May 2014 15:38:07 +0200
Received: by mail-ee0-f47.google.com with SMTP id c13so3624045eek.6
        for <linux-mips@linux-mips.org>; Mon, 19 May 2014 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NFled3Gyj5d1+37CRm5BDwYeiftgoaVEE7nNoDTnR+I=;
        b=IJly6xs3lyeiikhSx+KMLKEEx9ZzFFUgBp10WZ1hatcPEWoXnAWrGPCPvCZV0sHiat
         8ifyhcLuwBcgdRHHdZI/HHSn2DSOcJlMfah46pJMJTnAgKl4m0ApxQt/3QhFv2hbjqsv
         0UTWksmo/OUf7ZkXbO9uZ88g9yVboSYyTDe8ETb2WLgDZy9ETT2/NhQ+MyuomnA06U15
         N+6thTyl0+s2quWTm/ulAfi1JnWYoSD/KW/oR0/Z52x668V2b4o0s00Olu4WW2peoq+T
         Cmp7iP4B1CAEXViONJzW7L2XubyoAhp3LsydkHjgtoHnaBqGnvyc+RkMiyItvpyzTLH6
         5WvA==
X-Received: by 10.15.48.65 with SMTP id g41mr2639212eew.6.1400506680669;
        Mon, 19 May 2014 06:38:00 -0700 (PDT)
Received: from alberich ([46.78.192.208])
        by mx.google.com with ESMTPSA id a45sm42036527eez.2.2014.05.19.06.37.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 May 2014 06:38:00 -0700 (PDT)
Date:   Mon, 19 May 2014 15:37:56 +0200
From:   Andreas Herrmann <herrmann.der.user@googlemail.com>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 05/11] kvm tools, mips: Add MIPS support
Message-ID: <20140519133756.GA23153@alberich>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1399391491-5021-6-git-send-email-andreas.herrmann@caviumnetworks.com>
 <536D4571.6010302@imgtec.com>
 <20140512130110.GA17255@alberich>
 <5370D636.3020903@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5370D636.3020903@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herrmann.der.user@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40137
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

On Mon, May 12, 2014 at 03:09:58PM +0100, James Hogan wrote:
> Hi Andreas,
> 
> On 12/05/14 14:01, Andreas Herrmann wrote:
> > On Fri, May 09, 2014 at 10:15:29PM +0100, James Hogan wrote:
> >> On 06/05/14 16:51, Andreas Herrmann wrote:
> >>> +static bool kvm_cpu__hypercall_write_cons(struct kvm_cpu *vcpu)
> >>> +{
> >>> +	int term = (int)vcpu->kvm_run->hypercall.args[0];
> >>> +	u64 addr = vcpu->kvm_run->hypercall.args[1];
> >>> +	int len = (int)vcpu->kvm_run->hypercall.args[2];
> >>> +	char *host_addr;
> >>> +
> >>> +	if (term < 0 || term >= TERM_MAX_DEVS) {
> >>> +		pr_warning("hypercall_write_cons term out of range <%d>", term);
> >>> +		return false;
> >>> +	}
> >>> +	if (len <= 0) {
> >>> +		pr_warning("hypercall_write_cons len out of range <%d>", len);
> >>> +		return false;
> >>> +	}
> >>> +
> >>> +	if ((addr & 0xffffffffc0000000ull) == 0xffffffff80000000ull)
> >>> +		addr &= 0x1ffffffful; /* Convert KSEG{0,1} to physical. */
> >>> +	if ((addr & 0xc000000000000000ull) == 0x8000000000000000ull)
> >>> +		addr &= 0x07ffffffffffffffull; /* Convert XKPHYS to pysical */
> >>> +
> >>> +	host_addr = guest_flat_to_host(vcpu->kvm, addr);
> >>> +	if (!host_addr) {
> >>> +		pr_warning("hypercall_write_cons unmapped physaddr %llx", (unsigned long long)addr);
> >>> +		return false;
> >>> +	}
> >>> +
> >>> +	term_putc(host_addr, len, term);
> >>
> >> Does len need to be range checked?
> > 
> > len <= 0 is checked above.
> > I don't think an upper boundery check is required.
> > term_putc (using write) should be able to handle it.
> > No?
> 
> Well it looks to me from my naive look at the code (my experience with
> tools/kvm/ is pretty much just reading some of the code after looking at
> this patchset) like the guest could provide a very large positive len
> argument and overflow the host_addr of the memory bank, possibly reading
> into other userspace memory which would then get written to the console.
> Yes, if it's unmapped the kernel will detect it so it's not so bad (no
> seg faults). I guess it all depends how any memory that is passed to
> kvm__register_mem was allocated. mmap_anon_or_hugetlbfs may use mmap
> which leaves the possibility open of another virtual mapping being
> created immediately after it.
> 
> AFAICT the best way to avoid that is probably to somehow extend
> guest_flat_to_host to provide the address limit too so the provided
> length can be checked/clipped, or maybe call it for the end address too
> to check the full range is valid and belongs to the same mapping,
> although that's a bit more of a hack and technically isn't watertight!
> 
> Maybe I'm being paranoid though :)

I aggree that also the upper bound should be checked.

I think extending the len check with something like

 "|| !host_ptr_in_ram(vcpu->kvm,host_addr + len)"

should do it.


Thanks,
Andreas
