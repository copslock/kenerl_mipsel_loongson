Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Mar 2008 22:29:32 +0000 (GMT)
Received: from mail1.pearl-online.net ([62.159.194.147]:2583 "EHLO
	mail1.pearl-online.net") by ftp.linux-mips.org with ESMTP
	id S28578789AbYCUW33 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Mar 2008 22:29:29 +0000
Received: from SNaIlmail.Peter (85.233.32.210.static.cablesurf.de [85.233.32.210])
	by mail1.pearl-online.net (Postfix) with ESMTP id 08669C9E7;
	Fri, 21 Mar 2008 23:29:23 +0100 (CET)
Received: from Indigo2.Peter (Indigo2.Peter [192.168.1.28])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id m2L1t5fM001434;
	Fri, 21 Mar 2008 02:55:05 +0100
Received: from Indigo2.Peter (localhost [127.0.0.1])
	by Indigo2.Peter (8.12.6/8.12.6/Sendmail/Linux 2.6.14-rc2-ip28) with ESMTP id m2LMK8FS000573;
	Fri, 21 Mar 2008 23:20:08 +0100
Received: from localhost (pf@localhost)
	by Indigo2.Peter (8.12.6/8.12.6/Submit) with ESMTP id m2LMK8Qg000570;
	Fri, 21 Mar 2008 23:20:08 +0100
X-Authentication-Warning: Indigo2.Peter: pf owned process doing -bs
Date:	Fri, 21 Mar 2008 23:20:07 +0100 (CET)
From:	peter fuerst <post@pfrst.de>
X-X-Sender: pf@Indigo2.Peter
Reply-To: post@pfrst.de
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] WD33C93: let platform stub override no_sync/fast/dma_mode
In-Reply-To: <20080321212543.6F769C2DF8@solo.franken.de>
Message-ID: <Pine.LNX.4.58.0803212302190.564@Indigo2.Peter>
References: <20080321212543.6F769C2DF8@solo.franken.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips



Hi Thomas,

the code-sequence

	wd33c93_init(...
	if (hdata->wh.no_sync == 0xff)
		hdata->wh.no_sync = 0;

was put/kept there intentionally - in this very order - to enable
"nosync" from the command-line!

	Date: Mon, 12 Feb 2007 15:27:17 +0100 (CET)
	From: peter fuerst <post@pfrst.de>
	To: James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org
	Cc: Ralf Baechle <ralf@linux-mips.org>, Kumba <kumba@gentoo.org>,
	     Thiemo Seufer <ths@networkno.de>, Tim Yamin <plasmaroo@gentoo.org>
	Subject: [PATCH][SCSI] sgiwd93.c: interfacing to wd33c93

	1) sgiwd93 used to switch off asynchronous mode on the wd33c93, discarding
	   any "nosync"-requests from the commandline.
	   But we need to allow "nosync"-requests for selected devices, for example
	   the Pioneer DVD305S.
	   (For the curious: this device accepts the SDTR from wd33c93 and success-
	   fully sends inquiry data in sync mode, but after the data phase in the
	   inquiry command does an unexpected disconnect, seemingly sending no
	   "status" or "command complete". Forcing async transfers makes it work
	   together flawlessly with the wd33c93. Of course, preferable would be, to
	   implement wd33c93's "resume command" stuff, but that probably will not
	   come soon.)
	2) ...
	...

	========================================================================
	--- dc7bdc97927ea1c519f0d8bd3133739600c841d4/drivers/scsi/sgiwd93.c	Sat Oct  7 00:00:00 2006
	+++ new/drivers/scsi/sgiwd93.c	Sun Feb 11 22:10:06 2007
	@@ -250,3 +250,3 @@

	-	hdata->wh.no_sync = 0;
	+	if (0xff == hdata->wh.no_sync) hdata->wh.no_sync = 0;

	========================================================================
	...

On Fri, 21 Mar 2008, Thomas Bogendoerfer wrote:

> Date: Fri, 21 Mar 2008 22:25:43 +0100 (CET)
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> To: linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
> Cc: ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
> Subject: [PATCH] WD33C93: let platform stub override no_sync/fast/dma_mode
>
> SGI machines with WD33C93 allow usage of burst mode DMA, which increases
> performance noticable. To make this selectable by the sgiwd93 stub,
> setting the values for no_sync, fast and dma_mode has been moved to the
> individual platform stubs.
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>
> Please apply for 2.6.26
>
> ...
> diff --git a/drivers/scsi/sgiwd93.c b/drivers/scsi/sgiwd93.c
> index 26cfc56..03e3596 100644
> --- a/drivers/scsi/sgiwd93.c
> +++ b/drivers/scsi/sgiwd93.c
> @@ -263,10 +263,11 @@ static int __init sgiwd93_probe(struct platform_device *pdev)
>  	regs.SASR = wdregs + 3;
>  	regs.SCMD = wdregs + 7;
>
> -	wd33c93_init(host, regs, dma_setup, dma_stop, WD33C93_FS_MHZ(20));
> +	hdata->wh.no_sync = 0;
> +	hdata->wh.fast = 1;
> +	hdata->wh.dma_mode = CTRL_BURST;
>
> -	if (hdata->wh.no_sync == 0xff)
> -		hdata->wh.no_sync = 0;
> +	wd33c93_init(host, regs, dma_setup, dma_stop, WD33C93_FS_MHZ(20));
>
>  	err = request_irq(irq, sgiwd93_intr, 0, "SGI WD93", host);
>  	if (err) {
> ...
