Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2009 15:25:26 +0100 (BST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:38464 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023573AbZEPOZU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2009 15:25:20 +0100
Received: from 82-41-28-43.cable.ubr04.sgyl.blueyonder.co.uk ([82.41.28.43] helo=finisterre.sirena.org.uk)
	by cassiel.sirena.org.uk with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1M5KpB-0002SE-VA; Sat, 16 May 2009 15:25:18 +0100
Received: from broonie by finisterre.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1M5Kp6-00065l-Cx; Sat, 16 May 2009 15:25:12 +0100
Date:	Sat, 16 May 2009 15:25:12 +0100
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	ralf@linux-mips.org
Message-ID: <20090516142511.GB5254@sirena.org.uk>
References: <20090514185945.GO28291@sirena.org.uk> <20090516.001202.173372394.anemo@mba.ocn.ne.jp> <20090515190558.GA13050@sirena.org.uk> <20090516.224541.39155366.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090516.224541.39155366.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 82.41.28.43
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [alsa-devel] [PATCH] ASoC: Add TXx9 AC link controller driver
X-SA-Exim-Version: 4.2.1 (built Wed, 25 Jun 2008 17:14:11 +0000)
X-SA-Exim-Scanned: Yes (on cassiel.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22779
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Sat, May 16, 2009 at 10:45:41PM +0900, Atsushi Nemoto wrote:

> Is this acceptable?  I'm not sure whether you are saying Ack or Nack
> for this approach.

Yes, this approach is fine.  All I'm saying is that you should be
setting up devices for the DAIs and the platform device and putting the
resources that are common to the SoC in there and not in the device that
is being used to use the board-specific sound driver.
