Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2003 21:49:19 +0100 (BST)
Received: from p508B65AB.dip.t-dialin.net ([IPv6:::ffff:80.139.101.171]:57755
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225470AbTJMUtQ>; Mon, 13 Oct 2003 21:49:16 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h9DKn9NK025630;
	Mon, 13 Oct 2003 22:49:09 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h9DKn7Q7025629;
	Mon, 13 Oct 2003 22:49:07 +0200
Date: Mon, 13 Oct 2003 22:49:06 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Horsten <thomas@horsten.com>,
	"Liu Hongming (Alan)" <alanliu@trident.com.cn>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: need help on unaligned loads,stores!
Message-ID: <20031013204906.GA21100@linux-mips.org>
References: <200310131927.07171.thomas@horsten.com> <Pine.GSO.4.21.0310132132550.26520-100000@starflower.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0310132132550.26520-100000@starflower.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 13, 2003 at 09:34:07PM +0200, Geert Uytterhoeven wrote:

> I guess Liu meant the (patented) instructions to do explicit unaligned
> accesses.  Real MIPS CPUs do support these.

That correct.  Unfortunately emulating of these instructions in exception
handlers would also be covered by the patents, so rewriting which would
be rather easy in all cases I can think of is the way to go ...

  Ralf
