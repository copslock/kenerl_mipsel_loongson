Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jul 2009 22:38:12 +0200 (CEST)
Received: from Cpsmtpm-eml106.kpnxchange.com ([195.121.3.10]:56663 "EHLO
	CPSMTPM-EML106.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492979AbZGYUiG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 25 Jul 2009 22:38:06 +0200
Received: from aragorn.fjphome.nl ([84.85.147.182]) by CPSMTPM-EML106.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Sat, 25 Jul 2009 22:38:05 +0200
From:	Frans Pop <elendil@planet.nl>
To:	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2] au1xmmc: dev_pm_ops conversion
Date:	Sat, 25 Jul 2009 22:38:02 +0200
User-Agent: KMail/1.9.9
Cc:	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Arnaud Faucher <arnaud.faucher@gmail.com>,
	Erik Ekman <erik@kryo.se>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Paul Mundt <lethal@linux-sh.org>
References: <1248275919-3296-1-git-send-email-manuel.lauss@gmail.com> <200907252139.30674.rjw@sisk.pl> <200907252221.45407.elendil@planet.nl>
In-Reply-To: <200907252221.45407.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907252238.05296.elendil@planet.nl>
X-OriginalArrivalTime: 25 Jul 2009 20:38:06.0083 (UTC) FILETIME=[D04AB530:01CA0D67]
Return-Path: <elendil@planet.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23778
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elendil@planet.nl
Precedence: bulk
X-list: linux-mips

On Saturday 25 July 2009, you wrote:
> > I'll fix up the floppy and hp-wmi patches.
>
> Note that those are already in mainline, as is pcspkr.

Here's an overview of commits (that I could find) already in mainline that 
look to have gotten it wrong:

6daa79b3  drivers/serial/sh-sci.c	(Paul Mundt)
2dbc8a23  drivers/video/hitfb.c		(Paul Mundt)
35db715b  drivers/input/misc/pcspkr.c	(/me)
2702403c  drivers/platform/x86/hp-wmi.c	(/me)
142a735b  drivers/block/floppy.c	(/me)
