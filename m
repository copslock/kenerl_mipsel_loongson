Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Oct 2011 19:17:37 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1094 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491179Ab1JJRRU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Oct 2011 19:17:20 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e9328eb0000>; Mon, 10 Oct 2011 10:18:35 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 10 Oct 2011 10:17:17 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 10 Oct 2011 10:17:17 -0700
Message-ID: <4E932897.9050301@cavium.com>
Date:   Mon, 10 Oct 2011 10:17:11 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Hillf Danton <dhillf@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>
Subject: Re: [RFC] Flush huge TLB
References: <CAJd=RBBPd6frOA5zCg5juHuWdZ6wHzmOhhufgGhUCOc=rkNEzA@mail.gmail.com>
In-Reply-To: <CAJd=RBBPd6frOA5zCg5juHuWdZ6wHzmOhhufgGhUCOc=rkNEzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2011 17:17:17.0108 (UTC) FILETIME=[75E74740:01CC8770]
X-archive-position: 31215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6475

On 10/09/2011 05:53 AM, Hillf Danton wrote:
> When flushing TLB, if @vma is backed by huge page, huge TLB should be flushed,
> due to the fact that huge page is defined to be far from normal page, and the
> flushing is shorten a bit.
>
> Any comment is welcome.
>

Note that the current implementation works, but is not optimal.

> Thanks
>
> Signed-off-by: Hillf Danton<dhillf@gmail.com>
> ---
>
> --- a/arch/mips/mm/tlb-r4k.c	Mon May 30 21:17:04 2011
> +++ b/arch/mips/mm/tlb-r4k.c	Sun Oct  9 20:50:06 2011
> @@ -120,22 +120,35 @@ void local_flush_tlb_range(struct vm_are
>
>   	if (cpu_context(cpu, mm) != 0) {
>   		unsigned long size, flags;
> +		int huge = is_vm_hugetlb_page(vma);
>
>   		ENTER_CRITICAL(flags);
> -		size = (end - start + (PAGE_SIZE - 1))>>  PAGE_SHIFT;
> -		size = (size + 1)>>  1;
> +		if (huge) {
> +			size = (end - start) / HPAGE_SIZE;
 > +		} else {
 > +			size = (end - start + (PAGE_SIZE - 1))>>  PAGE_SHIFT;
 > +			size = (size + 1)>>  1;
 > +		}

Perhaps:
	if (huge) {
		start = round_down(start, HPAGE_SIZE);
		end = round_up(start, HPAGE_SIZE);
		size = (end - start) >> HPAGE_SHIFT;
	} else {
		start = round_down(start, PAGE_SIZE << 1);
		end = round_up(start, PAGE_SIZE << 1);
		size = (end - start) >> (PAGE_SHIFT + 1);
	}
.
.
.

>   		if (size<= current_cpu_data.tlbsize/2) {

Has anybody benchmarked this heuristic?  I guess it seems reasonable.

>   			int oldpid = read_c0_entryhi();
>   			int newpid = cpu_asid(cpu, mm);
>
> -			start&= (PAGE_MASK<<  1);
> -			end += ((PAGE_SIZE<<  1) - 1);
> -			end&= (PAGE_MASK<<  1);
> +			if (huge) {
> +				start&= HPAGE_MASK;
> +				end&= HPAGE_MASK;
> +			} else {
> +				start&= (PAGE_MASK<<  1);
> +				end += ((PAGE_SIZE<<  1) - 1);
> +				end&= (PAGE_MASK<<  1);
> +			}

This stuff is done above so is removed.


>   			while (start<  end) {
>   				int idx;
>
>   				write_c0_entryhi(start | newpid);
> -				start += (PAGE_SIZE<<  1);
> +				if (huge)
> +					start += HPAGE_SIZE;
> +				else
> +					start += (PAGE_SIZE<<  1);
>   				mtc0_tlbw_hazard();
>   				tlb_probe();
>   				tlb_probe_hazard();
>
>

If we do something like that, then...

Acked-by: David Daney <david.daney@cavium.com>
