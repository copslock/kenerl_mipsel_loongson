Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 17:14:22 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:28690 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122958AbSIEPOW>;
	Thu, 5 Sep 2002 17:14:22 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17mzGs-00038L-00; Thu, 05 Sep 2002 11:14:18 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17myKf-0006Wi-00; Thu, 05 Sep 2002 11:14:09 -0400
Date: Thu, 5 Sep 2002 11:14:09 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Hartvig Ekner <hartvige@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Tor Arntsen <tor@spacetec.no>,
	Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: 64-bit and N32 kernel interfaces
Message-ID: <20020905151409.GA25023@nevyn.them.org>
References: <20020905145954.GA17383@nevyn.them.org> <Pine.GSO.3.96.1020905170830.7444E-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020905170830.7444E-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 05, 2002 at 05:10:51PM +0200, Maciej W. Rozycki wrote:
> On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:
> 
> > No - the point is that all data types have the same size in N32.  It
> > was created explicitly as a transitional sop for people who didn't want
> > to fix their code, but wanted a performance increase from their 64-bit
> > hardware.
> 
>  Well, what's the performance increase of n32 over o32?  The increased
> number of argument registers?  I doubt it's noticeable in most cases.

N32 supports saving and restoring 64-bit registers, which O32 doesn't -
according to some comments in GCC, O32 is in fact incompatible with
using 64-bit operations.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
