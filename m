Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2009 14:45:57 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:51716 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20023662AbZEPNpr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 16 May 2009 14:45:47 +0100
Received: from localhost (p1193-ipad311funabasi.chiba.ocn.ne.jp [123.217.211.193])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 10856A978; Sat, 16 May 2009 22:45:42 +0900 (JST)
Date:	Sat, 16 May 2009 22:45:41 +0900 (JST)
Message-Id: <20090516.224541.39155366.anemo@mba.ocn.ne.jp>
To:	broonie@opensource.wolfsonmicro.com
Cc:	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	ralf@linux-mips.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Add TXx9 AC link controller driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090515190558.GA13050@sirena.org.uk>
	<1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp>
References: <20090514185945.GO28291@sirena.org.uk>
	<20090516.001202.173372394.anemo@mba.ocn.ne.jp>
	<20090515190558.GA13050@sirena.org.uk>
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
X-archive-position: 22778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 15 May 2009 20:05:58 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > OTOH, I want to keep arch code as is.  There are some TXx9 SoC
> > variations and they can have different baseaddr/irq/dma.  I want to
> > leave these details in arch code and make ASoC drivers generic as
> > possible.
> 
> This is the common situation for SoC CPUs - most silicon vendors reuse
> the same IPs in diffierent combinations on different CPUs.  The normal
> approach is to have the generic code for each SoC set up the resources
> for the devices that are present on that particular SoC.  This avoids
> the need for each board using the SoC to have to replicate the
> information.

Yes, and I tried to do so in "TXx9: Add ACLC support" patch.

>  arch/mips/include/asm/txx9/generic.h  |    5 ++++
>  arch/mips/include/asm/txx9/tx4927.h   |    2 +
>  arch/mips/include/asm/txx9/tx4938.h   |    1 +
>  arch/mips/include/asm/txx9/tx4939.h   |    1 +
>  arch/mips/txx9/Kconfig                |    3 ++
>  arch/mips/txx9/generic/setup.c        |   36 +++++++++++++++++++++++++++
>  arch/mips/txx9/generic/setup_tx4927.c |   43 +++++++++++++++++++++++++++++++++
>  arch/mips/txx9/generic/setup_tx4938.c |   11 ++++++++
>  arch/mips/txx9/generic/setup_tx4939.c |    9 +++++++

These are "the generic code for each SoC set up the resources for
the devices that are present on that particular SoC".

>  arch/mips/txx9/rbtx4927/setup.c       |    7 ++++-
>  arch/mips/txx9/rbtx4938/setup.c       |    1 +
>  arch/mips/txx9/rbtx4939/setup.c       |    1 +

And these are setup codes for each boards.

Is this acceptable?  I'm not sure whether you are saying Ack or Nack
for this approach.

---
Atsushi Nemoto
