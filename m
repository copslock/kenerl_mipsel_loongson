Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 12:59:31 +0000 (GMT)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:18912 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225222AbUATM7b>; Tue, 20 Jan 2004 12:59:31 +0000
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id DBF5D4C3BC; Tue, 20 Jan 2004 13:59:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id C8979477ED; Tue, 20 Jan 2004 13:59:29 +0100 (CET)
Date: Tue, 20 Jan 2004 13:59:29 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Support for newer gcc/gas options
In-Reply-To: <20040120124518.GY22218@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.55.0401201351000.12841@jurand.ds.pg.gda.pl>
References: <20031223114644.GA5458@sonycom.com>
 <Pine.LNX.4.55.0312231303030.27594@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.55.0401201332080.12841@jurand.ds.pg.gda.pl>
 <20040120124518.GY22218@rembrandt.csv.ica.uni-stuttgart.de>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 20 Jan 2004, Thiemo Seufer wrote:

> >  It took a bit longer than I planned, sorry.  Anyway, here are two
> > functionally equivalent patches, for 2.4 and the head, that remove an ISA
> > specification if a tool supports "-march=" and "-mabi=" at the same time.  
> 
> FYI:
> A test for the existence of -march= should be enough, -mabi= was
> implemented earlier. OTOH, it does no harm to check both.

 Well, FWIW my port of gcc 2.95.4 supports -march= (by aliasing it to
-mcpu=, but the option is passed down to gas as is) to cooperate with
current binutils, but its support for -mabi= varies depending on the
configuration: mips64el-linux-gcc does support the option, but
mipsel-linux-gcc does not.  I suppose others may also want to have -march=
support in 2.95.4 for binutils compatibility, especially as AFAICS 2.95.4
has a huge speed advantage over later versions of gcc.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
