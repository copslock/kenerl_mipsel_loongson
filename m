Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 17:27:59 +0000 (GMT)
Received: from hermes.fachschaften.tu-muenchen.de ([IPv6:::ffff:129.187.202.12]:58088
	"HELO hermes.fachschaften.tu-muenchen.de") by linux-mips.org
	with SMTP id <S8225336AbUAMR16>; Tue, 13 Jan 2004 17:27:58 +0000
Received: (qmail 22352 invoked from network); 13 Jan 2004 17:25:12 -0000
Received: from mimas.fachschaften.tu-muenchen.de (129.187.202.58)
  by hermes.fachschaften.tu-muenchen.de with QMQP; 13 Jan 2004 17:25:12 -0000
Date: Tue, 13 Jan 2004 18:27:51 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix DECSTATION depends
Message-ID: <20040113172751.GN9677@fs.tum.de>
References: <20040113015202.GE9677@fs.tum.de> <20040113022826.GC1646@linux-mips.org> <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0401131401300.21962@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Return-Path: <bunk@fs.tum.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@fs.tum.de
Precedence: bulk
X-list: linux-mips

On Tue, Jan 13, 2004 at 02:07:54PM +0100, Maciej W. Rozycki wrote:
> On Tue, 13 Jan 2004, Ralf Baechle wrote:
> 
> > > it seems the following is required in Linus' tree to get correct depends 
> > > for DECSTATION:
> > 
> > Thanks,  applied.
> 
>  The dependency was intentional: stable for 32-bit, experimental for
> 64-bit.  I'm reverting the change immediately.  Please always contact me
> before applying non-obvious changes for the DECstation.
> 
>  If there's anything wrong with the depends, it should be fixed elsewhere.  
> Details, please.

Does -mabi=64 really work on any DECstation?

AFAIK none of the R2000, R3x00 and the R4x00 do support the 64bit ABI.

>   Maciej

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
