Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 07:51:04 +0000 (GMT)
Received: from hall.aurel32.net ([88.191.38.19]:47263 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20023750AbYBRHvC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 07:51:02 +0000
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1JR0m6-0002YF-QH; Mon, 18 Feb 2008 08:50:54 +0100
Date:	Mon, 18 Feb 2008 08:50:54 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Adrian Bunk <adrian.bunk@movial.fi>
Cc:	linux-mips@linux-mips.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: mips: compile testing of 2.6.25-rc2
Message-ID: <20080218075054.GB9317@hall.aurel32.net>
References: <20080218010314.GO1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080218010314.GO1403@cs181133002.pp.htv.fi>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Mon, Feb 18, 2008 at 03:03:14AM +0200, Adrian Bunk wrote:
> I did a compile testing of all mips defconfigs in 2.6.25-rc2.
> 
> The results were:
> 
> 
> Systems without a defconfig:
> 
> CONFIG_BCM47XX
> CONFIG_SGI_IP28
> CONFIG_SIBYTE_CRHINE
> CONFIG_SIBYTE_CARMEL
> CONFIG_SIBYTE_CRHONE
> CONFIG_SIBYTE_RHONE
> CONFIG_SIBYTE_LITTLESUR
> CONFIG_SIBYTE_SENTOSA
> 
> Can people using these systems provide defconfig's for them?
> A defconfig is nothing special, it's enough to simply put the .config 
> used for one machine into arch/mips/configs/ .

I will work on a defconfig for the BCM47XX platform when the build
failure is fixed.

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
