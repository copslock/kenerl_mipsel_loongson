Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2004 13:47:08 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:38529 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225377AbUCSNrI>; Fri, 19 Mar 2004 13:47:08 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 3EE494B909; Fri, 19 Mar 2004 14:47:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 2DCD3486ED; Fri, 19 Mar 2004 14:47:02 +0100 (CET)
Date: Fri, 19 Mar 2004 14:47:02 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
In-Reply-To: <20040318213713.GC25815@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0403191444410.18215@jurand.ds.pg.gda.pl>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
 <1078478086.4308.14.camel@dzur.sfbay.redhat.com> <16456.21112.570245.1011@arsenal.mips.com>
 <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
 <20040318213713.GC25815@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Thu, 18 Mar 2004, Ralf Baechle wrote:

> Take a look at the 68020 to see where instruction set madness can lead:
> 
> 	movel	([42, a0, d0.2*2],123), ([43, a0, d0.2*2], 22)
> 	bfextu	([42, a0, d0.2*2],123){8:8}, d2
> 
> And I haven't even started bitching about CALLM's bloat over jsr on a
> system with MMU disabled or the fantastic complexities it offers with
> all gadgets enabled.  Probably desigend for MACH but in the end just
> useless no known OS used them and Moto removed them again for the 030.

 But m68k isn't exactly RISC and high code density was a priority over
microcode simplicty (or absence) for the architecture.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
