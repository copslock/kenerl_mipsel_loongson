Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jul 2009 21:38:10 +0200 (CEST)
Received: from ogre.sisk.pl ([217.79.144.158]:57771 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493222AbZGZTiD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Jul 2009 21:38:03 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id 1C56E14DAE4;
	Sun, 26 Jul 2009 18:49:14 +0200 (CEST)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03506-06; Sun, 26 Jul 2009 18:48:56 +0200 (CEST)
Received: from tosh.localnet (220-bem-13.acn.waw.pl [82.210.184.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 2DD1E14DB65;
	Sun, 26 Jul 2009 18:48:56 +0200 (CEST)
From:	"Rafael J. Wysocki" <rjw@sisk.pl>
To:	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
Date:	Sun, 26 Jul 2009 21:38:18 +0200
User-Agent: KMail/1.11.2 (Linux/2.6.31-rc4-rjw; KDE/4.2.4; x86_64; ; )
Cc:	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frans Pop <elendil@planet.nl>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@gmail.com>
References: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com> <200907252139.30674.rjw@sisk.pl> <20090726150834.GB27022@sirena.org.uk>
In-Reply-To: <20090726150834.GB27022@sirena.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907262138.18716.rjw@sisk.pl>
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
Return-Path: <rjw@sisk.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23784
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
Precedence: bulk
X-list: linux-mips

On Sunday 26 July 2009, Mark Brown wrote:
> On Sat, Jul 25, 2009 at 09:39:30PM +0200, Rafael J. Wysocki wrote:
> 
> > Yes, they would.  In general, you'd probably want to do something like this:
> 
> > static struct dev_pm_ops au1xmmc_pmops = {
> > 	.resume		= au1xmmc_resume,
> > 	.suspend		= au1xmmc_suspend,
> > 	.freeze		= au1xmmc_resume,
> > 	.thaw		= au1xmmc_suspend,
> 
> I'd have expected freeze and thaw to be the other way around here?

Sure, sorry.

.suspend() corresponds to .freeze() and .poweroff(), while .resume()
corresponds to .thaw() and .restore().

Best,
Rafael
