Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 10:58:00 +0200 (CEST)
Received: from ftp.mips.com ([206.31.31.227]:15592 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S1122958AbSIEI57>;
	Thu, 5 Sep 2002 10:57:59 +0200
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g858vnXb013136;
	Thu, 5 Sep 2002 01:57:49 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA06615;
	Thu, 5 Sep 2002 01:57:37 -0700 (PDT)
Received: from mips.com (IDENT:carstenl@coplin20 [192.168.205.90])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g858vcb23913;
	Thu, 5 Sep 2002 10:57:38 +0200 (MEST)
Message-ID: <3D771C7F.F6E7EBB5@mips.com>
Date: Thu, 05 Sep 2002 10:57:35 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.9-31-P3-UP-WS-jg i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Kevin D. Kissell" <kevink@mips.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Quinn Jensen <jensenq@lineo.com>, linux-mips@linux-mips.org
Subject: Re: patch to kaweth.c to align IP header
References: <3D765072.60208@Lineo.COM> <1031182461.3017.137.camel@irongate.swansea.linux.org.uk> <008d01c254b5$d7398500$10eca8c0@grendel>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 97
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

"Kevin D. Kissell" wrote:

> ----- Original Message -----
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> To: "Quinn Jensen" <jensenq@lineo.com>
> Cc: <linux-mips@linux-mips.org>
> Sent: Thursday, September 05, 2002 1:34 AM
> Subject: Re: patch to kaweth.c to align IP header
>
> > On Wed, 2002-09-04 at 19:26, Quinn Jensen wrote:
> > > All,
> > >
> > > The Kawasaki LSI USB Ethernet driver was causing a crash
> > > in ipt_do_table() on mips because the address fields in
> > > the IP header were not word aligned.  Many (all?) other
> >
> > You -must- handle alignment traps in the kernel for networking. The
> > network code assumes and relies on this property and there are plenty of
> > other ways to get misaligned datagrams through things like ip in ip.
> >
> > > ethernet drivers do an skb_reserve of 2 to word align
> > > the address fields, and doing this in kaweth.c fixed
> > > my crash.
> >
> > Its not the crash fix, its however right in the sense its a good
> > performance optimisation for most platforms
>
> It is true that, due to the unfortunate lack of foresight in the
> design of IP, no pre-alignment of buffers will *guarantee*
> that the address or other fields of IP headers will be aligned.
>
> But I note that a design which assumes, for non x86 CPUs,
> that unaligned references will be handled by a kernel trap
> handler had darn well better assure itself that the misaligned
> case is extemely infrequent.  Otherwise, it would be a distinctly
> better design to extract all multi-byte IP header values using
> a macro which could map to a direct, possibly unaligned,
> load for CISC architectures, and to appropriate sequences
> of instructions for RISC architectures.  I haven't measured
> the alignment fault path for MIPS/Linux (in any case, MIPS
> isn't the only architecture affected here), but if we assume for
> the sake of the argument that it's 50 instructions, and that an
> unaligned halfword costs 4 inline instructions (lbu,lbu,sll,or),
> then using the unaligned reference trap as a crutch is a win
> only if the fields are correctly aligned roughtly 94% of the time.
>
> If full 32-bit or 64-bit words are being extracted, a MIPS CPU
> can do the unaligned accesses in only 2 in-line instructions,
> which would push the breakeven point out even further.
>
> Does anyone have any actual statistical data on the cost
> and frequency of this use of the unaligned access fixup?
>

There is implemented a counter in the unaligned exception handler, you used
to get hold of the value through /proc/cpuinfo, but this has apparently been
removed from the latest kernels.


>
>             Regards,
>
>             Kevin K.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
