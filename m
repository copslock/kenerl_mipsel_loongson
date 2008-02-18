Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Feb 2008 07:50:04 +0000 (GMT)
Received: from hall.aurel32.net ([88.191.38.19]:33695 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20024027AbYBRHuB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Feb 2008 07:50:01 +0000
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1JR0ky-0002QW-HY; Mon, 18 Feb 2008 08:49:44 +0100
Date:	Mon, 18 Feb 2008 08:49:44 +0100
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Adrian Bunk <bunk@kernel.org>
Cc:	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: mips/bcm47xx/setup.c compile error
Message-ID: <20080218074944.GA9317@hall.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Adrian Bunk <bunk@kernel.org>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	"John W. Linville" <linville@tuxdriver.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20080217200947.GH1403@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20080217200947.GH1403@cs181133002.pp.htv.fi>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Sun, Feb 17, 2008 at 10:09:47PM +0200, Adrian Bunk wrote:
> Commit d3c319f9c8d9ee2c042c60b8a1bbd909dcc42782 causes the following 
> compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      arch/mips/bcm47xx/setup.o
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c: In function 'bcm47xx_get_invariants':
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:95: error: 'struct ssb_sprom' has no member named 'r1'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:97: error: 'struct ssb_sprom' has no member named 'r1'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:99: error: 'struct ssb_sprom' has no member named 'r1'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:101: error: 'struct ssb_sprom' has no member named 'r1'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:103: error: 'struct ssb_sprom' has no member named 'r1'
> /home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/bcm47xx/setup.c:105: error: 'struct ssb_sprom' has no member named 'r1'
> make[2]: *** [arch/mips/bcm47xx/setup.o] Error 1
> 

It has been broken by commit d3c319f9c8d9ee2c042c60b8a1bbd909dcc42782. I
am working on a fix.


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
