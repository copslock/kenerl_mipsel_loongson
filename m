Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 09:27:38 +0100 (BST)
Received: from p508B74B7.dip.t-dialin.net ([IPv6:::ffff:80.139.116.183]:13656
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225951AbUDXI1i>; Sat, 24 Apr 2004 09:27:38 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3O8RFxT007770;
	Sat, 24 Apr 2004 10:27:15 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3O8QtkY007760;
	Sat, 24 Apr 2004 10:26:55 +0200
Date: Sat, 24 Apr 2004 10:26:55 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
Message-ID: <20040424082655.GC26165@linux-mips.org>
References: <Pine.GSO.4.10.10404240945500.14182-100000@helios.et.put.poznan.pl> <Pine.LNX.4.55.0404240949350.14494@jurand.ds.pg.gda.pl> <20040424075545.GA27039@linux-mips.org> <Pine.LNX.4.55.0404240959200.14494@jurand.ds.pg.gda.pl> <20040424081854.GB26165@linux-mips.org> <Pine.LNX.4.55.0404241021140.14494@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0404241021140.14494@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 24, 2004 at 10:23:34AM +0200, Maciej W. Rozycki wrote:

> > Actually the R10000 way to do something like this is to use the uncached
> > attribute like in the Origin.  It allows using the same physical address
> > space several times for different purposes.  So on node 0 of an Origin
> > indeed memory starts at physical address zero and there is no hole for
> > the firmware.  IP27 is afaik the only system using this R10000 feature
> > which surprises me a little due to the otherwise great similarity of these
> > two systems.
> 
>  That precludes the firmware from being run cached, though.  Not very 
> nice, especially for callbacks, but perhaps a bit easier to deal with.

Sane firmware copies itself to RAM at the earliest possible stage anyway -
ROMs are way too slow.

  Ralf
