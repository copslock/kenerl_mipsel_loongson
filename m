Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 12:13:41 +0100 (CET)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:38938 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492245AbZKCLNe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2009 12:13:34 +0100
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
	(envelope-from <broonie@sirena.org.uk>)
	id 1N5HKO-0007fs-68; Tue, 03 Nov 2009 11:13:32 +0000
Date:	Tue, 3 Nov 2009 11:13:32 +0000
From:	Mark Brown <broonie@opensource.wolfsonmicro.com>
To:	Manuel Lauss <manuel.lauss@googlemail.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	alsa-devel@alsa-project.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [alsa-devel] [RFC PATCH 2/3] MIPS: Alchemy: DB1200 AC97+I2S
	audio support.
Message-ID: <20091103111331.GA29431@sirena.org.uk>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com> <1257193305-29996-2-git-send-email-manuel.lauss@gmail.com> <20091103104337.GA26068@opensource.wolfsonmicro.com> <f861ec6f0911030300l130e58cl8d4915af5eec9238@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f861ec6f0911030300l130e58cl8d4915af5eec9238@mail.gmail.com>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 03, 2009 at 12:00:19PM +0100, Manuel Lauss wrote:
> On Tue, Nov 3, 2009 at 11:43 AM, Mark Brown

> > This looks good for me. ?The patch touches both ASoC and MIPS trees -
> > I'm happy with it being merged though either.

> Thanks for having a look!  I'd rather have it go through the MIPS tree,
> otherwise there's a higher chance of merge conflicts.

That's fine for me:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

and if there's any merge issues we can sort them out later.
