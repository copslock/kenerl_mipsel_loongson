Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 06:48:40 +0100 (BST)
Received: from [IPv6:::ffff:212.105.56.244] ([IPv6:::ffff:212.105.56.244]:50759
	"EHLO dmz.lumentis.net") by linux-mips.org with ESMTP
	id <S8224992AbUEKFsj>; Tue, 11 May 2004 06:48:39 +0100
Received: from Jocke (h248n1fls32o899.telia.com [213.67.177.248])
	(authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id i4B5mSvC030830
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Tue, 11 May 2004 07:48:29 +0200
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Bradley D. LaRonde" <brad@laronde.org>,
	"Richard Sandiford" <rsandifo@redhat.com>
Cc: <uclibc@uclibc.org>, <linux-mips@linux-mips.org>
Subject: RE: [uClibc] Re: uclibc mips ld.so and undefined symbols with nonzerosymbol table entry st_value
Date: Tue, 11 May 2004 07:48:27 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHKEONCFAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <02fd01c43709$981a24a0$8d01010a@prefect>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Return-Path: <Joakim.Tjernlund@lumentis.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Joakim.Tjernlund@lumentis.se
Precedence: bulk
X-list: linux-mips

> 
> uClibc/ldso/ldso/mips/elfinterp.c around line 288 looks like this:
> 
> 
>     /* Relocate the global GOT entries for the object */
>     while(i--) {
>       if (sym->st_shndx == SHN_UNDEF) {
>         if (ELF32_ST_TYPE(sym->st_info) == STT_FUNC && sym->st_value)
>           *got_entry = sym->st_value + (unsigned long) tpnt->loadaddr;
>         else {
>           *got_entry = (unsigned long) _dl_find_hash(strtab +
>              sym->st_name, tpnt->symbol_scope, ELF_RTYPE_CLASS_COPY);
>         }
>      }
> 
> 
> If I change that ELF_RTYPE_CLASS_COPY to ELF_RTYPE_CLASS_PLT to tell
> _dl_find_hash to ignore stubs when resolving undefined functions without
> stubs, the dlopen tests all pass.  dlopen gets a pointer to the libc.so
> malloc instead of a pointer to the libpthread malloc stub.  Yay!  :-)
> 
> Does that look like the correct fix?

Hopefully, when I added ELF_RTYPE_CLASS_COPY/ELF_RTYPE_CLASS_PLT stuff I had to
guess what to do with MIPS. After that several minor error has been fixed by
changing these bits.

  Jocke
