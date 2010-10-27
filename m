Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2010 11:31:31 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54527 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491051Ab0J0JbX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Oct 2010 11:31:23 +0200
Date:   Wed, 27 Oct 2010 10:31:23 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
cc:     John Reiser <jreiser@bitwagon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: patch v2: [RFC 2/2] ftrace/MIPS: Add support for C version of
 recordmcount
In-Reply-To: <AANLkTikRnLefhL0T7f4++qHx8NmXOo4BbjkscKjAW57P@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1010270948260.15889@eddie.linux-mips.org>
References: <AANLkTinwXjLAYACUfhLYaocHD_vBbiErLN3NjwN8JqSy@mail.gmail.com>        <4CC49A99.1080601@bitwagon.com>        <alpine.LFD.2.00.1010250435540.15889@eddie.linux-mips.org>        <4CC5B474.9050503@bitwagon.com>        <alpine.LFD.2.00.1010261409190.15889@eddie.linux-mips.org>
 <AANLkTikRnLefhL0T7f4++qHx8NmXOo4BbjkscKjAW57P@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 27 Oct 2010, wu zhangjin wrote:

> will this help?
> 
> typedef struct {
>         Elf64_Addr    r_offset;               /* Address */
>         union {
>                 struct {
>                         Elf64_Word r_sym;
>                         myElf64_byte r_ssym;  /* Special sym:
> gp-relative, etc. */
>                         myElf64_byte r_type3;
>                         myElf64_byte r_type2;
>                         myElf64_byte r_type;
>                 } r_info;
>                 Elf64_Xword gABI_r_info;
>         };
>         Elf64_Sxword  r_addend;               /* Addend */
> } MIPS64_Rela;

 More or less, although you need to give your union a name to access its 
members. ;)  It may be simpler to refer to r_info only, e.g. something 
along these lines:

typedef uint8_t myElf64_Byte;
union mips_r_info {
	Elf64_Xword r_info;
	struct {
		Elf64_Word r_sym;
		myElf64_Byte r_ssym;
		myElf64_Byte r_type3;
		myElf64_Byte r_type2;
		myElf64_Byte r_type;
	} r_mips;
};

static uint64_t MIPS64_r_sym(Elf64_Rel const *rp)
{
	return w(((union mips_r_info){ .r_info = rp->r_info }).r_mips.r_sym);
}

static void MIPS64_r_info(Elf64_Rel *const rp,
			  unsigned int sym, unsigned int type)
{
	rp->r_info = ((union mips_r_info){
		.r_mips = { .r_sym = w(sym), .r_type = type }
	}).r_info;
}

Untested, but GCC 4.1.2 seems to turn it into decent big-endian code:

tmp.o:     file format elf64-tradbigmips

Disassembly of section .text:

0000000000000000 <MIPS64_r_sym>:
   0:	03e00008 	jr	ra
   4:	9c820008 	lwu	v0,8(a0)

0000000000000008 <MIPS64_r_info>:
   8:	30c600ff 	andi	a2,a2,0xff
   c:	0005283c 	dsll32	a1,a1,0x0
  10:	00a62825 	or	a1,a1,a2
  14:	03e00008 	jr	ra
  18:	fc850008 	sd	a1,8(a0)

and not so decent little-endian code (too many shifts):

tmpel.o:     file format elf64-tradlittlemips

Disassembly of section .text:

0000000000000000 <MIPS64_r_sym>:
   0:	dc820008 	ld	v0,8(a0)
   4:	00021000 	sll	v0,v0,0x0
   8:	0002103c 	dsll32	v0,v0,0x0
   c:	03e00008 	jr	ra
  10:	0002103e 	dsrl32	v0,v0,0x0

0000000000000018 <MIPS64_r_info>:
  18:	0005283c 	dsll32	a1,a1,0x0
  1c:	0006363c 	dsll32	a2,a2,0x18
  20:	0005283e 	dsrl32	a1,a1,0x0
  24:	00a62825 	or	a1,a1,a2
  28:	03e00008 	jr	ra
  2c:	fc850008 	sd	a1,8(a0)

GCC may have been fixed/improved since though (I'd expect so, but didn't 
have the resources to upgrade yet, so check yourself).

 Here's my sign-off mark if you'd like to use the code above.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

  Maciej
