Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 20:27:41 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:30628
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225221AbTEMT1i>; Tue, 13 May 2003 20:27:38 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19FfR3-001Dfa-00; Tue, 13 May 2003 21:27:37 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19FfR1-000538-00; Tue, 13 May 2003 21:27:35 +0200
Date: Tue, 13 May 2003 21:27:35 +0200
To: linux-mips@linux-mips.org
Cc: Guido Guenther <agx@sigxcpu.org>
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030513192735.GA16497@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix> <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318232454.GA19990@bogon.ms20.nix> <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de> <20030513113316.GU3889@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513113316.GU3889@bogon.ms20.nix>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Guido Guenther wrote:
[snip]
> > > So to build kernels for say IP22 R5k I'd change the current
> > > 	GCCFLAGS += -mcpu=r5000 -mips2 -Wa,--trap
> > > to 
> > > 	GCCFLAGS += -mabi=o32 -march=R5000 -mtune=R5000 -Wa,--trap
> > > where as for R4X00 I use
> > > 	GCCFLAGS += -mabi=o32 -march=R4600 -mtune=R4600 -Wa,--trap
> > > Correct?
> > 
> > Yes, this should work. You can leave the -mtune out, since it defaults
> > to the value of -march anyway.
> Just for completeness: I had to use:
> 	GCCFLAGS += -mabi=32 -march=r4600 -mtune=r4600 -Wa,--trap
> to make gcc-3.3 happy (note the 32 instead of o32).

Yes, IIRC 64 vs. n64 has the same problem.

> gcc-3.2 doesn't seem
> to handle these options correctly at all.

AFAICS you can still drop the -mtune part.


Thiemo
