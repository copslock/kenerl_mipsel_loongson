Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 09:49:17 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:20903 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225951AbUDXItQ>; Sat, 24 Apr 2004 09:49:16 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 0E5314AEE3; Sat, 24 Apr 2004 10:49:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id F1BDC4AEA0; Sat, 24 Apr 2004 10:49:09 +0200 (CEST)
Date: Sat, 24 Apr 2004 10:49:09 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <20040424082655.GC26165@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0404241043160.14494@jurand.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10404240945500.14182-100000@helios.et.put.poznan.pl>
 <Pine.LNX.4.55.0404240949350.14494@jurand.ds.pg.gda.pl>
 <20040424075545.GA27039@linux-mips.org> <Pine.LNX.4.55.0404240959200.14494@jurand.ds.pg.gda.pl>
 <20040424081854.GB26165@linux-mips.org> <Pine.LNX.4.55.0404241021140.14494@jurand.ds.pg.gda.pl>
 <20040424082655.GC26165@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 24 Apr 2004, Ralf Baechle wrote:

> >  That precludes the firmware from being run cached, though.  Not very 
> > nice, especially for callbacks, but perhaps a bit easier to deal with.
> 
> Sane firmware copies itself to RAM at the earliest possible stage anyway -
> ROMs are way too slow.

 Indeed, though it excludes the RAM used from the OS control (unless the 
OS wants to block itself from the access to callbacks).

 FYI, DEC copies only the bits it currently needs (and e.g. option ROMs 
typically cannot be directly executed at all as they often are 8-bit, but 
return word-aligned data) and when booting the OS certain callback vector 
entries point to RAM and others to ROM.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
