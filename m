Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 19:38:25 +0100 (BST)
Received: from smtp110.tiscali.dk ([IPv6:::ffff:62.79.79.110]:33248 "EHLO
	smtp110.tiscali.dk") by linux-mips.org with ESMTP
	id <S8224827AbTFJSiX> convert rfc822-to-8bit; Tue, 10 Jun 2003 19:38:23 +0100
Received: from cpmail4.dk.tiscali.com (mail.tiscali.dk [212.54.64.159])
	by smtp110.tiscali.dk (8.12.6p2/8.12.6) with ESMTP id h5AIcM56032710;
	Tue, 10 Jun 2003 20:38:22 +0200 (CEST)
	(envelope-from mleopold@tiscali.dk)
Received: from [130.225.96.2] by cpmail4.dk.tiscali.com with HTTP; Tue, 10 Jun 2003 20:38:19 +0200
Date: Tue, 10 Jun 2003 20:38:19 +0200
Message-ID: <3EDD28A400000BAC@cpfe4.be.tisc.dk>
In-Reply-To: <20030610181100.GB529@rembrandt.csv.ica.uni-stuttgart.de>
From: mleopold@tiscali.dk
Subject: Re: Linux on Indigo2 (IP28) - R10000
To: linux-mips@linux-mips.org
Cc: "Thiemo Seufer" <ica2_ts@csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Return-Path: <mleopold@tiscali.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mleopold@tiscali.dk
Precedence: bulk
X-list: linux-mips

Hi Thiemo.
> The solution is to use a special kernel with compiled in cache barriers
> (needs a not-yet written compiler patch) and careful managing of page
> table accesses from userspace (needs rmap, and thus 2.5 Kernel).

I noticed this guy talking about O2 and having some patches and precompiled
kernels. Are these in anyway related to what you are talking about?

http://www.linux-mips.org/~glaurung/

> I'm working sowly on it, but I get constantly distracted by toolchain
> issues. :-)

I looked arround your website and saw "mips64-linux-ip28-2002-06-28.tar.gz"
whoo.. Sounds exiting =]

> > There was some talk in Febuary on a guy got Linux up and running on
an 
> > Origin 200 - and some bootable cd's. That sounded prety interesting
=]
> The Origin is easier to suppot, it has coherent I/O.

And you are probably going to tell me that this is the same reson that the
O2 is working, right?

> > Btw: I also got my hands on an Octane (IP30) with an R10000 (195 Mhz)
-
> > I haven't tried to install on this one, but that might be interesting
too..
> This one is also I/O coherent, so chances are much better than for IP28.

Are you saying I might get this one working with the Debian boot-images
that I already tried, or?

--
Regards Martin Leopold.
Dept. of Computer Science, University of Copenhagen
