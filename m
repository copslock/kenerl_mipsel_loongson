Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 19:59:31 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:53295
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224827AbTFJS72>; Tue, 10 Jun 2003 19:59:28 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19PoL9-0002Dh-00; Tue, 10 Jun 2003 20:59:27 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19PoL9-0004UF-00; Tue, 10 Jun 2003 20:59:27 +0200
Date: Tue, 10 Jun 2003 20:59:27 +0200
To: mleopold@tiscali.dk
Cc: linux-mips@linux-mips.org
Subject: Re: Linux on Indigo2 (IP28) - R10000
Message-ID: <20030610185927.GC529@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030610181100.GB529@rembrandt.csv.ica.uni-stuttgart.de> <3EDD28A400000BAC@cpfe4.be.tisc.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDD28A400000BAC@cpfe4.be.tisc.dk>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

mleopold@tiscali.dk wrote:
> Hi Thiemo.
> > The solution is to use a special kernel with compiled in cache barriers
> > (needs a not-yet written compiler patch) and careful managing of page
> > table accesses from userspace (needs rmap, and thus 2.5 Kernel).
> 
> I noticed this guy talking about O2 and having some patches and precompiled
> kernels. Are these in anyway related to what you are talking about?
> 
> http://www.linux-mips.org/~glaurung/

Partially yes, the O2 as a ELF32 machine allows a different (and more
performant) solution for the speculative store problem.

> > I'm working sowly on it, but I get constantly distracted by toolchain
> > issues. :-)
> 
> I looked arround your website and saw "mips64-linux-ip28-2002-06-28.tar.gz"
> whoo.. Sounds exiting =]

I know it's somewhat outdated. :-)

> > > There was some talk in Febuary on a guy got Linux up and running on an
> > > Origin 200 - and some bootable cd's. That sounded prety interesting =]
> > The Origin is easier to suppot, it has coherent I/O.
> 
> And you are probably going to tell me that this is the same reson that the
> O2 is working, right?

Only the R5000 O2 is working. The R10000 O2 is the problematic one.

> > > Btw: I also got my hands on an Octane (IP30) with an R10000 (195 Mhz) -
> > > I haven't tried to install on this one, but that might be interesting too..
> > This one is also I/O coherent, so chances are much better than for IP28.
> 
> Are you saying I might get this one working with the Debian boot-images
> that I already tried, or?

It might work, but I know way to little about the Octane to say something
definitive.


Thiemo
