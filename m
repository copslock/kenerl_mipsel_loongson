Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2004 22:50:04 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:44655
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225391AbUBMWuE>; Fri, 13 Feb 2004 22:50:04 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Arm8H-0004D5-00; Fri, 13 Feb 2004 23:50:01 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Arm8G-00037K-00; Fri, 13 Feb 2004 23:50:00 +0100
Date: Fri, 13 Feb 2004 23:50:00 +0100
To: David Daney <ddaney@avtrex.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Prevent dead code/data removal with gcc 3.4
Message-ID: <20040213224959.GB20118@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.55.0402131453360.15042@jurand.ds.pg.gda.pl> <20040213145316.GA23810@linux-mips.org> <20040213222253.GA20118@rembrandt.csv.ica.uni-stuttgart.de> <402D513F.8080205@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402D513F.8080205@avtrex.com>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Thiemo Seufer wrote:
> 
> >Ralf Baechle wrote:
> > 
> >
> >>On Fri, Feb 13, 2004 at 03:20:27PM +0100, Maciej W. Rozycki wrote:
> >>
> >>   
> >>
> >>>2. It changes inline-assembly function prologues to be embedded within 
> >>>the
> >>>functions, which makes them a bit safer as they can now explicitly refer
> >>>to the "regs" struct and assures the code won't be removed or reordered.
> >>>     
> >>>
> >>It is possible that gcc changes one of the registers before save_static
> >>and I can't imagine there's a reliable way to fix this in the inline
> >>version.
> >
> >As long as __asm__ __volatile__ works as documented, this can't happen.
> >
> My understanding is that with gcc-3.4 that __asm__ __volatile__ does not 
> protect against dead code removal.  If the code is not dead __volatile__ 
> works as documented, but dead code removal still happens.

The inline version isn't dead code, and gcc isn't allowed to reschedule
code around a __asm__ __volatile__, so the patch should be ok.


Thiemo
