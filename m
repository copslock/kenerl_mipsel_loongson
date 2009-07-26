Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Jul 2009 17:08:51 +0200 (CEST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:57847 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493041AbZGZPIo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 26 Jul 2009 17:08:44 +0200
Received: from 82-41-28-43.cable.ubr04.sgyl.blueyonder.co.uk ([82.41.28.43] helo=finisterre.sirena.org.uk)
	by cassiel.sirena.org.uk with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1MV5L6-0005wL-AW; Sun, 26 Jul 2009 16:08:40 +0100
Received: from broonie by finisterre.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1MV5L0-0007rq-QT; Sun, 26 Jul 2009 16:08:34 +0100
Date:	Sun, 26 Jul 2009 16:08:34 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc:	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frans Pop <elendil@planet.nl>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@gmail.com>
Message-ID: <20090726150834.GB27022@sirena.org.uk>
References: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com>
 <200907252019.01266.elendil@planet.nl>
 <20090725191037.GE14062@dtor-d630.eng.vmware.com>
 <200907252139.30674.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200907252139.30674.rjw@sisk.pl>
X-Cookie: Tomorrow, you can be anywhere.
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 82.41.28.43
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
X-SA-Exim-Version: 4.2.1 (built Wed, 25 Jun 2008 17:14:11 +0000)
X-SA-Exim-Scanned: Yes (on cassiel.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Sat, Jul 25, 2009 at 09:39:30PM +0200, Rafael J. Wysocki wrote:

> Yes, they would.  In general, you'd probably want to do something like this:

> static struct dev_pm_ops au1xmmc_pmops = {
> 	.resume		= au1xmmc_resume,
> 	.suspend		= au1xmmc_suspend,
> 	.freeze		= au1xmmc_resume,
> 	.thaw		= au1xmmc_suspend,

I'd have expected freeze and thaw to be the other way around here?
