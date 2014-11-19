Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 21:54:14 +0100 (CET)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:45338 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014030AbaKSUyNVdFi5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 21:54:13 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id C021421B929;
        Wed, 19 Nov 2014 22:54:12 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id m7azCdBejTng; Wed, 19 Nov 2014 22:54:06 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 354585BC018;
        Wed, 19 Nov 2014 22:54:06 +0200 (EET)
Date:   Wed, 19 Nov 2014 22:54:05 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Huacai Chen <chenhc@lemote.com>
Subject: Re: Lemote 2F build failure
Message-ID: <20141119205405.GA6796@fuloong-minipc.musicnaut.iki.fi>
References: <20141119144717.GF8625@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141119144717.GF8625@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44300
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

On Wed, Nov 19, 2014 at 03:47:18PM +0100, Ralf Baechle wrote:
> Since I while already I'm getting this failure:
> 
> ERROR: "loongson_sysconf" [arch/mips/loongson/common/serial.ko] undefined!
> scripts/Makefile.modpost:90: recipe for target '__modpost' failed
> make[1]: *** [__modpost] Error 1
> Makefile:1097: recipe for target 'modules' failed
> make: *** [modules] Error 2
> 
> 
> Below a config file to trigger the issue.

Are you sure you posted the right config? The modular serial 8250 build
works fine for me for 2F, and also your config works.

However, for Loongson 3 build I'm able to reproduce the same.
Possibly caused by c7d3555ac075 (MIPS: Loongson 3: Add HT-linked PCI
support), which enables HT_PCI and adds loongson_sysconf reference
to serial.ko, but the symbol is not exported to modules.

In loongson.h:

	#if defined(CONFIG_HT_PCI)
	#define LOONGSON_PCIIO_BASE     loongson_sysconf.pci_io_base
	#else
	#define LOONGSON_PCIIO_BASE     0x1fd00000
	#endif

And in loongsong serial.c:

	uart8250_data[mips_machtype][0].iobase =
		loongson_uart_base - LOONGSON_PCIIO_BASE;

A.
