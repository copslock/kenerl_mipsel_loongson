Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2009 16:25:03 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4327 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022631AbZEDPY5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2009 16:24:57 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ff08aa0000>; Mon, 04 May 2009 11:24:26 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 May 2009 08:24:28 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 4 May 2009 08:24:28 -0700
Message-ID: <49FF08AC.3030901@caviumnetworks.com>
Date:	Mon, 04 May 2009 08:24:28 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Sam Ravnborg <sam@ravnborg.org>
CC:	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Anders Kaseorg <andersk@mit.edu>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Lots of unexpected non-allocatable section warnings
References: <20090503110517.6d09bca2@hyperion.delvare> <20090503103010.GA27978@uranus.ravnborg.org> <20090503124848.276b437f@hyperion.delvare> <20090503180332.GA31820@uranus.ravnborg.org> <20090503202939.GA1237@uranus.ravnborg.org> <20090504082816.GA25378@roarinelk.homelinux.net> <20090504094928.GA6157@uranus.ravnborg.org>
In-Reply-To: <20090504094928.GA6157@uranus.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 May 2009 15:24:28.0438 (UTC) FILETIME=[6A3A7360:01C9CCCC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Sam Ravnborg wrote:

> From: Anders Kaseorg <andersk@MIT.EDU>
> Date: Sun, 3 May 2009 22:02:55 +0200
> Subject: [PATCH 1/2] kbuild, modpost: fix unexpected non-allocatable section when cross compiling
> 
> The missing TO_NATIVE(sechdrs[i].sh_flags) was causing many
> unexpected non-allocatable section warnings when cross-compiling
> for an architecture with a different endianness.
> 
> Fix endianness of all the fields in the ELF header and
> section headers, not just some of them so we are not
> hit by this anohter time.
> 
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> Reported-by: Sean MacLennan <smaclennan@pikatech.com>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: David Daney <ddaney@caviumnetworks.com>

This is essentially what I did in my local tree to fix the problems.


> ---
>  scripts/mod/modpost.c |   35 +++++++++++++++++++++++------------
>  1 files changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 936b6f8..a5c17db 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -384,11 +384,19 @@ static int parse_elf(struct elf_info *info, const char *filename)
>  		return 0;
>  	}
>  	/* Fix endianness in ELF header */
> -	hdr->e_shoff    = TO_NATIVE(hdr->e_shoff);
> -	hdr->e_shstrndx = TO_NATIVE(hdr->e_shstrndx);
> -	hdr->e_shnum    = TO_NATIVE(hdr->e_shnum);
> -	hdr->e_machine  = TO_NATIVE(hdr->e_machine);
> -	hdr->e_type     = TO_NATIVE(hdr->e_type);
> +	hdr->e_type      = TO_NATIVE(hdr->e_type);
> +	hdr->e_machine   = TO_NATIVE(hdr->e_machine);
> +	hdr->e_version   = TO_NATIVE(hdr->e_version);
> +	hdr->e_entry     = TO_NATIVE(hdr->e_entry);
> +	hdr->e_phoff     = TO_NATIVE(hdr->e_phoff);
> +	hdr->e_shoff     = TO_NATIVE(hdr->e_shoff);
> +	hdr->e_flags     = TO_NATIVE(hdr->e_flags);
> +	hdr->e_ehsize    = TO_NATIVE(hdr->e_ehsize);
> +	hdr->e_phentsize = TO_NATIVE(hdr->e_phentsize);
> +	hdr->e_phnum     = TO_NATIVE(hdr->e_phnum);
> +	hdr->e_shentsize = TO_NATIVE(hdr->e_shentsize);
> +	hdr->e_shnum     = TO_NATIVE(hdr->e_shnum);
> +	hdr->e_shstrndx  = TO_NATIVE(hdr->e_shstrndx);
>  	sechdrs = (void *)hdr + hdr->e_shoff;
>  	info->sechdrs = sechdrs;
>  
> @@ -402,13 +410,16 @@ static int parse_elf(struct elf_info *info, const char *filename)
>  
>  	/* Fix endianness in section headers */
>  	for (i = 0; i < hdr->e_shnum; i++) {
> -		sechdrs[i].sh_type   = TO_NATIVE(sechdrs[i].sh_type);
> -		sechdrs[i].sh_offset = TO_NATIVE(sechdrs[i].sh_offset);
> -		sechdrs[i].sh_size   = TO_NATIVE(sechdrs[i].sh_size);
> -		sechdrs[i].sh_link   = TO_NATIVE(sechdrs[i].sh_link);
> -		sechdrs[i].sh_name   = TO_NATIVE(sechdrs[i].sh_name);
> -		sechdrs[i].sh_info   = TO_NATIVE(sechdrs[i].sh_info);
> -		sechdrs[i].sh_addr   = TO_NATIVE(sechdrs[i].sh_addr);
> +		sechdrs[i].sh_name      = TO_NATIVE(sechdrs[i].sh_name);
> +		sechdrs[i].sh_type      = TO_NATIVE(sechdrs[i].sh_type);
> +		sechdrs[i].sh_flags     = TO_NATIVE(sechdrs[i].sh_flags);
> +		sechdrs[i].sh_addr      = TO_NATIVE(sechdrs[i].sh_addr);
> +		sechdrs[i].sh_offset    = TO_NATIVE(sechdrs[i].sh_offset);
> +		sechdrs[i].sh_size      = TO_NATIVE(sechdrs[i].sh_size);
> +		sechdrs[i].sh_link      = TO_NATIVE(sechdrs[i].sh_link);
> +		sechdrs[i].sh_info      = TO_NATIVE(sechdrs[i].sh_info);
> +		sechdrs[i].sh_addralign = TO_NATIVE(sechdrs[i].sh_addralign);
> +		sechdrs[i].sh_entsize   = TO_NATIVE(sechdrs[i].sh_entsize);
>  	}
>  	/* Find symbol table. */
>  	for (i = 1; i < hdr->e_shnum; i++) {
