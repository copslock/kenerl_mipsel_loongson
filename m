Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 18:20:06 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:47634 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122958AbSIEQUF>;
	Thu, 5 Sep 2002 18:20:05 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17n0IA-0003Cf-00; Thu, 05 Sep 2002 12:19:42 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17mzLx-0001Jc-00; Thu, 05 Sep 2002 12:19:33 -0400
Date: Thu, 5 Sep 2002 12:19:33 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Hartvig Ekner <hartvige@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020905161933.GA5023@nevyn.them.org>
References: <20020905151409.GA25023@nevyn.them.org> <Pine.GSO.3.96.1020905181042.7444G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020905181042.7444G-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 05, 2002 at 06:16:49PM +0200, Maciej W. Rozycki wrote:
> On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:
> 
> > N32 supports saving and restoring 64-bit registers, which O32 doesn't -
> > according to some comments in GCC, O32 is in fact incompatible with
> > using 64-bit operations.
> 
>  But that old software wouldn't benefit as it didn't perform 64-bit
> operations unless manually coded in software using narrower data types. 
> There is no 64-bit C data type for o32 and long long is quite a recent
> invention -- it didn't exist in the 80s or even early 90s. 

Right.  You don't recompile and get a magic bullet speed improvement
(well, you do, but not a drastic one I think); but you don't recompile
and get a magic bullet binary incompatibility either.  Then you add
64-bit pieces by hand as necessary.

That's my understanding anyway.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
