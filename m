Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 14:28:01 +0100 (BST)
Received: from pasmtp.tele.dk ([193.162.159.95]:48396 "HELO pasmtp.tele.dk")
	by ftp.linux-mips.org with SMTP id S8133588AbWDQN1w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2006 14:27:52 +0100
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id 2F01E1EC308;
	Mon, 17 Apr 2006 15:40:07 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 88A6943C21C; Mon, 17 Apr 2006 15:40:05 +0200 (CEST)
Date:	Mon, 17 Apr 2006 15:40:05 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
Message-ID: <20060417134005.GA13304@mars.ravnborg.org>
References: <20060417.210039.95063383.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060417.210039.95063383.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.11
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 17, 2006 at 09:00:39PM +0900, Atsushi Nemoto wrote:
> 64bit mips has different r_info layout.  This patch fixes modpost
> segfault for 64bit little endian mips kernel.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index cd00e9f..7846600 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -712,7 +712,13 @@ static void check_sec_ref(struct module 
>  			r.r_offset = TO_NATIVE(rela->r_offset);
>  			r.r_info   = TO_NATIVE(rela->r_info);
>  			r.r_addend = TO_NATIVE(rela->r_addend);
> +#if KERNEL_ELFCLASS == ELFCLASS64 && KERNEL_ELFDATA == ELFDATA2LSB
> +			sym = elf->symtab_start +
> +				(hdr->e_machine == EM_MIPS ?
> +				 (Elf32_Word)r.r_info : ELF_R_SYM(r.r_info));
> +#else
>  			sym = elf->symtab_start + ELF_R_SYM(r.r_info);
> +#endif
>  			/* Skip special sections */
>  			if (sym->st_shndx >= SHN_LORESERVE)
>  				continue;

Hi Atsushi

So with 64bit mips with the above we read r.r_info with no
modifications. But the elf.h I have on my system looks like this:

/* How to extract and insert information held in the r_info field.  */

#define ELF32_R_SYM(val)                ((val) >> 8)
#define ELF32_R_TYPE(val)               ((val) & 0xff)
#define ELF32_R_INFO(sym, type)         (((sym) << 8) + ((type) & 0xff))

#define ELF64_R_SYM(i)                  ((i) >> 32)
#define ELF64_R_TYPE(i)                 ((i) & 0xffffffff)
#define ELF64_R_INFO(sym,type)          ((((Elf64_Xword) (sym)) << 32) + (type))

So the difference between 64bit and 32bit is only the number of right
shifts.

Maybe we need to do some simple range check also so it becomes:
	if ((sym->st_shndx >= SHN_LORESERVE) || (sym > elf->symtab_stop))
		continue;

Could you try this - and if you still see the SEGVAL then try to print
out the value of all members in 'r'.

You can also try to add '-g' to HOSTCFLAGS in toplevel makefile.
Then use make V=1 to see what arguments modpost is caleld with and call
it from the commandline or from a debugger.

	Sam
