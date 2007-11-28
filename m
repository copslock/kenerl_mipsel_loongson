Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 01:39:33 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:54856 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S20038661AbXK1BjZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Nov 2007 01:39:25 +0000
Received: from SNaIlmail.Peter (77.47.3.174.static.cablesurf.de [77.47.3.174])
	by mail1.pearl-online.net (Postfix) with ESMTP id 00AE4C8CE;
	Wed, 28 Nov 2007 02:39:55 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id lAS1d45L000971;
	Wed, 28 Nov 2007 02:39:04 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.20-ip28) with ESMTP id lAS1XcNp000585;
	Wed, 28 Nov 2007 02:33:38 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id lAS1Xc0o000582;
	Wed, 28 Nov 2007 02:33:38 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Wed, 28 Nov 2007 02:33:37 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28 support 
In-Reply-To: <20071126224004.D885AC2B26@solo.franken.de>
Message-ID: <Pine.LNX.4.58.0711280206450.407@Indigo2.Peter>
References: <20071126224004.D885AC2B26@solo.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Hello Thomas,

unfortunately a little change to ip28_be_interrupt is needed (sorry, that
it was not yet applied):

---
diff -u -p a/arch/mips/sgi-ip22/ip28-berr.c b/arch/mips/sgi-ip22/ip28-berr.c
--- a/arch/mips/sgi-ip22/ip28-berr.c
+++ b/arch/mips/sgi-ip22/ip28-berr.c
@@ -597,7 +597,7 @@ static int ip28_be_interrupt(const struc
 			goto mips_be_fatal;

 	/* Any state other than "GIO transaction bus timed out" is fatal. */
-	if (gio_err_stat & GIO_ERRMASK & ~SGIMC_GSTAT_TIME)
+	if (gio_err_stat & GIO_ERRMASK /* & ~SGIMC_GSTAT_TIME */)
 		goto mips_be_fatal;

 	/* Finding `cpu_err_addr' in the insn at EPC is fatal. */
---

Since identification of HPC3-dma-addresses in ip28_be_interrupt does not
work as intended, currently any GIO-bus-error must be taken as fatal, or
a "real" bus-error might slip through undetected as "speculative":
When the bus-error occurs CBP is already advanced, so it won't match the
offending address. Examining the current dma-descriptor for a pbuf-address-
range, that might contain this address, isn't possible either, since NDP
is already advanced to the next descriptor.

GIO error 0x401:<TIME > @ 0x7e390000

HPC3 (scsi1) @ 1fb92000: ctl 00000014, ndp 2043c010, cbp 7e390180

Dumping sgiwd93_host1 dma-descriptors: 900000002043c000:
                pnext     pbuf  cntinfo
       [  0] 2043c010 7e390000 00002000 8192	cbp == [0].pbuf+0x180
ndp -> [  1] 2043c020 7e392000 00002000 8192
       [  2] 2043c030 7e394000 00002000 8192
       ...
       [255] 2043c000 00000000 80000000 0

So, for reliable detection of HPC3-dma-addresses the bus-error-handler would
need access to the descriptor-chain of each HPC3-driver, which would require
any such driver to register its descriptor chain with the bus-error-handler...

Experience suggests, that the possibility of false positives, caused by the
workaround, should be comparatively neglibible.


kind regards

peter



On Mon, 26 Nov 2007, Thomas Bogendoerfer wrote:

> Date: Mon, 26 Nov 2007 23:40:04 +0100 (CET)
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> To: linux-mips@linux-mips.org
> Cc: ralf@linux-mips.org
> Subject: [PATCH] IP28 support
>
> Add support for SGI IP28 machines (Indigo 2 with R10k CPUs)
> This work is mainly based on Peter Fuersts work.
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>
> ...
> diff --git a/arch/mips/sgi-ip22/ip28-berr.c b/arch/mips/sgi-ip22/ip28-berr.c
> new file mode 100644
> index 0000000..e61e8f3
> --- /dev/null
> +++ b/arch/mips/sgi-ip22/ip28-berr.c
> ...
