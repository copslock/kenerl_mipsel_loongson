Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2004 15:30:59 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:1738 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224991AbUAFPau>; Tue, 6 Jan 2004 15:30:50 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id B452B4C3A7; Tue,  6 Jan 2004 16:30:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 9D64F473D8; Tue,  6 Jan 2004 16:30:48 +0100 (CET)
Date: Tue, 6 Jan 2004 16:30:48 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4: Support for newer gcc/gas options
In-Reply-To: <Pine.LNX.4.55.0312231403110.27594@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.55.0401061625200.5272@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl>
 <20031223.220213.74756743.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.55.0312231403110.27594@jurand.ds.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 23 Dec 2003, Maciej W. Rozycki wrote:

> > With MIPS3 ISA, handle_adel_int will be:
> > 
> > 8002630c <handle_adel_int> 40284000 	dmfc0	t0,$8
> > 80026310 <handle_adel_int+0x4> 00000000 	nop
> > 80026314 <handle_adel_int+0x8> ffa800a4 	sd	t0,164(sp)
> > 
> > which is wrong for 32bit kernel.
> 
>  Which clearly indicates it should be selected with the CONFIG_MIPS32 (or 
> CONFIG_MIPS64) option.

 I can see Ralf has fixed the problem, by using the ABI as the criterion 
used in conditionals.  This is better yet -- thanks Ralf.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
