Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5OFTvnC032722
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 24 Jun 2002 08:29:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5OFTuXG032721
	for linux-mips-outgoing; Mon, 24 Jun 2002 08:29:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-18.ka.dial.de.ignite.net [62.180.196.18])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5OFTqnC032713
	for <linux-mips@oss.sgi.com>; Mon, 24 Jun 2002 08:29:54 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5ODXUZ00436;
	Mon, 24 Jun 2002 15:33:30 +0200
Date: Mon, 24 Jun 2002 15:33:30 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Guido Guenther <agx@sigxcpu.org>, linux-mips@oss.sgi.com
Subject: Re: 2.4.18: pgtable.h compile fix
Message-ID: <20020624153330.C28145@dea.linux-mips.net>
References: <20020623125811.GA24851@bogon.ms20.nix> <Pine.GSO.3.96.1020624102402.22509D-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020624102402.22509D-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jun 24, 2002 at 10:30:22AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 24, 2002 at 10:30:22AM +0200, Maciej W. Rozycki wrote:

>  MIPS64 lags behind a bit due to less interest/testing.  Note that you
> should use "__ASSEMBLY__" to guard assembly-unsafe parts of headers.

_LANGUAGE_ASSEMBLY is the traditional MIPS cpp symbol to indicate assembler
source code.

  Ralf
