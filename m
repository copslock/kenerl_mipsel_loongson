Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PIqrRw022668
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 11:52:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PIqrAe022667
	for linux-mips-outgoing; Thu, 25 Jul 2002 11:52:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PIqcRw022655
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 11:52:38 -0700
Received: from quasar.engr.sgi.com (quasar.engr.sgi.com [130.62.180.91]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA04468
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 11:53:43 -0700 (PDT)
	mail_from (davea@quasar.engr.sgi.com)
Received: (from davea@localhost)
	by quasar.engr.sgi.com (SGI-8.9.3/8.9.3) id LAA25513;
	Thu, 25 Jul 2002 11:50:12 -0700 (PDT)
Date: Thu, 25 Jul 2002 11:50:12 -0700 (PDT)
From: David Anderson <davea@quasar.engr.sgi.com>
Message-Id: <200207251850.LAA25513@quasar.engr.sgi.com>
To: hjl@lucon.org, cgd@broadcom.com
Subject: Re: PATCH: Update E_MIP_ARCH_XXX (Re: [patch] linux: RFC:
    elf_check_arch() rework)
Cc: davea@quasar.engr.sgi.com, binutils@sources.redhat.com,
   linux-mips@oss.sgi.com, linux-mips@fnet.fr,
   "Maciej W. Rozycki"
    <macro@ds2.pg.gda.pl>,
   "Carsten Langgaard" <carstenl@mips.com>
References: <Pine.GSO.3.96.1020725125830.27463H-100000@delta.ds2.pg.gda.pl>
    <3D3FFD21.8DA26337@mips.com> <20020725082610.A21614@lucon.org>
    <mailpost.1027610779.9546@news-sj1-1>
X-Spam-Status: No, hits=1.4 required=5.0 tests=MAY_BE_FORGED,PORN_10 version=2.20
X-Spam-Level: *
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk




Chris Demetriou  cgd@broadcom.com writes:
>[ Added David Anderson (hopefully still 8-) @ SGI to the CC list,
>since he's been helpful with sorting out questions like this in the
>past.
>
>At Thu, 25 Jul 2002 15:26:19 +0000 (UTC), "H. J. Lu" wrote:
>
>> I'd like to fix binutils ASAP. Here is a patch.
>
>People using stock binutils have been using the current binutils MIPS
>arch values for a While now.  They were in 2.11.1 and later binutils
>releases, as well.
>
>
>> > /* ELF header e_flags defines. MIPS architecture level. */
>> > #define EF_MIPS_ARCH_1      0x00000000  /* -mips1 code.  */
>> > #define EF_MIPS_ARCH_2      0x10000000  /* -mips2 code.  */
>> > #define EF_MIPS_ARCH_3      0x20000000  /* -mips3 code.  */
>> > #define EF_MIPS_ARCH_4      0x30000000  /* -mips4 code.  */
>> > #define EF_MIPS_ARCH_5      0x40000000  /* -mips5 code.  */
>> > #define EF_MIPS_ARCH_32     0x60000000  /* MIPS32 code.  */
>> > #define EF_MIPS_ARCH_64     0x70000000  /* MIPS64 code.  */
>> > #define EF_MIPS_ARCH_32R2   0x80000000  /* MIPS32 code.  */
>> > #define EF_MIPS_ARCH_64R2   0x90000000  /* MIPS64 code.  */
>
>Why are 2 definitions of MIPS32 and MIPS64 needed?
>
>Certainly, if you do need different definitions, they need much better
>comments than that.
>
>
>> > The missing value 0x50000000, is because IRIX has defined a EF_MIPS_ARCH_6
>> > and Algorithmics has a E_MIPS_ARCH_ALGOR_32, which has this value.

The latest IRIX def (not yet released header fragment):

elf.h:#define EF_MIPS_ARCH              0xf0000000      /* mask: 4 bit field */
elf.h:#define EF_MIPS_ARCH_1            0x00000000      /* MIPS I ISA */
elf.h:#define EF_MIPS_ARCH_2            0x10000000      /* MIPS II ISA */
elf.h:#define EF_MIPS_ARCH_3            0x20000000      /* MIPS III ISA */
elf.h:#define EF_MIPS_ARCH_4            0x30000000      /* MIPS IV ISA */
elf.h:#define EF_MIPS_ARCH_5            0x40000000      /* MIPS V ISA */
elf.h:#define EF_MIPS_ARCH_6            0x50000000
elf.h:#define EF_MIPS_ARCH_32           0x50000000      /* MIPS32 ISA */
elf.h:#define EF_MIPS_ARCH_64           0x60000000      /* MIPS64 ISA */

EF_MIPS_ARCH_32 duplicates EF_MIPS_ARCH_6 for basically historical
reasons I think : we did not want some compile to fail for no good reason
if EF_MIPS_ARCH_6 was referred to.
We never have used EF_MIPS_ARCH_6 for anything.

The EF_MIPS_ARCH_64 0x60000000
we got from binutils(!) around Nov 2001, according to my
email records.  Without much certainty it was the right value.

>It's unfortunate that MIPS is only at this late stage getting into the
>business of defining these fields.
>
>Has IRIX actually _used_ EF_MIPS_ARCH_6 for anything (shipped)?  That
>i'm a bit concerned about, since interoperability with IRIX would be a
>good thing given that SGI has been setting the only ABI example to
>follow for MIPS.

No, IRIX never used EF_MIPS_ARCH_6            0x50000000 for anything 
shipped.

>Algorithmics may have done something different, but they have also
>been capable of contributing their binutils-related changes back to
>the binutils projects, yet they have not.  Why muck things up for
>people who _have_, or who've been using the tools, on their account?

Nor have we shipped EF_MIPS_ARCH_32 or EF_MIPS_ARCH_64 
(from the IRIX set above).

While I cannot speak for everyone here, I'm pretty sure that
we can follow what is eventually adopted, since the values in question
represent nothing shipped.

We added EF_MIPS_ARCH_5            0x40000000 
and EF_MIPS_ARCH_6            0x50000000 to elf.h 
long long ago. 

I don't *think* we've shipped EF_MIPS_ARCH_5            0x40000000
either, but I could well be wrong on that, I forget
what was said/done on EF_MIPS_ARCH_5.  If it matters
I could check (let me know).

I've added a couple key interested sgi folks (via bcc,
I don't know they want email addresses exposed) to this
response.  So if I've made mistakes above such can
get corrrected.


Regards,
David B. Anderson davea@sgi.com http://reality.sgiweb.org/davea
