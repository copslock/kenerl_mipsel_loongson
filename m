Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f62G5nt20394
	for linux-mips-outgoing; Mon, 2 Jul 2001 09:05:49 -0700
Received: from dea.waldorf-gmbh.de (u-80-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.80])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f62G5lV20390
	for <linux-mips@oss.sgi.com>; Mon, 2 Jul 2001 09:05:47 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f62G5Ew07302;
	Mon, 2 Jul 2001 18:05:14 +0200
Date: Mon, 2 Jul 2001 18:05:14 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: linux 2.4.5: A DECstation HALT interrupt handler
Message-ID: <20010702180514.A7269@bacchus.dhis.org>
References: <Pine.GSO.3.96.1010702163112.5606E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1010702163112.5606E-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jul 02, 2001 at 05:06:44PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 02, 2001 at 05:06:44PM +0200, Maciej W. Rozycki wrote:

>  Following is a minimal implementation of a HALT interrupt handler for
> DECstations.  The handler resets a system (invokes a warm restart) after
> the HALT button or, in case of the MAXINE, the HALT sequence of keys is
> pressed.  The patch should be OK to apply.

Applied.

  Ralf
