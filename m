Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jul 2004 17:41:52 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:36660
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224943AbUGVQlr>; Thu, 22 Jul 2004 17:41:47 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Bngdd-0006MC-00; Thu, 22 Jul 2004 18:41:45 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Bngdc-0006fQ-00; Thu, 22 Jul 2004 18:41:44 +0200
Date: Thu, 22 Jul 2004 18:41:44 +0200
To: Ralf Ackermann <rac@KOM.tu-darmstadt.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Q: (cross)compiling for the Meshcube  (fwd)
Message-ID: <20040722164144.GG965@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.58.0407221756020.4845@shofar.kom.e-technik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407221756020.4845@shofar.kom.e-technik.tu-darmstadt.de>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Ackermann wrote:
[snip]
>  - Is there any chance to use a native gcc on the cube itself?
> 	(could this e.g. been done by chrooting into a (which?)
> 	existing MIPS Linux distribution that is mounted via NFS)

Native compiles should work. AFAIK the Meshcube uses a customized
debian, most likely a testing/unstable mix. If you have a debian system
around, you can install the "debootstrap" package there and use it to
create a mips chroot, configure it, export it to the Meshcube, and
install the "build-essential" package there. This gives you the usual
native debian development environment.


Thiemo
