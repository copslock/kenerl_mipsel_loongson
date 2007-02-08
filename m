Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 15:50:26 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40208 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038595AbXBHPuV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 15:50:21 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id BE062E1CBA;
	Thu,  8 Feb 2007 16:49:35 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2fh4sOmQbFsB; Thu,  8 Feb 2007 16:49:35 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1AA0AE1CBE;
	Thu,  8 Feb 2007 16:49:35 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l18FnjYW030235;
	Thu, 8 Feb 2007 16:49:46 +0100
Date:	Thu, 8 Feb 2007 15:49:41 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, dan@debian.org,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
In-Reply-To: <cda58cb80702010759w505b4b8br44fb75be28cc8ff0@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0702081535270.18649@blysk.ds.pg.gda.pl>
References: <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com> 
 <20070129161450.GA3384@nevyn.them.org>  <Pine.LNX.4.64N.0701291833480.26916@blysk.ds.pg.gda.pl>
  <20070130.234537.126574565.anemo@mba.ocn.ne.jp> 
 <Pine.LNX.4.64N.0701301713350.9231@blysk.ds.pg.gda.pl> 
 <cda58cb80702010151x62e3b92ap18c63110f7fd4f0c@mail.gmail.com> 
 <Pine.LNX.4.64N.0702011233240.7161@blysk.ds.pg.gda.pl>
 <cda58cb80702010759w505b4b8br44fb75be28cc8ff0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2538/Thu Feb  8 15:37:31 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 1 Feb 2007, Franck Bui-Huu wrote:

> It gives good default behaviours without both user's intervention or
> configuration:
> 
> 	if CONFIG_64BITS
> 		ifndef sym32
> 			if load-y in XKPHYS
> 				sym32 = ''		[1]
> 			elif load-y in CKSEG0
> 				sym32 = '-msym32'	[2]
> 		else
> 			if sym32 eq 'yes'
> 				sym32 = '-msym32'	[3]
> 		endef
> 	fi
> 	cflags-y += $(sym32)
> 
> [1] since there is no reason to add '-msym32' and it would generate
>    wrong code anyways.
> [2] since it's used by all platforms to generate smaller code.
>    Warn if this option is not supported by the tool chains.
> [3] if you really want to generate code loaded in CKSEG0 without
>    -msym32 switch you could always do:
> 
> 		$ make sym32=no

 Well, it seems fair enough indeed, as long as the availability of 
"-msym32" is verified as suggested by Atsushi-san.

>    IMHO, for normal users, this case is probably a configuration
>    bug and that's the reason we should request for a user to ask for
>    it explicitly.

 Hmm, that just raises the question for a definition of who a "normal 
user" is.  And in general -- what "normality" is and why exactly that and 
not something else. ;-)

  Maciej
