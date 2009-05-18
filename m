Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2009 17:10:41 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:59836 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20023946AbZERQKe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 May 2009 17:10:34 +0100
Received: from localhost (p6039-ipad213funabasi.chiba.ocn.ne.jp [124.85.71.39])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 60599A988; Tue, 19 May 2009 01:10:29 +0900 (JST)
Date:	Tue, 19 May 2009 01:10:28 +0900 (JST)
Message-Id: <20090519.011028.74560296.anemo@mba.ocn.ne.jp>
To:	broonie@opensource.wolfsonmicro.com
Cc:	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	ralf@linux-mips.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Add TXx9 AC link controller driver
 (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090518153317.GA27195@sirena.org.uk>
References: <20090518142305.GE1629@sirena.org.uk>
	<20090519.002542.39155238.anemo@mba.ocn.ne.jp>
	<20090518153317.GA27195@sirena.org.uk>
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
X-archive-position: 22791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 18 May 2009 16:33:18 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, May 19, 2009 at 12:25:42AM +0900, Atsushi Nemoto wrote:
> 
> > Thank you for elaboration.  Then, this untested patch (on top of the
> > last patch) is what you mean?  If yes, I will split this into arch
> > part and driver part, and then update both patches.
> 
> Partly - I'd also expect to see the resources moved around in the
> architecture code so that they are on the platform devices that are
> being used to probe the DAIs (unless that's what the architecture side
> of your patch was doing, patch wasn't quite giving me enough context to
> be 100% clear).

Now the resources are provided with "txx9aclc-ac97" platform device
which used to probe DAIs.  I will send whole patchset again after some
testing.

> You could also roll the resource requesting and unrequesting into the
> probe functions for the DAI & DMA platform devices, though that is not
> essential.

OK, I will move them into txx9aclc_ac97_dev_probe().  Then I can use
devres functions to make the resource management much simpler.

---
Atsushi Nemoto
