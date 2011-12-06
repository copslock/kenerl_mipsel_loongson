Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2011 23:13:16 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1707 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903545Ab1LFWNJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Dec 2011 23:13:09 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ede93cb0002>; Tue, 06 Dec 2011 14:14:35 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 6 Dec 2011 14:13:07 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 6 Dec 2011 14:13:07 -0800
Message-ID: <4EDE9373.4070707@cavium.com>
Date:   Tue, 06 Dec 2011 14:13:07 -0800
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     binutils <binutils@sourceware.org>, rdsandiford@googlemail.com,
        Alan Modra <amodra@gmail.com>
CC:     linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>
Subject: Re: [Patch]: Fix ld pr11138 FAILures on mips*.
References: <4EDD669F.30207@cavium.com> <20111206054018.GB21034@bubble.grove.modra.org> <8762ht2yft.fsf@firetop.home>
In-Reply-To: <8762ht2yft.fsf@firetop.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2011 22:13:07.0431 (UTC) FILETIME=[3B775F70:01CCB464]
X-archive-position: 32048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 5061

On 12/06/2011 01:16 PM, Richard Sandiford wrote:
> Alan Modra<amodra@gmail.com>  writes:
>> On Mon, Dec 05, 2011 at 04:49:35PM -0800, David Daney wrote:
>>> The root cause of this is that the mips linker synthesizes a special
>>> symbol "__RLD_MAP", and then sets MIPS_RLD_MAP to point to it.  When
>>> a version script is present, this symbol gets versioned along with
>>> all the rest, and when it is time to take its address, the symbol
>>> can no longer be found as it has had version information appended to
>>> its name.
>>
>> Why not just change
>>
>> 	&&  (strcmp (name, "__rld_map") == 0
>> 	      || strcmp (name, "__RLD_MAP") == 0))
>>
>> to
>>
>> 	&&  (strncmp (name, "__rld_map", 9) == 0
>> 	      || strncmp (name, "__RLD_MAP", 9) == 0))
>>
>> in _bfd_mips_elf_finish_dynamic_symbol?  Perhaps the same for other
>> syms there too?
>
> Showing my ignorance here,

I don't buy it, you are probably the most knowledgeable about this.

> but is that the usual behaviour for this kind
> of thing?  I wouldn't have expected versions to apply to internally-created
> symbols.

Yes, that is what I was trying to accomplish.

>
> There again, is this symbol (as opposed to the DT_MIPS_RLD_MAP tag)
> actually part of the ABI?  I can't find any reference to it in the
> original psABI, the SGI ELF64 spec, gdb or glibc.  If it's just an
> internal thing, maybe we could get rid of it altogether, or at least
> make it bind locally rather than globally.
>

That is an option too I suppose.  I would say that it is part of a de 
facto ABI if nothing else.  The question of weather anybody uses it it a 
different question.  I thought boehm-gc may have used it, but I cannot 
find it there now.

I don't know for sure why the symbol was created, but it seems like it 
may just be for the side effect of having 
_bfd_mips_elf_finish_dynamic_symbol() called.  This lets us determine 
mips_elf_hash_table(info)->rld_value at a time when the output sections 
have already been laid out.

It might be possible to #define elf_backend_output_arch_local_syms and 
then handle calculation of the rld_value value there instead.

If this seems like a good approach, I can prepare and test a patch that 
does that.

David Daney
