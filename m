Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 19:43:08 +0100 (MET)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:24337
	"EHLO iris1.csv.ica.uni-stuttgart.de") by ralf.linux-mips.org
	with ESMTP id <S870691AbSLFSmx>; Fri, 6 Dec 2002 19:42:53 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18KNPp-0006wy-00; Fri, 06 Dec 2002 19:41:33 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18KNPp-0004PO-00; Fri, 06 Dec 2002 19:41:33 +0100
Date: Fri, 6 Dec 2002 19:41:33 +0100
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021206184133.GL23743@rembrandt.csv.ica.uni-stuttgart.de>
References: <20021206172438.GJ23743@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1021206192349.26674T-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1021206192349.26674T-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Fri, 6 Dec 2002, Thiemo Seufer wrote:
> 
> > Maybe I wasn't clear about it, I meant kernels with 32 bit address
> > space but 64 bit register width, allowing for userland N32 ABI.
> > 
> > E.g. the old DECstations with R4k CPU and limited memory would fit
> > in this scheme. :-)
> 
>  I'm only going to support n64 on the DECstation.  You are welcomed to do
> n32 stuff yourself if you want to. 

What does N64 on the DECstation better than N32 could do? N32 has
more compact code, better cache usage and less memory consumption.

> > >  Remember we are writing of the kernel -- we don't know what userland is
> > > going to bring us
> > 
> > I don't understand this. The kernel _defines_ what the userland is allowed
> > to do.
> 
>  I haven't considered you may mean crippling the available user address
> space.

IIRC is the maximum of RAM 448 MB on some machines. Actually utilizing
an user address space larger than 2 GB would mean a RAM/Swap ratio of
about 1:4, IOW, it likely gets unusable slow.

Is there any point besides of hack value to use N64 on these machines?


Thiemo
