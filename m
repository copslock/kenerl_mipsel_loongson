Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2011 21:53:32 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16779 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903723Ab1LHUx2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Dec 2011 21:53:28 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ee1241f0000>; Thu, 08 Dec 2011 12:54:55 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 8 Dec 2011 12:53:26 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 8 Dec 2011 12:53:26 -0800
Message-ID: <4EE123C6.5050703@cavium.com>
Date:   Thu, 08 Dec 2011 12:53:26 -0800
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     binutils <binutils@sourceware.org>, Alan Modra <amodra@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>,
        rdsandiford@googlemail.com
Subject: Re: [Patch]: Fix ld pr11138 FAILures on mips*.
References: <4EDD669F.30207@cavium.com> <20111206054018.GB21034@bubble.grove.modra.org> <8762ht2yft.fsf@firetop.home> <4EDE9373.4070707@cavium.com> <87liqm7qgr.fsf@firetop.home>
In-Reply-To: <87liqm7qgr.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2011 20:53:26.0605 (UTC) FILETIME=[6EB2B7D0:01CCB5EB]
X-archive-position: 32064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7087

On 12/08/2011 12:34 PM, Richard Sandiford wrote:
> David Daney<david.daney@cavium.com>  writes:
>>> There again, is this symbol (as opposed to the DT_MIPS_RLD_MAP tag)
>>> actually part of the ABI?  I can't find any reference to it in the
>>> original psABI, the SGI ELF64 spec, gdb or glibc.  If it's just an
>>> internal thing, maybe we could get rid of it altogether, or at least
>>> make it bind locally rather than globally.
>>>
>>
>> That is an option too I suppose.  I would say that it is part of a de
>> facto ABI if nothing else.  The question of weather anybody uses it it a
>> different question.  I thought boehm-gc may have used it, but I cannot
>> find it there now.
>
> Yeah, good point.  It occured to me rather belatedly that if wasn't
> part of the de facto ABI, it wouldn't have two distinct names...
>
> So if we were just doing this for the tag, the simplest way would have
> been to find the .rld_map section in _bfd_mips_elf_finish_dynamic_sections.
> But I agree that we should keep the symbol Just In Case.  So...
>
>> It might be possible to #define elf_backend_output_arch_local_syms and
>> then handle calculation of the rld_value value there instead.
>>
>> If this seems like a good approach, I can prepare and test a patch that
>> does that.
>
> ...how about caching the hash table entry for __rld_map/__RLD_MAP/
> __rld_obj_head in mips_elf_link_hash_entry, instead of rld_value.
> (One field shared by all three should be enough.)  We can then use
> that in _bfd_mips_elf_finish_dynamic_sections.
>
> The code to set sym->st_value in _bfd_mips_elf_finish_dynamic_symbol
> should already be redundant: the symbol is defined as being at the
> start of .rld_map by:
>
> 	  s = bfd_get_section_by_name (abfd, ".rld_map");
> 	  BFD_ASSERT (s != NULL);
>
> 	  name = SGI_COMPAT (abfd) ? "__rld_map" : "__RLD_MAP";
> 	  bh = NULL;
> 	  if (!(_bfd_generic_link_add_one_symbol
> 		(info, abfd, name, BSF_GLOBAL, s, 0, NULL, FALSE,
> 		 get_elf_backend_data (abfd)->collect,&bh)))
> 	    return FALSE;
>
> And the code to clear the first word should be redundant too, since
> _bfd_mips_elf_size_dynamic_sections uses bfd_zalloc to allocate the
> section's contents.

That's right, also elsewhere we set the size of the section to 4, which 
is not correct for ELF64 targets.

>  So if we do cache the hash table entry, the whole
> _bfd_mips_elf_finish_dynamic_symbol handling should become dead.
>
> Richard

Thanks Richard,

Those are all good ideas, so I think I will hack up a new patch to try 
and implement this plan.  Some care also needs to be taken for the SGI 
case as there the symbol seems to come from one of the input objects 
rather than being synthesized by the linker.

David Daney
