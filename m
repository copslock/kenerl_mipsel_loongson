Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 00:10:26 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:2908
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225218AbTHKXKY>; Tue, 12 Aug 2003 00:10:24 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19mLnw-00053W-00; Tue, 12 Aug 2003 01:10:20 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19mLnv-00067G-00; Tue, 12 Aug 2003 01:10:19 +0200
Date: Tue, 12 Aug 2003 01:10:19 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: load/store address overflow on binutils 2.14
Message-ID: <20030811231019.GA23104@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030810145425.GE22977@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1030811125208.18443A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030811125208.18443A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Sun, 10 Aug 2003, Thiemo Seufer wrote:
> 
> > Produces the expected output. So it is actually an implementation
> > bug in binutils, which isn't fixable for 2.14 and earlier, because
> > those have to remain at K&R C level. The K&R requirement was only
> > recenly loosened.
> 
>  Strangely enough, the Atsushi's code builds just fine with 2.13.2.1.

The test in binutils it stumbled over was added later.


Thiemo
