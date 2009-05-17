Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 May 2009 15:47:03 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:63027 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20023819AbZEQOq4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 May 2009 15:46:56 +0100
Received: from localhost (p1253-ipad313funabasi.chiba.ocn.ne.jp [123.217.227.253])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5BF14AA01; Sun, 17 May 2009 23:46:50 +0900 (JST)
Date:	Sun, 17 May 2009 23:46:49 +0900 (JST)
Message-Id: <20090517.234649.229275666.anemo@mba.ocn.ne.jp>
To:	broonie@opensource.wolfsonmicro.com
Cc:	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	ralf@linux-mips.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Add TXx9 AC link controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090516142511.GB5254@sirena.org.uk>
References: <20090515190558.GA13050@sirena.org.uk>
	<20090516.224541.39155366.anemo@mba.ocn.ne.jp>
	<20090516142511.GB5254@sirena.org.uk>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 16 May 2009 15:25:12 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > Is this acceptable?  I'm not sure whether you are saying Ack or Nack
> > for this approach.
> 
> Yes, this approach is fine.  All I'm saying is that you should be
> setting up devices for the DAIs and the platform device and putting the
> resources that are common to the SoC in there and not in the device that
> is being used to use the board-specific sound driver.

Then I will update "ASoC: Add TXx9 AC link controller driver" part and
send again in a few days.  Thanks.

---
Atsushi Nemoto
