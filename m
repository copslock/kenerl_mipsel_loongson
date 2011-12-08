Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2011 21:34:25 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:53838 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903723Ab1LHUeV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Dec 2011 21:34:21 +0100
Received: by eaac10 with SMTP id c10so1670608eaa.36
        for <linux-mips@linux-mips.org>; Thu, 08 Dec 2011 12:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        bh=gfCgPFsEIYC4yOzBEmqt/460hMFac5y67Cf9urWWtOQ=;
        b=X+4ZuaWpV2MXJr2MLVPEwT4E3Vf75YsUlQXmX9vkUe1yQwhwPnWGVXCs4LzxYwIxk5
         5p3U7uA5miJrqaClhOC8U949f5Vz/8EATMe0Fqwwk3A6cBgv1Ns4Eks6LHbl4qpNaFuz
         m4iVh5RjCX/1YiGFyAkyNiBLoeip+07rZzf8M=
Received: by 10.213.114.3 with SMTP id c3mr325010ebq.146.1323376455976;
        Thu, 08 Dec 2011 12:34:15 -0800 (PST)
Received: from localhost (rsandifo.gotadsl.co.uk. [82.133.89.107])
        by mx.google.com with ESMTPS id 58sm21793725eet.11.2011.12.08.12.34.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 12:34:13 -0800 (PST)
From:   Richard Sandiford <rdsandiford@googlemail.com>
To:     David Daney <david.daney@cavium.com>
Mail-Followup-To: David Daney <david.daney@cavium.com>,binutils <binutils@sourceware.org>,  Alan Modra <amodra@gmail.com>,  linux-mips <linux-mips@linux-mips.org>,  Manuel Lauss <manuel.lauss@googlemail.com>,  Debian MIPS <debian-mips@lists.debian.org>, rdsandiford@googlemail.com
Cc:     binutils <binutils@sourceware.org>, Alan Modra <amodra@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>
Subject: Re: [Patch]: Fix ld pr11138 FAILures on mips*.
References: <4EDD669F.30207@cavium.com>
        <20111206054018.GB21034@bubble.grove.modra.org>
        <8762ht2yft.fsf@firetop.home> <4EDE9373.4070707@cavium.com>
Date:   Thu, 08 Dec 2011 20:34:12 +0000
In-Reply-To: <4EDE9373.4070707@cavium.com> (David Daney's message of "Tue, 06
        Dec 2011 14:13:07 -0800")
Message-ID: <87liqm7qgr.fsf@firetop.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-archive-position: 32063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7069

David Daney <david.daney@cavium.com> writes:
>> There again, is this symbol (as opposed to the DT_MIPS_RLD_MAP tag)
>> actually part of the ABI?  I can't find any reference to it in the
>> original psABI, the SGI ELF64 spec, gdb or glibc.  If it's just an
>> internal thing, maybe we could get rid of it altogether, or at least
>> make it bind locally rather than globally.
>>
>
> That is an option too I suppose.  I would say that it is part of a de 
> facto ABI if nothing else.  The question of weather anybody uses it it a 
> different question.  I thought boehm-gc may have used it, but I cannot 
> find it there now.

Yeah, good point.  It occured to me rather belatedly that if wasn't
part of the de facto ABI, it wouldn't have two distinct names...

So if we were just doing this for the tag, the simplest way would have
been to find the .rld_map section in _bfd_mips_elf_finish_dynamic_sections.
But I agree that we should keep the symbol Just In Case.  So...

> It might be possible to #define elf_backend_output_arch_local_syms and 
> then handle calculation of the rld_value value there instead.
>
> If this seems like a good approach, I can prepare and test a patch that 
> does that.

...how about caching the hash table entry for __rld_map/__RLD_MAP/
__rld_obj_head in mips_elf_link_hash_entry, instead of rld_value.
(One field shared by all three should be enough.)  We can then use
that in _bfd_mips_elf_finish_dynamic_sections.

The code to set sym->st_value in _bfd_mips_elf_finish_dynamic_symbol
should already be redundant: the symbol is defined as being at the
start of .rld_map by:

	  s = bfd_get_section_by_name (abfd, ".rld_map");
	  BFD_ASSERT (s != NULL);

	  name = SGI_COMPAT (abfd) ? "__rld_map" : "__RLD_MAP";
	  bh = NULL;
	  if (!(_bfd_generic_link_add_one_symbol
		(info, abfd, name, BSF_GLOBAL, s, 0, NULL, FALSE,
		 get_elf_backend_data (abfd)->collect, &bh)))
	    return FALSE;

And the code to clear the first word should be redundant too, since
_bfd_mips_elf_size_dynamic_sections uses bfd_zalloc to allocate the
section's contents.  So if we do cache the hash table entry, the whole
_bfd_mips_elf_finish_dynamic_symbol handling should become dead.

Richard
