Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2008 21:20:41 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:45465 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22764054AbYJ3VUf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Oct 2008 21:20:35 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B490a24860000>; Thu, 30 Oct 2008 17:18:03 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Oct 2008 14:17:53 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Oct 2008 14:17:52 -0700
Message-ID: <490A2480.1010404@caviumnetworks.com>
Date:	Thu, 30 Oct 2008 14:17:52 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 04/36] Add Cavium OCTEON processor support files to	arch/mips/mm.
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <20081029160710.GB26256@linux-mips.org>
In-Reply-To: <20081029160710.GB26256@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2008 21:17:52.0855 (UTC) FILETIME=[F8363670:01C93AD4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Oct 27, 2008 at 05:02:36PM -0700, David Daney wrote:
[...]
>> +static void octeon_flush_icache_all_cores(struct vm_area_struct *vma)
>> +{
>> +	extern struct plat_smp_ops *mp_ops;	/* private */
>> +#ifdef CONFIG_SMP
>> +	int i;
>> +	int cpu;
>> +#endif
>> +
>> +	preempt_disable();
>> +#ifdef CONFIG_SMP
>> +	cpu = smp_processor_id();
>> +#endif
>> +	mb();
>> +
>> +	/* If we have a vma structure, we only need to worry about cores it
>> +	   has been used on */
>> +	if (vma) {
>> +#ifdef CONFIG_SMP
>> +		for (i = 0; i < NR_CPUS; i++)
>> +			if (cpu_isset(i, vma->vm_mm->cpu_vm_mask) && i != cpu)
>> +				mp_ops->send_ipi_single(i, SMP_ICACHE_FLUSH);
>> +#endif
>> +		asm volatile ("synci 0($0)\n");
>> +	} else {
>> +		/* No extra info available. Flush the icache on all cores that
>> +		   are online */
>> +#ifdef CONFIG_SMP
>> +		for (i = 0; i < NR_CPUS; i++)
>> +			if (cpu_online(i) && i != cpu)
>> +				mp_ops->send_ipi_single(i, SMP_ICACHE_FLUSH);
>> +#endif
>> +		asm volatile ("synci 0($0)\n");
>> +	}
> 
> You can avoid the entire #ifdef CONFIG_SMP mess with for_each_online_cpu().
> 
> For some workloads IPIs can be performance limiting.  You can avoid them
> entirely if the mm that is being flush out of the CPU is not active on the
> remote processor by simply setting the remote's context for that mm to
> zero.  This means the remote CPU will allocate a new context.  That's a
> matter of a few instructions as long as the remote's ASID counter doesn't
> overflow that is 255 out of 256 times.
> 
> The price to pay is to accept that both the vtag'ed I-cache and the TLB
> of the remote need to be reloaded which seems relativly harmless compared
> to the alternatives.
> 

Unfortunately, I don't think that will work.  In order to do the 
optimization you must check some things in the mm.  To do this in a race 
free manner, you need to hold the mmap_sem.  flush_icache_all is 
sometimes called without acquiring the mmap_sem, and I have not figured 
out how to acquire it in such a manner that the system doesn't crash.

David Daney
