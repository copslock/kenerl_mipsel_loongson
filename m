Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 17:34:03 +0100 (BST)
Received: from [IPv6:::ffff:212.105.56.244] ([IPv6:::ffff:212.105.56.244]:50128
	"EHLO dmz.lumentis.net") by linux-mips.org with ESMTP
	id <S8225237AbUEKQeC>; Tue, 11 May 2004 17:34:02 +0100
Received: from jockewin (fw [172.31.1.1])
	(authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id i4BGXnvC031779
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Tue, 11 May 2004 18:33:49 +0200
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Bradley D. LaRonde" <brad@laronde.org>,
	"Daniel Jacobowitz" <dan@debian.org>
Cc: <uclibc@uclibc.org>, "Richard Sandiford" <rsandifo@redhat.com>,
	<linux-mips@linux-mips.org>
Subject: RE: [uClibc] Re: uclibc mips ld.so and undefined symbols with nonzerosymbol table entry st_value
Date: Tue, 11 May 2004 18:33:42 +0200
Message-ID: <JPEALJAFNGDDLOPNDIEEIEFKCIAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <046a01c43763$42feeeb0$8d01010a@prefect>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Return-Path: <joakim.tjernlund@lumentis.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joakim.tjernlund@lumentis.se
Precedence: bulk
X-list: linux-mips

> >
> > Probably, since MIPS doesn't have a copy reloc.
> 
> How about the other copy reloc right below there:
> 
>     else if (sym->st_shndx == SHN_COMMON) {
>       *got_entry = (unsigned long) _dl_find_hash(strtab +
>         sym->st_name, tpnt->symbol_scope, ELF_RTYPE_CLASS_COPY);
>     }
> 
> ?

Perhaps DL_NO_COPY_RELOCS should be defined for MIPS then?
see ldso/include/dl-elf.h.

 Jocke
