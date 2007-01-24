Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2007 10:05:12 +0000 (GMT)
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:15776 "EHLO
	smtp.drzeus.cx") by ftp.linux-mips.org with ESMTP id S20044896AbXAXKFH
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Jan 2007 10:05:07 +0000
Received: from [192.168.128.82] (alcatraz.cendio.se [::ffff:193.12.253.67])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Wed, 24 Jan 2007 11:04:05 +0100
  id 0005B536.45B72F15.0000497B
Message-ID: <45B72F13.4040707@drzeus.cx>
Date:	Wed, 24 Jan 2007 11:04:03 +0100
From:	Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: au1xmmc R6 response support
References: <20070123100814.GA5001@roarinelk.homelinux.net> <45B65A73.90308@drzeus.cx> <20070124055202.GA6446@roarinelk.homelinux.net>
In-Reply-To: <20070124055202.GA6446@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <drzeus-mmc@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus-mmc@drzeus.cx
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> 
> not in my version of 2.6.20-rc5 (and 2.6.19):
> 

HEAD has this fixed. Every spec I can get my hands on states that R1 and
R6 have the same format. So it sounds like this controller is doing
something stupid.

> 
> Without the patch, SD card detection stops with CMD7 returning error.
> 

Can I see a dump with MMC_DEBUG enabled?

On a related note... Would you, or anyone else you know, be willing to
sign up as official maintainer of this driver? Otherwise I'll have to
mark it as unmaintained.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
