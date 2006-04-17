Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 13:41:45 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:44510 "HELO bender.bawue.de")
	by ftp.linux-mips.org with SMTP id S8133448AbWDQMlf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2006 13:41:35 +0100
Received: from lagash (88-106-238-34.dynamic.dsl.as9105.com [88.106.238.34])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 298F944EE4; Mon, 17 Apr 2006 14:53:59 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.61)
	(envelope-from <ths@networkno.de>)
	id 1FVTEc-00048m-G0; Mon, 17 Apr 2006 13:53:42 +0100
Date:	Mon, 17 Apr 2006 13:53:32 +0100
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
Message-ID: <20060417125332.GB28935@networkno.de>
References: <20060417.210039.95063383.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060417.210039.95063383.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.11+cvs20060403
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
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

This doesn't look right. ELF64_R_SYM/ELF64_R_TYPE should be fixed for
mips64 instead.


Thiemo
