Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Apr 2006 16:34:42 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35552 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133415AbWDQPeb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 17 Apr 2006 16:34:31 +0100
Received: from localhost (p1246-ipad213funabasi.chiba.ocn.ne.jp [124.85.66.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2779CA2C9; Tue, 18 Apr 2006 00:46:53 +0900 (JST)
Date:	Tue, 18 Apr 2006 00:47:18 +0900 (JST)
Message-Id: <20060418.004718.108120830.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] fix modpost segfault for 64bit mipsel kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060417140735.GC28935@networkno.de>
References: <20060417.210039.95063383.nemoto@toshiba-tops.co.jp>
	<20060417125332.GB28935@networkno.de>
	<20060417140735.GC28935@networkno.de>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 17 Apr 2006 15:07:35 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> I should have read more carefully. The ELF_R_SYM seems to be correct, if
> this patch makes it work fo you then the toolchain you use creates broken
> (word-swapped ?) relocation entries for mips64el.

Looking at following codes in glibc source
(sysdeps/mips/elf/ldsodefs.h), I thought r_info on 64bit mips needs
special handling.  Is not this structure used for 64bit kernel
modules?

typedef struct
{
  Elf32_Word    r_sym;		/* Symbol index */
  unsigned char r_ssym;		/* Special symbol for 2nd relocation */
  unsigned char r_type3;	/* 3rd relocation type */
  unsigned char r_type2;	/* 2nd relocation type */
  unsigned char r_type1;	/* 1st relocation type */
} _Elf64_Mips_R_Info;

typedef union
{
  Elf64_Xword	r_info_number;
  _Elf64_Mips_R_Info r_info_fields;
} _Elf64_Mips_R_Info_union;
...
typedef struct
{
  Elf64_Addr	r_offset;		/* Address */
  _Elf64_Mips_R_Info_union r_info;	/* Relocation type and symbol index */
  Elf64_Sxword	r_addend;		/* Addend */
} Elf64_Mips_Rela;

#define ELF64_MIPS_R_SYM(i) \
  ((__extension__ (_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_sym)
...
#undef ELF64_R_SYM
#define ELF64_R_SYM(i) ELF64_MIPS_R_SYM (i)

---
Atsushi Nemoto
