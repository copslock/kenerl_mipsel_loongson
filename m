Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 10:01:51 +0000 (GMT)
Received: from hall.aurel32.net ([88.191.38.19]:57989 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20027096AbYBRKBs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 10:01:48 +0000
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1JR2oQ-000678-4s; Mon, 18 Feb 2008 11:01:26 +0100
Date:	Mon, 18 Feb 2008 11:01:26 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>, ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: mips/bcm47xx/setup.c compile error
Message-ID: <20080218100126.GA22519@hall.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20080217200947.GH1403@cs181133002.pp.htv.fi> <20080218074944.GA9317@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080218074944.GA9317@hall.aurel32.net>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Mon, Feb 18, 2008 at 08:49:44AM +0100, Aurelien Jarno wrote:
> On Sun, Feb 17, 2008 at 10:09:47PM +0200, Adrian Bunk wrote:
> > Commit d3c319f9c8d9ee2c042c60b8a1bbd909dcc42782 causes the following 
> > compile error:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      arch/mips/bcm47xx/setup.o
> > /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c: In function 'bcm47xx_get_invariants':
> > /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:95: error: 'struct ssb_sprom' has no member named 'r1'
> > /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:97: error: 'struct ssb_sprom' has no member named 'r1'
> > /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:99: error: 'struct ssb_sprom' has no member named 'r1'
> > /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:101: error: 'struct ssb_sprom' has no member named 'r1'
> > /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:103: error: 'struct ssb_sprom' has no member named 'r1'
> > /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:105: error: 'struct ssb_sprom' has no member named 'r1'
> > make[2]: *** [arch/mips/bcm47xx/setup.o] Error 1
> > 
> 
> It has been broken by commit d3c319f9c8d9ee2c042c60b8a1bbd909dcc42782. I
> am working on a fix.

This commit has removed the r1 version of the SPROM data structure in
favor of a version independant structure. However, it hasn't changed the
other parts of code that are still using the r1 version.

Two patches are needed to fix that, one for the SSB subsystem, one for
the BCM47XX platform. I will send them in separate emails. 

I have tested them on a WGT634U machine, with the following patch:
http://www.linux-mips.org/archives/linux-mips/2008-02/msg00041.html

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
