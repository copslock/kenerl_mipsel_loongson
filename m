Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 19:06:07 +0100 (MET)
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:684 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S869802AbSLFSF5>; Fri, 6 Dec 2002 19:05:57 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gB6I41l08600;
	Fri, 6 Dec 2002 19:04:01 +0100
Date: Fri, 6 Dec 2002 19:04:01 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Carsten Langgaard <carstenl@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: Latest sources from CVS.
Message-ID: <20021206190401.A7806@linux-mips.org>
References: <20021206164558.GH23743@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.3.96.1021206175502.26674R-100000@delta.ds2.pg.gda.pl> <20021206172438.GJ23743@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021206172438.GJ23743@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Fri, Dec 06, 2002 at 06:24:38PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 06, 2002 at 06:24:38PM +0100, Thiemo Seufer wrote:

> Maybe I wasn't clear about it, I meant kernels with 32 bit address
> space but 64 bit register width, allowing for userland N32 ABI.
> 
> E.g. the old DECstations with R4k CPU and limited memory would fit
> in this scheme. :-)

I'm considering kernels with just 2-level page tables as a step into that
direction.  With 16kB pages that permits for 64GB of virtual address
space, with 4kB pages; with a bit of tweaking we should be able to
maintain the ability to map 2GB in the userspace.

  Ralf
