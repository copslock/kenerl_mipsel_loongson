Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f33I1Jc12488
	for linux-mips-outgoing; Tue, 3 Apr 2001 11:01:19 -0700
Received: from dea.waldorf-gmbh.de (u-231-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.231])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f33I1EM12482
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 11:01:14 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f338Q9o30734;
	Tue, 3 Apr 2001 10:26:09 +0200
Date: Tue, 3 Apr 2001 10:26:09 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "Steven J. Hill" <sjhill@cotw.com>, linux-mips@oss.sgi.com
Subject: Re: Binutils fixed to deal with 'insmod' issue and discussion...
Message-ID: <20010403102608.A30531@bacchus.dhis.org>
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <3AC90E16.AEF59359@cotw.com> <20010403041740.G5099@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010403041740.G5099@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Tue, Apr 03, 2001 at 04:17:40AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Apr 03, 2001 at 04:17:40AM +0200, Thiemo Seufer wrote:

> >Without the binutils patch, all binaries compiled for MIPS/Linux
> >will be IRIX flavored which was the whole problem.
> 
> Please may You elaborate about this? AFAICS, the IRIX flavour
> can't be a problem by itself.

> Changing the MIPS/Linux ABI to circumvent a toolchain bug seems
> to be a bit extremistic. Am I missing some important details?

IRIX ELF orders the symbol table of object files in a way that violates
the ABI.  Worse, these IRIX specialities are not documented anywhere.

Changing to ABI ELF only makes them look as they're supposed to ...

  Ralf
