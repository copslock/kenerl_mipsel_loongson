Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PHmhRw021384
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 10:48:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PHmhmQ021383
	for linux-mips-outgoing; Thu, 25 Jul 2002 10:48:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PHmVRw021367
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 10:48:32 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Thu, 25 Jul 2002 10:49:35 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id KAA20180; Thu, 25 Jul 2002 10:49:36 -0700 (PDT)
Received: from dt-sj3-118.sj.broadcom.com (dt-sj3-118 [10.21.64.118]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 g6PHnWER020955; Thu, 25 Jul 2002 10:49:32 -0700 (PDT)
Received: (from cgd@localhost) by dt-sj3-118.sj.broadcom.com (
 8.9.1/SJ8.9.1) id KAA11550; Thu, 25 Jul 2002 10:49:30 -0700 (PDT)
To: hjl@lucon.org
cc: "Carsten Langgaard" <carstenl@mips.com>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com, binutils@sources.redhat.com,
   davea@quasar.engr.sgi.com
Subject: Re: PATCH: Update E_MIP_ARCH_XXX (Re: [patch] linux: RFC:
 elf_check_arch() rework)
References: <Pine.GSO.3.96.1020725125830.27463H-100000@delta.ds2.pg.gda.pl>
 <3D3FFD21.8DA26337@mips.com> <20020725082610.A21614@lucon.org>
 <mailpost.1027610779.9546@news-sj1-1>
From: cgd@broadcom.com
Date: 25 Jul 2002 10:49:30 -0700
In-Reply-To: hjl@lucon.org's message of
 "Thu, 25 Jul 2002 15:26:19 +0000 (UTC)"
Message-ID: <yov5u1mny9xx.fsf@broadcom.com>
X-Mailer: Gnus v5.7/Emacs 20.4
MIME-Version: 1.0
X-WSS-ID: 115EE5A5364710-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-3.7 required=5.0 tests=IN_REP_TO,NO_REAL_NAME,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

[ Added David Anderson (hopefully still 8-) @ SGI to the CC list,
since he's been helpful with sorting out questions like this in the
past.

At Thu, 25 Jul 2002 15:26:19 +0000 (UTC), "H. J. Lu" wrote:

> I'd like to fix binutils ASAP. Here is a patch.

People using stock binutils have been using the current binutils MIPS
arch values for a While now.  They were in 2.11.1 and later binutils
releases, as well.


> > /* ELF header e_flags defines. MIPS architecture level. */
> > #define EF_MIPS_ARCH_1      0x00000000  /* -mips1 code.  */
> > #define EF_MIPS_ARCH_2      0x10000000  /* -mips2 code.  */
> > #define EF_MIPS_ARCH_3      0x20000000  /* -mips3 code.  */
> > #define EF_MIPS_ARCH_4      0x30000000  /* -mips4 code.  */
> > #define EF_MIPS_ARCH_5      0x40000000  /* -mips5 code.  */
> > #define EF_MIPS_ARCH_32     0x60000000  /* MIPS32 code.  */
> > #define EF_MIPS_ARCH_64     0x70000000  /* MIPS64 code.  */
> > #define EF_MIPS_ARCH_32R2   0x80000000  /* MIPS32 code.  */
> > #define EF_MIPS_ARCH_64R2   0x90000000  /* MIPS64 code.  */

Why are 2 definitions of MIPS32 and MIPS64 needed?

Certainly, if you do need different definitions, they need much better
comments than that.


> > The missing value 0x50000000, is because IRIX has defined a EF_MIPS_ARCH_6
> > and Algorithmics has a E_MIPS_ARCH_ALGOR_32, which has this value.

It's unfortunate that MIPS is only at this late stage getting into the
business of defining these fields.

Has IRIX actually _used_ EF_MIPS_ARCH_6 for anything (shipped)?  That
i'm a bit concerned about, since interoperability with IRIX would be a
good thing given that SGI has been setting the only ABI example to
follow for MIPS.

Algorithmics may have done something different, but they have also
been capable of contributing their binutils-related changes back to
the binutils projects, yet they have not.  Why muck things up for
people who _have_, or who've been using the tools, on their account?




cgd
-- 
Chris Demetriou                                            Broadcom Corporation
Senior Staff Design Engineer                  Broadband Processor Business Unit
  Any opinions expressed in this message are mine, not necessarily Broadcom's.
