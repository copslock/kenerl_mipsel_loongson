Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Feb 2005 19:27:20 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:31241 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225325AbVBKT1E>; Fri, 11 Feb 2005 19:27:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 48942E1C77; Fri, 11 Feb 2005 20:26:58 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12816-07; Fri, 11 Feb 2005 20:26:58 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id EED75E1C67; Fri, 11 Feb 2005 20:26:57 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j1BJR2Nm026856;
	Fri, 11 Feb 2005 20:27:02 +0100
Date:	Fri, 11 Feb 2005 19:27:13 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Cc:	"Stephen P. Becker" <geoman@gentoo.org>,
	Frederic TEMPORELLI - astek <ftemporelli@astek.fr>,
	linux-mips@linux-mips.org
Subject: Re: IP32 - issues with last CVS snapshoot
In-Reply-To: <420D006E.3000107@total-knowledge.com>
Message-ID: <Pine.LNX.4.61L.0502111915510.30117@blysk.ds.pg.gda.pl>
References: <420CEE7F.3080201@astek.fr> <420CF611.5030705@gentoo.org>
 <Pine.LNX.4.61L.0502111825300.30117@blysk.ds.pg.gda.pl>
 <420D006E.3000107@total-knowledge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/700/Fri Feb  4 00:33:15 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 11 Feb 2005, Ilya A. Volynets-Evenbakh wrote:

> O64 may not be supported ABI, but it provides us with a feature that is really
> usefull:
> specifically, it generates 32 bit symbol addresses instead of 64 bit ones.
> This cuts
> down on code size considerably. If this feature was implemented in toolchain
> as separate
> switch, O64 hack could go away.

 Well, the topic has been beaten to death here, so you don't really need 
to illuminate me -- it's only due to this popular request I've implemented 
the ability to do 32-bit builds for 64-bit kernel.  I just wonder why 
people insisting on such a setup don't actually contribute some code to do 
that cleanly and keep switching between hacks as they stop working one by 
one...

> With that said, you are of course right - IP32 code and some drivers are
> broken, because
> they do rely on this feature in many places.

 Having a compiled tree in place these bugs are trivial to track down with 
"find", "objdump", "grep" and some usual shell script magic.

  Maciej
