Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 20:51:57 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:57571 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010081AbbC3Svz4IZnr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Mar 2015 20:51:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 9024721BA36;
        Mon, 30 Mar 2015 21:51:55 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id VA6DAB3q0OaS; Mon, 30 Mar 2015 21:51:50 +0300 (EEST)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 979005BC006;
        Mon, 30 Mar 2015 21:51:50 +0300 (EEST)
Date:   Mon, 30 Mar 2015 21:51:50 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Wim Van Sebroeck <wim@iguana.be>,
        David Daney <david.daney@cavium.com>,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] watchdog: octeon: convert to WATCHDOG_CORE API
Message-ID: <20150330185150.GD571@fuloong-minipc.musicnaut.iki.fi>
References: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
 <551992F0.5050809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551992F0.5050809@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Mon, Mar 30, 2015 at 11:16:16AM -0700, David Daney wrote:
> On 03/28/2015 11:05 AM, Aaro Koskinen wrote:
> >Convert OCTEON watchdog to WATCHDOG_CORE API. This enables support
> >for multiple watchdogs on OCTEON boards.
> >
> >Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >---
> >  drivers/watchdog/Kconfig           |   1 +
> >  drivers/watchdog/octeon-wdt-main.c | 185 ++++++++-----------------------------
> >  2 files changed, 39 insertions(+), 147 deletions(-)
> >
> [...]
> 
> You didn't seem to say how it was tested.
> 
> If you have verified that "echo > /dev/watchdog" produces register dumps and
> reboots the board, then the whole series:
> 
> Acked-by: David Daney <david.daney@cavium.com>

Yes, that was exactly my test case:

	root@dsr-1000n:~$ cat /dev/watchdog
	cat: read error: Invalid argument[   44.835019] watchdog watchdog0: watchdog did not stop!

	root@dsr-1000n:~$
	*** NMI Watchdog interrupt on Core 0x0 ***
	        $0      0x0000000000000000      at      0x0000000010008ce0
	[...]
	        sum0    0x0100000000000000      en0     0x01206f4500008000
	*** Chip soft reset soon ***


	U-Boot 1.1.1 (Development build, svnversion: exported) (Build time: Mar 22 2010
- 12:14:14)

	Warning: Board descriptor tuple not found in eeprom, using defaults
	CUST_DSR1000 board revision major:2, minor:0, serial #: unknown
	OCTEON CN5010-SCP pass 1.1, Core clock: 500 MHz, DDR clock: 200 MHz (400 Mhz data rate)

> Thanks for doing this, I had been meaning to make the conversion myself.

One further improvement idea would be to get the register dump logged
also with printk() or panic() so that it could be captured with netconsole
or mtdoops (at least in some cases). Not sure what it would require.
Calling printk() or panic() from the NMI handler didn't quite produce
an expected result...

A.
