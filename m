Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Dec 2002 15:31:01 +0100 (CET)
Received: from p508B5422.dip.t-dialin.net ([80.139.84.34]:11168 "EHLO
	p508B5422.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225192AbSLCObA>; Tue, 3 Dec 2002 15:31:00 +0100
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:50849 "EHLO
	mx2.mips.com") by ralf.linux-mips.org with ESMTP id <S872117AbSLCHXy>;
	Tue, 3 Dec 2002 08:23:54 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB37TFNf014780;
	Mon, 2 Dec 2002 23:29:19 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA02167;
	Mon, 2 Dec 2002 23:29:12 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB37TDb26297;
	Tue, 3 Dec 2002 08:29:14 +0100 (MET)
Message-ID: <3DEC5D49.AB7AB8D3@mips.com>
Date: Tue, 03 Dec 2002 08:29:13 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: atlas_serial_{in,out}
References: <Pine.GSO.4.21.0212021213490.10713-100000@vervain.sonytel.be> <3DEB4DA0.E8200A58@mips.com> <20021203023820.A16306@linux-mips.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> On Mon, Dec 02, 2002 at 01:10:08PM +0100, Carsten Langgaard wrote:
>
> > They should have been in arch/mips/mips-boards/generic/printf.c, but they have
> > been removed, apparently.
> > Ralf, do you have any comment on why this code has been removed.
>
> Simply a glitch when cleaning in arch/mips/mips-boards/generic/printf.c.
>
> Btw, that file seem to follow the motto "generic due to ifdef" ;-)
>

Isn't the ifdef wonderful ;-)
A guess it's always a matter of compromise, tring to avoid the ifdef and sharing as
much code as possible.


>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
