Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 05:59:09 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48160 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490949Ab0JYD7D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 05:59:03 +0200
Date:   Mon, 25 Oct 2010 04:59:03 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     John Reiser <jreiser@bitwagon.com>
cc:     wu zhangjin <wuzhangjin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: patch: [RFC 2/2] ftrace/MIPS: Add support for C version of
 recordmcount
In-Reply-To: <4CC49A99.1080601@bitwagon.com>
Message-ID: <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org>
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com> <4CC49A99.1080601@bitwagon.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 24 Oct 2010, John Reiser wrote:

> @@ -212,11 +212,26 @@ is_mcounted_section_name(char const *const txtname)
>  		0 == strcmp(".text.unlikely", txtname);
>  }
>  +
>  /* 32 bit and 64 bit are very similar */
>  #include "recordmcount.h"
>  #define RECORD_MCOUNT_64
>  #include "recordmcount.h"
> +/* 64-bit EM_MIPS has weird ELF64_Rela.r_info */
> +static uint64_t MIPS64_r_sym(Elf64_Xword xword)
> +{
> +	/* Perhaps this should be 40 bits, but kernel isn't that big. */
> +	return 0xffffffff & xword;
> +}

 R_SYM is 32-bit on n64 MIPS, no need for the comment here.  This code 
looks wrong to me though (i.e. asssuming xword is the integer value of 
r_info), see below.

> +static uint64_t MIPS64_r_info(Elf64_Xword sym, unsigned type)
> +{
> +	/* Type2 and Type3 are assumed zero.  [See "readelf --relocs".] */
> +	return (((uint64_t)type)<<56) | sym;
> +}

 On n64 MIPS the bit alignment of the r_sym and r_type fields within a 
native 64-bit integer depends on the endianness of the target.  You need 
to take this into account.

 Note that on n64 MIPS R_INFO effectively is defined like this:

struct {
	Elf64_Word r_sym;
	Elf64_Byte r_ssym;
	Elf64_Byte r_type3;
	Elf64_Byte r_type2;
	Elf64_Byte r_type;
} r_info;

i.e. R_SYM is always a 32-bit value in the native endianness and it's 
followed by four bytes whose order is the same regardless of the system's 
endianness.  Search the web for SGI's "64-bit ELF Object File 
Specification" for further details.

[I wish people read the specs and did not rely on guesswork before writing 
code like this, sigh...]

  Maciej
