Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 19:43:15 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:50856
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225249AbTENSm7>; Wed, 14 May 2003 19:42:59 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19G1DN-001F0G-00; Wed, 14 May 2003 20:42:57 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19G1DM-00060Q-00; Wed, 14 May 2003 20:42:56 +0200
Date: Wed, 14 May 2003 20:42:56 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030514184256.GE8833@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030514175011.GD8833@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030514195854.26213L-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030514195854.26213L-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
[snip]
> > What's desireable here depends on the target system. For Linux,
> > the current way is IMHO the best: o32 only for mips-linux, and
> > o32, n32 and n64 for mips64-linux, with n32 as default.
> 
>  Of course the choice of the default should be configurable (for binutils
> it probably already is

It isn't, and probably will never be. Of course you could introduce
just another configuration, with the bfd vector of your choice as
default.

> -- I recall Richard Sandiford making changes in
> this area, for gcc -- no idea).

It would also need a different config which defines a different
MIPS_DEFAULT_ABI.


Thiemo
