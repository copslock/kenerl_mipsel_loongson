Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 May 2013 22:46:33 +0200 (CEST)
Received: from juliette.telenet-ops.be ([195.130.137.74]:57991 "EHLO
        juliette.telenet-ops.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826533Ab3ELUqctJwpc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 12 May 2013 22:46:32 +0200
Received: from ayla.of.borg ([84.193.72.141])
        by juliette.telenet-ops.be with bizsmtp
        id b8mV1l00432ts5g068mVyj; Sun, 12 May 2013 22:46:29 +0200
Received: from geert (helo=localhost)
        by ayla.of.borg with local-esmtp (Exim 4.71)
        (envelope-from <geert@linux-m68k.org>)
        id 1UbdA4-0001WU-UW; Sun, 12 May 2013 22:46:28 +0200
Date:   Sun, 12 May 2013 22:46:28 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linux Kernel Development <linux-kernel@vger.kernel.org>
cc:     Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: Build regressions/improvements in v3.10-rc1 (mips)
In-Reply-To: <alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
Message-ID: <alpine.DEB.2.00.1305122245510.5463@ayla.of.borg>
References: <alpine.DEB.2.00.1305122130270.3789@ayla.of.borg> <alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, 12 May 2013, Geert Uytterhoeven wrote:
> However, the full list of errors isn't that unmanageable, so I'm following
> up with a digested list...

arch/mips/kernel/crash_dump.c:67:17: error: assignment makes pointer from integer without a cast [-Werror]: 1 errors in 1 logs
arch/mips/kernel/crash_dump.c:67:2: error: implicit declaration of function 'kmalloc' [-Werror=implicit-function-declaration]: 1 errors in 1 logs
	v3.10-rc1/mips/mips-allmodconfig


drivers/net/ethernet/3com/3c59x.c:1026:2: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]: 1 errors in 1 logs
drivers/net/ethernet/3com/3c59x.c:1038:3: error: implicit declaration of function 'pci_iounmap' [-Werror=implicit-function-declaration]: 1 errors in 1 logs
	v3.10-rc1/mips/mips-allmodconfig


sound/oss/soundcard.c:69:31: error: 'MAX_DMA_CHANNELS' undeclared here (not in a function): 1 errors in 1 logs
	v3.10-rc1/mips/mips-allmodconfig

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
