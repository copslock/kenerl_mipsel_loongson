Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53MdenC021484
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 3 Jun 2002 15:39:40 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g53MddbU021483
	for linux-mips-outgoing; Mon, 3 Jun 2002 15:39:39 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53MdUnC021452
	for <linux-mips@oss.sgi.com>; Mon, 3 Jun 2002 15:39:36 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g53MeBl28484;
	Mon, 3 Jun 2002 15:40:11 -0700
Date: Mon, 3 Jun 2002 15:40:11 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: "Gleb O. Raiko" <raiko@niisi.msk.ru>, Jun Sun <jsun@mvista.com>,
   Alexandr Andreev <andreev@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
Message-ID: <20020603154011.A11393@dea.linux-mips.net>
References: <20020603015536.B2832@dea.linux-mips.net> <Pine.GSO.3.96.1020603202021.14451K-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020603202021.14451K-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Jun 03, 2002 at 08:30:09PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jun 03, 2002 at 08:30:09PM +0200, Maciej W. Rozycki wrote:

>  Well, 2.12.1 seem rock solid for me.  The package I made available at my
> site only contains two patches that affect code (the rest is autoconf and
> similar stuff) and then only MIPS64.  They can be safely discarded for
> pure MIPS work.
> 
>  For MIPS64 they definitely do not work, OTOH, including the N32 ABI.

Are they good enough to build 64-bit kernels?

  Ralf
