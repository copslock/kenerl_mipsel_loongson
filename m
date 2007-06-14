Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 15:09:38 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:26634 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20022938AbXFNOJg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 15:09:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 8CE66E1D18;
	Thu, 14 Jun 2007 16:09:24 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bX0WJvaK8kKd; Thu, 14 Jun 2007 16:09:24 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 39EB8E1C6B;
	Thu, 14 Jun 2007 16:09:24 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l5EE9Zo1013851;
	Thu, 14 Jun 2007 16:09:35 +0200
Date:	Thu, 14 Jun 2007 15:09:31 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time
 code.
In-Reply-To: <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
References: <11818164011355-git-send-email-fbuihuu@gmail.com> 
 <11818164023940-git-send-email-fbuihuu@gmail.com>  <20070614111748.GA8223@alpha.franken.de>
 <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3419/Thu Jun 14 15:49:39 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 14 Jun 2007, Franck Bui-Huu wrote:

> The current code doesn't automatically calibrate any hpt. It was
> really hard to guess which ones need that so now if you need to
> calibrate your hpt, then you have to call calibrate_hpt().

 You are wrong -- calibration is currently automatic if a platform 
provides a HPT, but has not set up its frequency:

		if (!mips_hpt_frequency)
			mips_hpt_frequency = calibrate_hpt();

Which should normally be the case unless there is no way to do 
calibration, when a platform can provide a hardcoded value.  There is 
nothing to guess here.

 I'll have a look at your patches, but I hope you have got about the most 
interesting configuration right, which is the DEC platform, where you can 
have one of these:

1. No HPT at all.

2. HPT in the chipset.

3. HPT in CP0.

depending on the configuration as determined at the run time, with no 
predefined frequency in the cases #2 and #3.

  Maciej
