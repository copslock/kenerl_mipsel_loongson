Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 22:19:01 +0200 (CEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:38679 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992285AbcIMUSyubvOp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 22:18:54 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-14-194-nat.elisa-mobile.fi [85.76.14.194])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id A4173234151;
        Tue, 13 Sep 2016 23:18:53 +0300 (EEST)
Date:   Tue, 13 Sep 2016 23:18:53 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kernel-build-reports@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: MIPS build failures in linux-next
Message-ID: <20160913201853.GD1658@raspberrypi.musicnaut.iki.fi>
References: <57d7cbc5.c62f1c0a.ad370.89de@mx.google.com>
 <m2k2efy42i.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m2k2efy42i.fsf@baylibre.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55137
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

On Tue, Sep 13, 2016 at 12:47:49PM -0700, Kevin Hilman wrote:
> Hello MIPS folks,
> 
> At kernelci.org, we added MIPS builds to the build testing we're doing,

Great!

> > cavium_octeon_defconfig (mips) — FAIL, 2 errors, 9 warnings, 0 section mismatches
> >
> > Errors:
> >     arch/mips/include/asm/mach-cavium-octeon/mangle-port.h:19:40: error: right shift count >= width of type [-Werror=shift-count-overflow]
> >     arch/mips/include/asm/mach-cavium-octeon/mangle-port.h:19:40: error: right shift count >= width of type [-Werror=shift-count-overflow]

This is known and a patch is pending:

	https://patchwork.linux-mips.org/patch/14039/

Thanks,

A.
