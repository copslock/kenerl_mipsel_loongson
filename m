Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 18:36:18 +0100 (MET)
Received: from nixon.xkey.com ([IPv6:::ffff:209.245.148.124]:56529 "HELO
	nixon.xkey.com") by ralf.linux-mips.org with SMTP
	id <S869795AbSLFRgG>; Fri, 6 Dec 2002 18:36:06 +0100
Received: (qmail 18150 invoked from network); 6 Dec 2002 17:35:29 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 6 Dec 2002 17:35:29 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gB6HYfT02667
	for linux-mips@linux-mips.org; Fri, 6 Dec 2002 09:34:41 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Fri, 6 Dec 2002 09:34:41 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021206093441.A2631@wumpus.attbi.com>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20021206135110.GD23743@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1021206165118.26674N-100000@delta.ds2.pg.gda.pl> <20021206164558.GH23743@rembrandt.csv.ica.uni-stuttgart.de> <20021206180241.A7492@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021206180241.A7492@linux-mips.org>; from ralf@linux-mips.org on Fri, Dec 06, 2002 at 06:02:41PM +0100
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Fri, Dec 06, 2002 at 06:02:41PM +0100, Ralf Baechle wrote:

> The first kernel was built as 64-bit ELF using 64-bit pointer and everything
> 64-bit.  The second kernel was built using the -Wa,-32 trick.  That's over
> 12% of bloat for full 64-bitiness which brings zero gain.

Yes, but that 12% overhead will be reduced when gcc stops using those
crappy macros for everything, and finds some common subexpressions.

-- greg
