Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 18:37:35 +0100 (CET)
Received: from p508B6A78.dip.t-dialin.net ([80.139.106.120]:38277 "EHLO
	p508B6A78.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122165AbSKHRhe>; Fri, 8 Nov 2002 18:37:34 +0100
Received: (ralf@3ffe:8260:2020:2::20) by ralf.linux-mips.org
	id <S868139AbSKHRft>; Fri, 8 Nov 2002 18:35:49 +0100
Date: Fri, 8 Nov 2002 18:35:49 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jun Sun <jsun@mvista.com>,
	Karsten Merker <karsten@excalibur.cologne.de>,
	linux-mips@linux-mips.org
Subject: Re: make xmenuconfig is broken
Message-ID: <20021108183549.A9711@bacchus.dhis.org>
References: <20021107142304.B27505@mvista.com> <Pine.GSO.3.96.1021108132207.3217C-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021108132207.3217C-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Nov 08, 2002 at 01:25:26PM +0100
X-Accept-Language: de,en,fr
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 08, 2002 at 01:25:26PM +0100, Maciej W. Rozycki wrote:

> > Now we still have IP22 config which needs to be fixed.  Any volunteers?
> 
>  Renaming CONFIG_SERIAL_CONSOLE to CONFIG_SGI_SERIAL_CONSOLE where
> appropriate should suffice.

That's my part to fix, I guess.  However since not all SGI's are
using the Zilog 8530 for their serial interfaces I'll rename it
CONFIG_IP22_SERIAL_CONSOLE.

  Ralf
