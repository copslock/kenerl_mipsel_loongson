Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Feb 2003 20:22:09 +0000 (GMT)
Received: from mms1.broadcom.com ([IPv6:::ffff:63.70.210.58]:40711 "EHLO
	mms1.broadcom.com") by linux-mips.org with ESMTP
	id <S8225248AbTBUUWI>; Fri, 21 Feb 2003 20:22:08 +0000
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS1 SMTP Relay (MMS v5.5.0)); Fri, 21 Feb 2003 12:21:46 -0700
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id MAA16671; Fri, 21 Feb 2003 12:21:53 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 h1LKM2ER008883; Fri, 21 Feb 2003 12:22:02 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id MAA04978; Fri,
 21 Feb 2003 12:22:02 -0800
Message-ID: <3E568A6A.96B422@broadcom.com>
Date: Fri, 21 Feb 2003 12:22:02 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
References: <Pine.GSO.3.96.1030221132402.13836K-100000@delta.ds2.pg.gda.pl>
X-WSS-ID: 124855D01401564-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips


Suggestions and corrections are welcome.  I'm not an ABI/binutils
expert.  FYI, I let Ralf eyeball this before checking it in.

Kip

"Maciej W. Rozycki" wrote:
> 
> On Thu, 20 Feb 2003 kwalker@linux-mips.org wrote:
> 
> > Modified files:
> >       include/asm-mips64: Tag: linux_2_4 a.out.h elf.h processor.h
> >       arch/mips64/kernel: Tag: linux_2_4 process.c signal.c
> >
> > Log message:
> >       Represent ABI (o32,n32,n64) in thread mflags using 2 bits:
> >       MF_32BIT_REGS, MF_32BIT_ADDR.
> 
>  Why do you assume no ABI set for ELF32 means n32?  Historically it means
> o32 and arch/mips64/kernel/binfmt_elfo32.c treats it as such.  Also a
> brief study of binutils reveals the interpretation is the same for IRIX
> which does not handle the EF_MIPS_ABI mask.
> 
> --
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
