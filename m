Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53MxbnC021888
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 3 Jun 2002 15:59:37 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g53Mxbqx021887
	for linux-mips-outgoing; Mon, 3 Jun 2002 15:59:37 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g53MxUnC021881;
	Mon, 3 Jun 2002 15:59:30 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17F0nx-000Iml-00; Tue, 04 Jun 2002 01:00:01 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17F0p1-0001Sb-00; Tue, 04 Jun 2002 01:01:07 +0200
Date: Tue, 4 Jun 2002 01:01:07 +0200
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>, Jun Sun <jsun@mvista.com>,
   Alexandr Andreev <andreev@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
Message-ID: <20020603230107.GH23411@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020603015536.B2832@dea.linux-mips.net> <Pine.GSO.3.96.1020603202021.14451K-100000@delta.ds2.pg.gda.pl> <20020603154011.A11393@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020603154011.A11393@dea.linux-mips.net>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> On Mon, Jun 03, 2002 at 08:30:09PM +0200, Maciej W. Rozycki wrote:
> 
> >  Well, 2.12.1 seem rock solid for me.  The package I made available at my
> > site only contains two patches that affect code (the rest is autoconf and
> > similar stuff) and then only MIPS64.  They can be safely discarded for
> > pure MIPS work.
> > 
> >  For MIPS64 they definitely do not work, OTOH, including the N32 ABI.
> 
> Are they good enough to build 64-bit kernels?

One simple patch [1] is missing from the release. R_MIPS_HIGHEST relocs
are zeroed out in a few cases where the assembler resolves them itself.
The rest works for me quite nice.


Thiemo


[1] http://sources.redhat.com/ml/binutils/2002-05/msg00188.html
