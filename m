Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 14:14:16 +0100 (CET)
Received: from p508B7CA6.dip.t-dialin.net ([80.139.124.166]:38568 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225302AbSLFNOQ>; Fri, 6 Dec 2002 14:14:16 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB6D7Wv12784;
	Fri, 6 Dec 2002 14:07:32 +0100
Date: Fri, 6 Dec 2002 14:07:32 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021206140732.A9345@linux-mips.org>
References: <Pine.GSO.3.96.1021205143717.29101C-100000@delta.ds2.pg.gda.pl> <3DEF5EB0.A1A18E17@mips.com> <3DF09DA9.B3D108@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DF09DA9.B3D108@mips.com>; from carstenl@mips.com on Fri, Dec 06, 2002 at 01:52:57PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 06, 2002 at 01:52:57PM +0100, Carsten Langgaard wrote:

> I'm afraid I have to speak up again :-(
> Although the new binutils (binutils-mips64el-linux-2.13.1-1.i386.rpm) work on
> the latest sources from linux-mips.org, I have a problem with my local sources.
> 
> I get the following error from the assembler:
> 
> 
> {standard input}: Assembler messages:
> {standard input}:329: Warning: dla used to load 32-bit register
> {standard input}:382: Error: Number (0xffffffff) larger than 32 bits
> {standard input}:408: Warning: dla used to load 32-bit register

These are caused by an !%$@#$!$ incompatible change in gas.  In essence
the code model we're using now requires to pass the additional option
-mgp64.  arch/mips64/Makefile probes for gas accepting this new option.

So standard advice, update your sources.

  Ralf
