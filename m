Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 17:54:57 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:6930 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022685AbXFNQyz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 17:54:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 900F0E1D18;
	Thu, 14 Jun 2007 18:54:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGjeeMpd8Hqp; Thu, 14 Jun 2007 18:54:40 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 4489CE1C6B;
	Thu, 14 Jun 2007 18:54:40 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l5EGssh8013856;
	Thu, 14 Jun 2007 18:54:54 +0200
Date:	Thu, 14 Jun 2007 17:54:49 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
In-Reply-To: <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.64N.0706141746300.25868@blysk.ds.pg.gda.pl>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> 
 <11818164023940-git-send-email-fbuihuu@gmail.com>  <20070614111748.GA8223@alpha.franken.de>
  <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com> 
 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
 <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>
 <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3419/Thu Jun 14 15:49:39 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 14 Jun 2007, Maciej W. Rozycki wrote:

>  Please note that this generic calibration code may be used for 
> calibrating the CP0 timer too -- all that you need is defining 
> mips_timer_state appropriately, i.e. to flip at the HZ rate (it may be 
> based on one of the south bridge choices mentioned above or some 
> free-running counter for example), but people seem to prefer to write 
> their own code for some reason. ;-)

 To clarify myself -- the return value of mips_timer_state() has to flip 
regularly, once each way per HZ.  The duty cycle does not have to be 50% 
-- any will do.

  Maciej
