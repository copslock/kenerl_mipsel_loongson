Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 22:51:27 +0100 (BST)
Received: from [IPv6:::ffff:212.105.56.244] ([IPv6:::ffff:212.105.56.244]:40667
	"EHLO dmz.lumentis.net") by linux-mips.org with ESMTP
	id <S8225926AbUEKVvE>; Tue, 11 May 2004 22:51:04 +0100
Received: from Jocke (h248n1fls32o899.telia.com [213.67.177.248])
	(authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id i4BLojvC032079
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Tue, 11 May 2004 23:50:46 +0200
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Bradley D. LaRonde" <brad@laronde.org>,
	"Daniel Jacobowitz" <dan@debian.org>
Cc: <uclibc@uclibc.org>, "Richard Sandiford" <rsandifo@redhat.com>,
	<linux-mips@linux-mips.org>
Subject: RE: [uClibc] Re: uclibc mips ld.so and undefined symbols with nonzerosymbol table entry st_value
Date: Tue, 11 May 2004 23:50:44 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHOEPBCFAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <053f01c43778$c2903390$8d01010a@prefect>
Importance: Normal
Return-Path: <Joakim.Tjernlund@lumentis.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4985
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Joakim.Tjernlund@lumentis.se
Precedence: bulk
X-list: linux-mips

> > > >
> > > > Probably, since MIPS doesn't have a copy reloc.
> > >
> > > How about the other copy reloc right below there:
> > >
> > >     else if (sym->st_shndx == SHN_COMMON) {
> > >       *got_entry = (unsigned long) _dl_find_hash(strtab +
> > >         sym->st_name, tpnt->symbol_scope, ELF_RTYPE_CLASS_COPY);
> > >     }
> > >
> > > ?
> >
> > Perhaps DL_NO_COPY_RELOCS should be defined for MIPS then?
> > see ldso/include/dl-elf.h.
> 
> For mips glibc 2.3.3 does:
> 
> #define elf_machine_type_class(type)            ELF_RTYPE_CLASS_PLT
> 
> and never uses ELF_RTYPE_CLASS_COPY directly (though it does use
> ELF_RTYPE_CLASS_PLT directly).
> 
> Regards,
> Brad
> 

Good, try replacing all ELF_RTYPE_CLASS_COPY with ELF_RTYPE_CLASS_PLT in 
mips/elfinterp.c and define DL_NO_COPY_RELOCS in mips/dl-sysdep.h

  Jocke
