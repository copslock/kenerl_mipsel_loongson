Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g75EkXRw011333
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 5 Aug 2002 07:46:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g75EkXIb011332
	for linux-mips-outgoing; Mon, 5 Aug 2002 07:46:33 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f218.dialo.tiscali.de [62.246.16.218])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g75EkQRw011322
	for <linux-mips@oss.sgi.com>; Mon, 5 Aug 2002 07:46:29 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g75ElT011860;
	Mon, 5 Aug 2002 16:47:29 +0200
Date: Mon, 5 Aug 2002 16:47:29 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: [patch] 2.4: Revert interface removal
Message-ID: <20020805164729.A11853@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020805105624.18894C-100000@delta.ds2.pg.gda.pl> <20020805124154.B6365@dea.linux-mips.net> <3D4E5BFE.595DA175@mips.com> <3D4E6743.58776F67@mips.com> <3D4E77CD.A4E7B78B@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D4E77CD.A4E7B78B@mips.com>; from carstenl@mips.com on Mon, Aug 05, 2002 at 03:04:13PM +0200
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 05, 2002 at 03:04:13PM +0200, Carsten Langgaard wrote:

> Ok, I finally figured out what the problem is.
> The attached patch fix the problems, please apply.

Applied, along with the 64-bit and 2.5 bits your patch was missing.

  Ralf
