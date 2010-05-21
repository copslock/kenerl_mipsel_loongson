Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 May 2010 16:52:49 +0200 (CEST)
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:34281 "EHLO
        master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491204Ab0EUOwn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 May 2010 16:52:43 +0200
Received: from localhost (unknown [127.0.0.1])
        by master.linux-sh.org (Postfix) with ESMTP id 09998636AA;
        Fri, 21 May 2010 14:52:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at linux-sh.org
Received: from master.linux-sh.org ([127.0.0.1])
        by localhost (master.linux-sh.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ss-IVV4xu9RB; Fri, 21 May 2010 23:52:36 +0900 (JST)
Received: by master.linux-sh.org (Postfix, from userid 500)
        id B49DA636B0; Fri, 21 May 2010 23:52:36 +0900 (JST)
Date:   Fri, 21 May 2010 23:52:36 +0900
From:   Paul Mundt <lethal@linux-sh.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Kacur <jkacur@redhat.com>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Arnd Bergmann <arndbergmann@googlemail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        linux-m68k@vger.kernel.org
Subject: Re: bkl: Pushdowns for sound/oss ?
Message-ID: <20100521145236.GA15948@linux-sh.org>
References: <alpine.LFD.2.00.1005211536330.25348@localhost.localdomain> <20100521144055.GB13174@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100521144055.GB13174@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <lethal@linux-sh.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26780
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
Precedence: bulk
X-list: linux-mips

On Fri, May 21, 2010 at 03:40:56PM +0100, Ralf Baechle wrote:
> On Fri, May 21, 2010 at 03:45:04PM +0200, John Kacur wrote:
> > sound/oss/sh_dac_audio.c
> 
> SH3 specific.
> 
This has since been replaced with an ALSA driver, so we can basically
just kill the OSS driver off at this point. I was going to kill it off
before, but wanted to give people some time to test out the new driver.
