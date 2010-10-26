Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Oct 2010 15:36:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41758 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491108Ab0JZNgS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Oct 2010 15:36:18 +0200
Date:   Tue, 26 Oct 2010 14:36:18 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     John Reiser <jreiser@bitwagon.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        wu zhangjin <wuzhangjin@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: patch v2: [RFC 2/2] ftrace/MIPS: Add support for C version of
 recordmcount
In-Reply-To: <4CC5B474.9050503@bitwagon.com>
Message-ID: <alpine.LFD.2.00.1010261409190.15889@eddie.linux-mips.org>
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com> <4CC49A99.1080601@bitwagon.com> <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org> <4CC5B474.9050503@bitwagon.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 25 Oct 2010, John Reiser wrote:

> Here's a second try [discard the first] for handling MIPS64 in recordmcount.[ch].

 Thanks for your contribution -- I appreciate it as undoubtedly do the 
others -- no need to feel frustrated. :)

 Please note that the unusual relocation format comes from the fact the 
MIPS n64 ABI supplement was developed before the ELF64 gABI was finalised 
-- no surprise here given MIPS processors were the first 64-bit around.  
Then the gABI took a more generic approach to handle compound relocations.  
Even `readelf' you cited only got it right as recently as in 2005 (BFD was 
OK from the beginning though AFAIR, so code generated as well as e.g. 
`objdump' reports were right).

 Your change looks good to me overall (I haven't tried building or running 
it -- I take your word you've got it right).  I have a small nit though -- 
see below.

> +typedef unsigned char myElf64_byte;
> +typedef struct {
> +	Elf64_Addr    r_offset;               /* Address */
> +	struct {
> +		Elf64_Word r_sym;
> +		myElf64_byte r_ssym;  /* Special sym: gp-relative, etc. */
> +		myElf64_byte r_type3;
> +		myElf64_byte r_type2;
> +		myElf64_byte r_type;
> +	} r_info;
> +	Elf64_Sxword  r_addend;               /* Addend */
> +} MIPS64_Rela;
> +
> +static uint64_t MIPS64_r_sym(Elf64_Rel const *rp)
> +{
> +	return w(((MIPS64_Rela const *)rp)->r_info.r_sym);
> +}
> +
> +static void MIPS64_r_info(Elf64_Rel *const rp, unsigned sym, unsigned type)
> +{
> +	MIPS64_Rela *const m64rp = (MIPS64_Rela *)rp;
> +	m64rp->r_info.r_sym = w(sym);
> +	m64rp->r_info.r_ssym = 0;
> +	m64rp->r_info.r_type3 = 0;
> +	m64rp->r_info.r_type2 = 0;
> +	m64rp->r_info.r_type = type;
> +}

 Please try and avoid type punning, i.e. use a union to switch between the 
gABI format of r_info and the n64 MIPS psABI variation.  You'll avoid the 
risk of GCC doing weird stuff wrt aliasing.

 Thanks,

  Maciej
