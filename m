Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 20:59:37 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:41380
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225221AbTEMT7d>; Tue, 13 May 2003 20:59:33 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19Ffvs-001Cuo-00; Tue, 13 May 2003 21:59:28 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19Ffvs-000554-00; Tue, 13 May 2003 21:59:28 +0200
Date: Tue, 13 May 2003 21:59:28 +0200
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@linux-mips.org, Guido Guenther <agx@sigxcpu.org>
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030513195928.GB16497@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix> <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318232454.GA19990@bogon.ms20.nix> <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de> <20030513113316.GU3889@bogon.ms20.nix> <20030513192735.GA16497@rembrandt.csv.ica.uni-stuttgart.de> <20030513193625.GA14066@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513193625.GA14066@nevyn.them.org>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2363
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:
[snip]
> > > Just for completeness: I had to use:
> > > 	GCCFLAGS += -mabi=32 -march=r4600 -mtune=r4600 -Wa,--trap
> > > to make gcc-3.3 happy (note the 32 instead of o32).
> > 
> > Yes, IIRC 64 vs. n64 has the same problem.
> 
> That's not quite the same: 64 is o64, n64 is n64.

I don't think so (There's -mabi=o64).
Otherwise I would have built all my NewABI 64bit Executables as
o64 without noticing ever. :-)

> GCC's never called the 32-bit ABI "o32".

True, but it might be clearer if it did.


Thiemo
