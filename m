Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g53N9gnC022210
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 3 Jun 2002 16:09:42 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g53N9gnn022209
	for linux-mips-outgoing; Mon, 3 Jun 2002 16:09:42 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g53N9ZnC022206;
	Mon, 3 Jun 2002 16:09:36 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17F0xo-000IgK-00; Tue, 04 Jun 2002 01:10:12 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17F0ys-0001Tj-00; Tue, 04 Jun 2002 01:11:18 +0200
Date: Tue, 4 Jun 2002 01:11:18 +0200
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
   "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>, Jun Sun <jsun@mvista.com>,
   Alexandr Andreev <andreev@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
Message-ID: <20020603231118.GI23411@rembrandt.csv.ica.uni-stuttgart.de>
References: <20020603015536.B2832@dea.linux-mips.net> <Pine.GSO.3.96.1020603202021.14451K-100000@delta.ds2.pg.gda.pl> <20020603154011.A11393@dea.linux-mips.net> <20020603230107.GH23411@rembrandt.csv.ica.uni-stuttgart.de> <20020603160425.A28859@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020603160425.A28859@dea.linux-mips.net>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> On Tue, Jun 04, 2002 at 01:01:07AM +0200, Thiemo Seufer wrote:
> 
> > > >  For MIPS64 they definitely do not work, OTOH, including the N32 ABI.
> > > 
> > > Are they good enough to build 64-bit kernels?
> > 
> > One simple patch [1] is missing from the release. R_MIPS_HIGHEST relocs
> > are zeroed out in a few cases where the assembler resolves them itself.
> > The rest works for me quite nice.
> 
> Wonderful.  Due to the hackish way we're using to build 64-bit kernels
> for the currently supported targets we don't run into this problems,
> there are no R_MIPS_HIGHEST relocs ever.

Well, for my I2 Impact I do. :-) I hope to get it running again with
the current kernel (plus my patches) in the next days.


Thiemo
