Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Oct 2015 19:41:06 +0200 (CEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:33307 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009984AbbJGRlE15xnU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Oct 2015 19:41:04 +0200
Received: from blackmetal.musicnaut.iki.fi (85-76-50-28-nat.elisa-mobile.fi [85.76.50.28])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 32EB56998F;
        Wed,  7 Oct 2015 20:41:02 +0300 (EEST)
Date:   Wed, 7 Oct 2015 20:40:00 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [RFT PATCH] mips: lemote2f_defconfig: convert to use libata PATA
 drivers
Message-ID: <20151007173959.GC26187@blackmetal.musicnaut.iki.fi>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com>
 <1442245918-27631-6-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442245918-27631-6-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49469
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

On Mon, Sep 14, 2015 at 05:51:47PM +0200, Bartlomiej Zolnierkiewicz wrote:
> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
> 
> * testing efforts are divided between two subsystems
> 
> * having duplicate drivers for same hardware confuses users
> 
> This patch converts lemote2f_defconfig to use libata PATA
> drivers.
> 
> PS This platform uses CS5536 chipset which (due to historical
> reasons) has basic support in AMD/nVidia PATA host driver and
> full support in a newer CS5536 PATA one (pata_cs5536).  Thus
> most likely this platform should switch to using the latter
> host driver.
> 
> Cc: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Maybe too late but:

	Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

I also tested PATA_CS5536 and that works too, but it gives a slightly
slower disk (27MB/s vs 33MB/s)...

A.
