Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 09:07:09 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:53918 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225758AbUDXIHI>; Sat, 24 Apr 2004 09:07:08 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id A0B184AEE3; Sat, 24 Apr 2004 10:07:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 905644AEA0; Sat, 24 Apr 2004 10:07:02 +0200 (CEST)
Date: Sat, 24 Apr 2004 10:07:02 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <20040424075545.GA27039@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0404240959200.14494@jurand.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10404240945500.14182-100000@helios.et.put.poznan.pl>
 <Pine.LNX.4.55.0404240949350.14494@jurand.ds.pg.gda.pl>
 <20040424075545.GA27039@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 24 Apr 2004, Ralf Baechle wrote:

> > > Yeah. The weirdness is not in that part; what's weird is placing the rest
> > > of memory somewhere else.
> > 
> >  Perhaps to be able to put iomem stuff in CKSEG1 without implying a hole
> > in the RAM.
> 
> The machine is running a 64-bit kernel so likely it was designed with
> little consideration for 32-bit issues.

 Well, the exception arrangement requires RAM starting from the physical
address 0.  It seems natural to place RAM just there, avoiding additional
complexity to address decoders.  But then firmware has to be somewere
around 0x1fc00000, so to support more than 508MB of RAM the designers
would have to create a hole in RAM, which would have to be handled by the
OS then.  Thus abandoning the idea of putting RAM low, placing it
somewhere above 0x1fffffff and just mapping some of it at 0 for the
exceptions seems a better solution.

 Fortunately everything is not a PC. :-)

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
