Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Sep 2002 18:12:50 +0200 (CEST)
Received: from p508B4F9D.dip.t-dialin.net ([80.139.79.157]:29568 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122960AbSIHQMt>; Sun, 8 Sep 2002 18:12:49 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g869UnT04205;
	Fri, 6 Sep 2002 11:30:49 +0200
Date: Fri, 6 Sep 2002 11:30:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Daniel Jacobowitz <dan@debian.org>,
	Hartvig Ekner <hartvige@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020906113049.A2993@linux-mips.org>
References: <20020905145954.GA17383@nevyn.them.org> <Pine.GSO.3.96.1020905170830.7444E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1020905170830.7444E-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Sep 05, 2002 at 05:10:51PM +0200
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 05, 2002 at 05:10:51PM +0200, Maciej W. Rozycki wrote:

> > No - the point is that all data types have the same size in N32.  It
> > was created explicitly as a transitional sop for people who didn't want
> > to fix their code, but wanted a performance increase from their 64-bit
> > hardware.
> 
>  Well, what's the performance increase of n32 over o32?  The increased
> number of argument registers?  I doubt it's noticeable in most cases.

That's a minor optimization.  More important is the availability of
MIPS III/IV and MIPS64 instruction sets which means 64-bit integer registers
and 32 64-bit double precission fp registers.

  Ralf
