Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 17:55:38 +0100 (BST)
Received: from ispmxmta06-srv.alltel.net ([IPv6:::ffff:166.102.165.167]:10965
	"EHLO ispmxmta06-srv.alltel.net") by linux-mips.org with ESMTP
	id <S8225237AbUEKQzh>; Tue, 11 May 2004 17:55:37 +0100
Received: from lahoo.priv ([69.40.149.10]) by ispmxmta06-srv.alltel.net
          with ESMTP
          id <20040511165527.EIAK5465.ispmxmta06-srv.alltel.net@lahoo.priv>;
          Tue, 11 May 2004 11:55:27 -0500
Received: from prefect.priv ([10.1.1.141] helo=prefect)
	by lahoo.priv with smtp (Exim 3.36 #1 (Debian))
	id 1BNaTk-0004Tn-00; Tue, 11 May 2004 12:51:40 -0400
Message-ID: <053f01c43778$c2903390$8d01010a@prefect>
From: "Bradley D. LaRonde" <brad@laronde.org>
To: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>,
	"Daniel Jacobowitz" <dan@debian.org>
Cc: <uclibc@uclibc.org>, "Richard Sandiford" <rsandifo@redhat.com>,
	<linux-mips@linux-mips.org>
References: <JPEALJAFNGDDLOPNDIEEIEFKCIAA.joakim.tjernlund@lumentis.se>
Subject: Re: [uClibc] Re: uclibc mips ld.so and undefined symbols with nonzerosymbol table entry st_value
Date: Tue, 11 May 2004 12:55:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Return-Path: <brad@laronde.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@laronde.org
Precedence: bulk
X-list: linux-mips

----- Original Message ----- 
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Bradley D. LaRonde" <brad@laronde.org>; "Daniel Jacobowitz"
<dan@debian.org>
Cc: <uclibc@uclibc.org>; "Richard Sandiford" <rsandifo@redhat.com>;
<linux-mips@linux-mips.org>
Sent: Tuesday, May 11, 2004 12:33 PM
Subject: RE: [uClibc] Re: uclibc mips ld.so and undefined symbols with
nonzerosymbol table entry st_value


> > >
> > > Probably, since MIPS doesn't have a copy reloc.
> >
> > How about the other copy reloc right below there:
> >
> >     else if (sym->st_shndx == SHN_COMMON) {
> >       *got_entry = (unsigned long) _dl_find_hash(strtab +
> >         sym->st_name, tpnt->symbol_scope, ELF_RTYPE_CLASS_COPY);
> >     }
> >
> > ?
>
> Perhaps DL_NO_COPY_RELOCS should be defined for MIPS then?
> see ldso/include/dl-elf.h.

For mips glibc 2.3.3 does:

#define elf_machine_type_class(type)            ELF_RTYPE_CLASS_PLT

and never uses ELF_RTYPE_CLASS_COPY directly (though it does use
ELF_RTYPE_CLASS_PLT directly).

Regards,
Brad
