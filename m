Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2011 21:20:21 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16199 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903633Ab1LFUUR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Dec 2011 21:20:17 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ede79570000>; Tue, 06 Dec 2011 12:21:43 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 6 Dec 2011 12:20:14 -0800
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 6 Dec 2011 12:20:14 -0800
Message-ID: <4EDE78FE.2050509@cavium.com>
Date:   Tue, 06 Dec 2011 12:20:14 -0800
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     binutils <binutils@sourceware.org>
CC:     linux-mips <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Debian MIPS <debian-mips@lists.debian.org>
Subject: Re: [Patch]: Fix ld pr11138 FAILures on mips*.
References: <4EDD669F.30207@cavium.com> <20111206054018.GB21034@bubble.grove.modra.org>
In-Reply-To: <20111206054018.GB21034@bubble.grove.modra.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2011 20:20:14.0912 (UTC) FILETIME=[76BAFC00:01CCB454]
X-archive-position: 32045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4951

On 12/05/2011 09:40 PM, Alan Modra wrote:
> On Mon, Dec 05, 2011 at 04:49:35PM -0800, David Daney wrote:
>> The root cause of this is that the mips linker synthesizes a special
>> symbol "__RLD_MAP", and then sets MIPS_RLD_MAP to point to it.  When
>> a version script is present, this symbol gets versioned along with
>> all the rest, and when it is time to take its address, the symbol
>> can no longer be found as it has had version information appended to
>> its name.
>
> Why not just change
>
> 	&&  (strcmp (name, "__rld_map") == 0
> 	      || strcmp (name, "__RLD_MAP") == 0))
>
> to
>
> 	&&  (strncmp (name, "__rld_map", 9) == 0
> 	      || strncmp (name, "__RLD_MAP", 9) == 0))
>
> in _bfd_mips_elf_finish_dynamic_symbol?  Perhaps the same for other
> syms there too?

Because that doesn't work.  Perhpas I should have been a bit more 
detailed in my description of what is happening (at least in one case).

If the version script contains something like:
{
         global: main;
         local: *;
};

Then "__RLD_MAP" gets hidden and we never see it in 
_bfd_mips_elf_finish_dynamic_symbol().

This hiding gets done precisely in  _bfd_elf_link_assign_sym_version() 
after the version information is calculated.  So as the patch stands, we 
bail out of _bfd_elf_link_assign_sym_version() before the symbol is 
hidden (or modified in any way).

It is possible that 'no_sym_version' is not the best name for the flag, 
but I think we really some sort of flag to exclude ABI symbols from 
being mangled in _bfd_elf_link_assign_sym_version().

David Daney
