Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 21:50:27 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:421
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225229AbTEMUuX>; Tue, 13 May 2003 21:50:23 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19Fgj8-001DTa-00; Tue, 13 May 2003 22:50:22 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19Fgj8-0005BX-00; Tue, 13 May 2003 22:50:22 +0200
Date: Tue, 13 May 2003 22:50:21 +0200
To: Guido Guenther <agx@sigxcpu.org>
Cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030513205021.GC16497@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix> <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318232454.GA19990@bogon.ms20.nix> <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de> <20030513113316.GU3889@bogon.ms20.nix> <20030513192735.GA16497@rembrandt.csv.ica.uni-stuttgart.de> <20030513201144.GY3889@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513201144.GY3889@bogon.ms20.nix>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Guido Guenther wrote:
> On Tue, May 13, 2003 at 09:27:35PM +0200, Thiemo Seufer wrote:
> > Guido Guenther wrote:
> [..snip..] 
> > > to make gcc-3.3 happy (note the 32 instead of o32).
> > 
> > Yes, IIRC 64 vs. n64 has the same problem.
> I think 64 is o64 not n64.

Strange, you are now the second to say so. Where does this idea stem from?

I just had a look at the gcc sources, the mips*-linux config doesn't
support o64 at all.


Thiemo
