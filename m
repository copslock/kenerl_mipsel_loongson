Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:56:28 +0100 (BST)
Received: from p508B74B7.dip.t-dialin.net ([IPv6:::ffff:80.139.116.183]:53335
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225758AbUDXH42>; Sat, 24 Apr 2004 08:56:28 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3O7u5xT029639;
	Sat, 24 Apr 2004 09:56:05 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3O7tjqu029043;
	Sat, 24 Apr 2004 09:55:45 +0200
Date: Sat, 24 Apr 2004 09:55:45 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>,
	linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
Message-ID: <20040424075545.GA27039@linux-mips.org>
References: <Pine.GSO.4.10.10404240945500.14182-100000@helios.et.put.poznan.pl> <Pine.LNX.4.55.0404240949350.14494@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0404240949350.14494@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 24, 2004 at 09:51:22AM +0200, Maciej W. Rozycki wrote:

> > Yeah. The weirdness is not in that part; what's weird is placing the rest
> > of memory somewhere else.
> 
>  Perhaps to be able to put iomem stuff in CKSEG1 without implying a hole
> in the RAM.

The machine is running a 64-bit kernel so likely it was designed with
little consideration for 32-bit issues.

  Ralf
