Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 16:12:31 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:17064
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225240AbTENPM0>; Wed, 14 May 2003 16:12:26 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19FxvT-001Eq5-00; Wed, 14 May 2003 17:12:15 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19FxvQ-0002fQ-00; Wed, 14 May 2003 17:12:12 +0200
Date: Wed, 14 May 2003 17:12:12 +0200
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030514151212.GC8833@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030513222215.GA440@bogon.ms20.nix> <Pine.GSO.3.96.1030514124924.26213A-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1030514124924.26213A-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 14 May 2003, Guido Guenther wrote:
> 
> > Looking at gcc-3.3:
> > 
> > #define ABI_32  0
> > #define ABI_N32 1
> > #define ABI_64  2
> > #define ABI_EABI 3
> > #define ABI_O64  4
> > 
> > The naming is very "unfortunate", though. We have (n32,64) and (32,o64).
> > Wouldn't it help to at least allow for n64 and o32 commandline options?
> > -mabi=32 and -mabi=64 will have to be kept for Irix compatibility
> > though, I think.
> 
>  Why unfortunate?  You use "32" and "64" for normal stuff, and the rest
> for special cases ("n32" isn't really 32-bit and "o64" isn't really 64-bit
> -- both lie in the middle).

Exactly this is the sort of confusion which makes the naming unfortunate.
-32 and -64 had never much to do with 32/64 bit but designate ABIs.

> Additional aliases of the "n64" and "o32"
> form would make more confusion, IMHO. 

I disagree.


Thiemo
