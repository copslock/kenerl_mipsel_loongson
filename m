Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2003 13:08:02 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:4268 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225872AbTLWNIB>; Tue, 23 Dec 2003 13:08:01 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 93CE7478A8; Tue, 23 Dec 2003 14:07:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id E60533B036; Tue, 23 Dec 2003 14:07:56 +0100 (CET)
Date: Tue, 23 Dec 2003 14:07:55 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [patch] 2.4: Support for newer gcc/gas options
In-Reply-To: <20031223.220213.74756743.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.55.0312231403110.27594@jurand.ds.pg.gda.pl>
References: <Pine.LNX.4.55.0312161822240.8262@jurand.ds.pg.gda.pl>
 <20031223.220213.74756743.anemo@mba.ocn.ne.jp>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 23 Dec 2003, Atsushi Nemoto wrote:

> With MIPS3 ISA, handle_adel_int will be:
> 
> 8002630c <handle_adel_int> 40284000 	dmfc0	t0,$8
> 80026310 <handle_adel_int+0x4> 00000000 	nop
> 80026314 <handle_adel_int+0x8> ffa800a4 	sd	t0,164(sp)
> 
> which is wrong for 32bit kernel.

 Which clearly indicates it should be selected with the CONFIG_MIPS32 (or 
CONFIG_MIPS64) option.

 Unfortunately I'm going away right now, so please feel free to fix the
code or alternatively I'll have a fix early in January.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
