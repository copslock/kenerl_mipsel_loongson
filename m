Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 09:23:41 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:61856 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225951AbUDXIXk>; Sat, 24 Apr 2004 09:23:40 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id 86D574AEA0; Sat, 24 Apr 2004 10:23:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id 73CAA47855; Sat, 24 Apr 2004 10:23:34 +0200 (CEST)
Date: Sat, 24 Apr 2004 10:23:34 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
In-Reply-To: <20040424081854.GB26165@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0404241021140.14494@jurand.ds.pg.gda.pl>
References: <Pine.GSO.4.10.10404240945500.14182-100000@helios.et.put.poznan.pl>
 <Pine.LNX.4.55.0404240949350.14494@jurand.ds.pg.gda.pl>
 <20040424075545.GA27039@linux-mips.org> <Pine.LNX.4.55.0404240959200.14494@jurand.ds.pg.gda.pl>
 <20040424081854.GB26165@linux-mips.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Sat, 24 Apr 2004, Ralf Baechle wrote:

> Actually the R10000 way to do something like this is to use the uncached
> attribute like in the Origin.  It allows using the same physical address
> space several times for different purposes.  So on node 0 of an Origin
> indeed memory starts at physical address zero and there is no hole for
> the firmware.  IP27 is afaik the only system using this R10000 feature
> which surprises me a little due to the otherwise great similarity of these
> two systems.

 That precludes the firmware from being run cached, though.  Not very 
nice, especially for callbacks, but perhaps a bit easier to deal with.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
