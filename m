Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 15:50:26 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:55251 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20029464AbXIZOuR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 15:50:17 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 129F9400ED;
	Wed, 26 Sep 2007 16:49:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id zD-WqecO8htc; Wed, 26 Sep 2007 16:49:43 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 5F7A4400A9;
	Wed, 26 Sep 2007 16:49:43 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8QEnkmm019633;
	Wed, 26 Sep 2007 16:49:46 +0200
Date:	Wed, 26 Sep 2007 15:49:41 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
In-Reply-To: <46FA5FFA.1060704@gmail.com>
Message-ID: <Pine.LNX.4.64N.0709261525510.30122@blysk.ds.pg.gda.pl>
References: <20070925181353.GA15412@deprecation.cyrius.com> <46FA1260.4000404@gmail.com>
 <20070926091443.GA10236@deprecation.cyrius.com> <46FA2C39.9020503@gmail.com>
 <20070926102412.GK3337@deprecation.cyrius.com>
 <Pine.LNX.4.64N.0709261226340.30122@blysk.ds.pg.gda.pl> <46FA5FFA.1060704@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4404/Wed Sep 26 14:53:15 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 26 Sep 2007, Franck Bui-Huu wrote:

> Except that if CONFIG_BUILD_ELF64 is set then we assume that the kernel
> is linked in XKPHYS which results in Martin's crash since his kernel is
> linked in CKSEG0.
> 
> If you can recall that was done for a micro-optimization in __pa() but it
> was a huge mistake because it relies on the configuration of BUILD_ELF64
> to be setup correctly by the user... So in this case there's no point to
> set CONFIG_BUILD_ELF64='y' since it makes the kernel bigger and slower.
> But it used to work until my change, so my own fault.

 While, as expressed previously, the assumption of CONFIG_BUILD_ELF64 
meaning XKPHYS mapping is questionable, a requirement for the user to 
somehow magically know that the two became related somehow is 
unreasonable.  Especially as in many cases people just copy an old .config 
over to a new version of the kernel and run `make oldconfig'; I have 
certainly not done anything else for years.

 Given the dependency is quite straightforward it could have been sorted 
out with a reverse dependency in Kconfig based on the load addresses 
specified in Makefile -- boring, but easily done.  That assuming the 
failure of -msym32 resulting from the use of an older unsupported 
toolchain would be reported as fatal to the user, together with 
information of which versions are the minimum.

 Of course requiring a different version of the toolchain based on whether 
XKPHYS or KSEG0 mapping is used (i.e. newer for the latter!) is 
questionable too, but that is a different matter.

  Maciej
