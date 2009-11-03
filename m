Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:29:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40382 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493384AbZKCP3R (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:29:17 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA3FUfQT001932;
	Tue, 3 Nov 2009 16:30:41 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA3FUeW2001929;
	Tue, 3 Nov 2009 16:30:40 +0100
Date:	Tue, 3 Nov 2009 16:30:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH 2/3] MIPS: Alchemy: DB1200 AC97+I2S audio support.
Message-ID: <20091103153040.GC1742@linux-mips.org>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com> <1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 02, 2009 at 09:21:44PM +0100, Manuel Lauss wrote:

> Machine driver for DB1200 AC97 and I2S audio systems, intended as a
> proper reference asoc machine for Alchemy-based systems.
> AC97/I2S can be selected at boot time by setting switch S6.7
> 
> Cc: alsa-devel@alsa-project.org
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Depends on patch "ASoC: au1x: convert to platform drivers" in
> Mark Brown's asoc tree to actually work.

Queued for 2.6.33.  I've not seen the dependency but I hope there is no
harm in getting things merged out of order?

Thanks,

  Ralf
