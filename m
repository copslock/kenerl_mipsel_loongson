Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Dec 2004 00:10:07 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:20031
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225261AbULHAKB>; Wed, 8 Dec 2004 00:10:01 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CbpP5-0006tN-00; Wed, 08 Dec 2004 01:09:59 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CbpP4-0004dG-00; Wed, 08 Dec 2004 01:09:58 +0100
Date: Wed, 8 Dec 2004 01:09:58 +0100
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Dominic Sweetman <dom@mips.com>, linux-mips@linux-mips.org,
	Nigel Stephens <nigel@mips.com>, David Ung <davidu@mips.com>
Subject: Re: [PATCH] Improve atomic.h implementation robustness
Message-ID: <20041208000958.GS8714@rembrandt.csv.ica.uni-stuttgart.de>
References: <20041201070014.GG3225@rembrandt.csv.ica.uni-stuttgart.de> <16813.39660.948092.328493@doms-laptop.algor.co.uk> <20041201123336.GA5612@linux-mips.org> <Pine.LNX.4.58L.0412012136480.13579@blysk.ds.pg.gda.pl> <wvn653epbi1.fsf@talisman.cambridge.redhat.com> <20041207125659.GP8714@rembrandt.csv.ica.uni-stuttgart.de> <87is7d3o2k.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87is7d3o2k.fsf@redhat.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Richard Sandiford wrote:
> Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> writes:
> > I tried to use "R" in atomic.h but this failed in some (but not all)
> > cases with
> >
> > include/asm/atomic.h:64: error: inconsistent operand constraints in an asm'
> >
> > where the argument happens to be a member of a global struct.
> 
> Doh!  Do you have any testcases handy?

So far only the whole kernel, which isn't exactly handy.

> Was it failing with >= 3.4,
> or with older toolchains?  3.4 and above should know that 'R' is a
> memory-type constraint.

I saw the same failure for 3.3 and 3.4, I haven't tried 4.0.


Thiemo
