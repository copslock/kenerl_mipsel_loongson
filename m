Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Apr 2004 08:44:50 +0100 (BST)
Received: from p508B74B7.dip.t-dialin.net ([IPv6:::ffff:80.139.116.183]:43351
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225397AbUDXHot>; Sat, 24 Apr 2004 08:44:49 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3O7iRxT025809;
	Sat, 24 Apr 2004 09:44:27 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3O7i7B5025808;
	Sat, 24 Apr 2004 09:44:07 +0200
Date: Sat, 24 Apr 2004 09:44:07 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Stanislaw Skowronek <sskowron@ET.PUT.Poznan.PL>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: 32-bit ABI
Message-ID: <20040424074407.GA25730@linux-mips.org>
References: <Pine.LNX.4.55.0404240855580.14494@jurand.ds.pg.gda.pl> <Pine.GSO.4.10.10404240931500.13336-100000@helios.et.put.poznan.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10404240931500.13336-100000@helios.et.put.poznan.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 24, 2004 at 09:34:55AM +0200, Stanislaw Skowronek wrote:

> True, the kernel is *huge* (some 7 MB). But there *will* be pointer crops
> if I'm using the xkphys, and I can't use ckseg0 because there are only 16
> kilobytes of RAM mapped there for exceptions. So I have to use abi=64. It
> does work for me, anyway.

You could use a mapped address space, CKSEG2/3.

  Ralf
