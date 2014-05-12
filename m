Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2014 16:10:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47817 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822271AbaELOKG5KclN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 May 2014 16:10:06 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 78630CA916DE1;
        Mon, 12 May 2014 15:09:56 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 12 May 2014 15:09:59 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 12 May
 2014 15:09:58 +0100
Message-ID: <5370D636.3020903@imgtec.com>
Date:   Mon, 12 May 2014 15:09:58 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <herrmann.der.user@googlemail.com>
CC:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 05/11] kvm tools, mips: Add MIPS support
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1399391491-5021-6-git-send-email-andreas.herrmann@caviumnetworks.com> <536D4571.6010302@imgtec.com> <20140512130110.GA17255@alberich>
In-Reply-To: <20140512130110.GA17255@alberich>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40084
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

On 12/05/14 14:01, Andreas Herrmann wrote:
> On Fri, May 09, 2014 at 10:15:29PM +0100, James Hogan wrote:
>> On 06/05/14 16:51, Andreas Herrmann wrote:
>>> +static bool kvm_cpu__hypercall_write_cons(struct kvm_cpu *vcpu)
>>> +{
>>> +	int term = (int)vcpu->kvm_run->hypercall.args[0];
>>> +	u64 addr = vcpu->kvm_run->hypercall.args[1];
>>> +	int len = (int)vcpu->kvm_run->hypercall.args[2];
>>> +	char *host_addr;
>>> +
>>> +	if (term < 0 || term >= TERM_MAX_DEVS) {
>>> +		pr_warning("hypercall_write_cons term out of range <%d>", term);
>>> +		return false;
>>> +	}
>>> +	if (len <= 0) {
>>> +		pr_warning("hypercall_write_cons len out of range <%d>", len);
>>> +		return false;
>>> +	}
>>> +
>>> +	if ((addr & 0xffffffffc0000000ull) == 0xffffffff80000000ull)
>>> +		addr &= 0x1ffffffful; /* Convert KSEG{0,1} to physical. */
>>> +	if ((addr & 0xc000000000000000ull) == 0x8000000000000000ull)
>>> +		addr &= 0x07ffffffffffffffull; /* Convert XKPHYS to pysical */
>>> +
>>> +	host_addr = guest_flat_to_host(vcpu->kvm, addr);
>>> +	if (!host_addr) {
>>> +		pr_warning("hypercall_write_cons unmapped physaddr %llx", (unsigned long long)addr);
>>> +		return false;
>>> +	}
>>> +
>>> +	term_putc(host_addr, len, term);
>>
>> Does len need to be range checked?
> 
> len <= 0 is checked above.
> I don't think an upper boundery check is required.
> term_putc (using write) should be able to handle it.
> No?

Well it looks to me from my naive look at the code (my experience with
tools/kvm/ is pretty much just reading some of the code after looking at
this patchset) like the guest could provide a very large positive len
argument and overflow the host_addr of the memory bank, possibly reading
into other userspace memory which would then get written to the console.
Yes, if it's unmapped the kernel will detect it so it's not so bad (no
seg faults). I guess it all depends how any memory that is passed to
kvm__register_mem was allocated. mmap_anon_or_hugetlbfs may use mmap
which leaves the possibility open of another virtual mapping being
created immediately after it.

AFAICT the best way to avoid that is probably to somehow extend
guest_flat_to_host to provide the address limit too so the provided
length can be checked/clipped, or maybe call it for the end address too
to check the full range is valid and belongs to the same mapping,
although that's a bit more of a hack and technically isn't watertight!

Maybe I'm being paranoid though :)

Cheers
James
