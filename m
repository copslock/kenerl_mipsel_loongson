Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Sep 2002 18:13:29 +0200 (CEST)
Received: from p508B4F9D.dip.t-dialin.net ([80.139.79.157]:30848 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122960AbSIHQN2>; Sun, 8 Sep 2002 18:13:28 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g869gdG04428;
	Fri, 6 Sep 2002 11:42:39 +0200
Date: Fri, 6 Sep 2002 11:42:39 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Daniel Jacobowitz <dan@debian.org>,
	Hartvig Ekner <hartvige@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020906114239.B2993@linux-mips.org>
References: <20020905151409.GA25023@nevyn.them.org> <Pine.GSO.3.96.1020905181042.7444G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020905181042.7444G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Sep 05, 2002 at 06:16:49PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 05, 2002 at 06:16:49PM +0200, Maciej W. Rozycki wrote:

> > N32 supports saving and restoring 64-bit registers, which O32 doesn't -
> > according to some comments in GCC, O32 is in fact incompatible with
> > using 64-bit operations.
> 
>  But that old software wouldn't benefit as it didn't perform 64-bit
> operations unless manually coded in software using narrower data types. 
> There is no 64-bit C data type for o32 and long long is quite a recent
> invention -- it didn't exist in the 80s or even early 90s. 

Not in any standard but de facto in existence since a long time.  Anyway,
the changes in floating point in the N32 are so substancial that there
are projects that say without N32 or N64 they don't even need to start
working on their projects.

  Ralf
