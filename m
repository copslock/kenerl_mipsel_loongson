Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Dec 2002 02:40:40 +0100 (CET)
Received: from p508B5422.dip.t-dialin.net ([80.139.84.34]:46210 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225200AbSLCBkk>; Tue, 3 Dec 2002 02:40:40 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB31cKS17630;
	Tue, 3 Dec 2002 02:38:21 +0100
Date: Tue, 3 Dec 2002 02:38:20 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: atlas_serial_{in,out}
Message-ID: <20021203023820.A16306@linux-mips.org>
References: <Pine.GSO.4.21.0212021213490.10713-100000@vervain.sonytel.be> <3DEB4DA0.E8200A58@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DEB4DA0.E8200A58@mips.com>; from carstenl@mips.com on Mon, Dec 02, 2002 at 01:10:08PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 722
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 02, 2002 at 01:10:08PM +0100, Carsten Langgaard wrote:

> They should have been in arch/mips/mips-boards/generic/printf.c, but they have
> been removed, apparently.
> Ralf, do you have any comment on why this code has been removed.

Simply a glitch when cleaning in arch/mips/mips-boards/generic/printf.c.

Btw, that file seem to follow the motto "generic due to ifdef" ;-)

  Ralf
