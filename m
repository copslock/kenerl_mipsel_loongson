Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53N3RnC022037
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 3 Jun 2002 16:03:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g53N3RkH022036
	for linux-mips-outgoing; Mon, 3 Jun 2002 16:03:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53N3OnC022033
	for <linux-mips@oss.sgi.com>; Mon, 3 Jun 2002 16:03:25 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g53N4QE28881;
	Mon, 3 Jun 2002 16:04:26 -0700
Date: Mon, 3 Jun 2002 16:04:25 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>, Jun Sun <jsun@mvista.com>,
   Alexandr Andreev <andreev@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
Message-ID: <20020603160425.A28859@dea.linux-mips.net>
References: <20020603015536.B2832@dea.linux-mips.net> <Pine.GSO.3.96.1020603202021.14451K-100000@delta.ds2.pg.gda.pl> <20020603154011.A11393@dea.linux-mips.net> <20020603230107.GH23411@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020603230107.GH23411@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Tue, Jun 04, 2002 at 01:01:07AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 04, 2002 at 01:01:07AM +0200, Thiemo Seufer wrote:

> > >  For MIPS64 they definitely do not work, OTOH, including the N32 ABI.
> > 
> > Are they good enough to build 64-bit kernels?
> 
> One simple patch [1] is missing from the release. R_MIPS_HIGHEST relocs
> are zeroed out in a few cases where the assembler resolves them itself.
> The rest works for me quite nice.

Wonderful.  Due to the hackish way we're using to build 64-bit kernels
for the currently supported targets we don't run into this problems,
there are no R_MIPS_HIGHEST relocs ever.

  Ralf
