Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 May 2010 18:13:07 +0200 (CEST)
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36155 "EHLO
        cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492218Ab0EUQNE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 May 2010 18:13:04 +0200
Received: from broonie by cassiel.sirena.org.uk with local (Exim 4.69)
        (envelope-from <broonie@sirena.org.uk>)
        id 1OFUq6-0001Jx-P0; Fri, 21 May 2010 17:12:46 +0100
Date:   Fri, 21 May 2010 17:12:46 +0100
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Kacur <jkacur@redhat.com>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Arnd Bergmann <arndbergmann@googlemail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Paul Mundt <lethal@linux-sh.org>,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        linux-m68k@vger.kernel.org
Subject: Re: bkl: Pushdowns for sound/oss ?
Message-ID: <20100521161246.GA31383@sirena.org.uk>
References: <alpine.LFD.2.00.1005211536330.25348@localhost.localdomain> <20100521144055.GB13174@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100521144055.GB13174@linux-mips.org>
X-Cookie: BOFH excuse
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: broonie@sirena.org.uk
X-SA-Exim-Scanned: No (on cassiel.sirena.org.uk); SAEximRunCond expanded to false
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips

On Fri, May 21, 2010 at 03:40:56PM +0100, Ralf Baechle wrote:
> On Fri, May 21, 2010 at 03:45:04PM +0200, John Kacur wrote:

> > sound/oss/sh_dac_audio.c

> SH3 specific.

I believe this either has been or easily can be replaced by a modern
ASoC driver and so it's probably as easy to drop it as updated it.
