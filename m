Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jun 2003 13:56:31 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:3374
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224827AbTFJM43>; Tue, 10 Jun 2003 13:56:29 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19Pifn-0008GS-00; Tue, 10 Jun 2003 14:56:23 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19Pifn-0003Pa-00; Tue, 10 Jun 2003 14:56:23 +0200
Date: Tue, 10 Jun 2003 14:56:23 +0200
To: Wolfgang Denk <wd@denx.de>
Cc: Baruch Chaikin <bchaikin@il.marvell.com>,
	linux-mips@linux-mips.org, Rabeeh Khoury <rabeeh@galileo.co.il>
Subject: Re: Building a stand-alone FS on a very limited flash (newbie question)
Message-ID: <20030610125623.GC30175@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030609165612.GE32450@rembrandt.csv.ica.uni-stuttgart.de> <20030610123843.CDE2EC5FD7@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610123843.CDE2EC5FD7@atlas.denx.de>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Wolfgang Denk wrote:
[snip]
> > > The platform I'm using is very limited - only one MTD block of 
> > > 2.5 MB is available for the file system, out of a 4 MB flash:
> > >    0.5 MB is allocated for the firmware code
> > >    1.0 MB for the compressed kernel image
> > >    2.5 MB for the (compressed?) file system
> > > 
> > > For example, I've noticed LibC itself is ~5 MB !
> > 
> > You'll need a smaller libc, dietlibc comes to mind.
> > http://www.dietlibc.org/
> 
> I don't really understand what all this discussion is about.
> 
> 2.5 MB is plenty of space for a compressed ramdisk  image  using  the
> standard  C  library. The ramdisk image included with our ELDK is 1.3
> MB:
[snip]
> # ls -l lib | grep -v '^[ld]'
> total 2433

I conclude ELDK consists of little more than the basic networking utilities,
and the libc-related parts eat up most of the space. A more feature-rich
system probably can't afford to waste that much.


Thiemo
