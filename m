Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 18:57:59 +0000 (GMT)
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:9888 "EHLO
	smtp.drzeus.cx") by ftp.linux-mips.org with ESMTP id S28583180AbXAWS5z
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jan 2007 18:57:55 +0000
Received: from [10.8.2.152] (wlan152.drzeus.cx [::ffff:10.8.2.152])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Tue, 23 Jan 2007 19:56:49 +0100
  id 0005B536.45B65A72.00000C34
Message-ID: <45B65A73.90308@drzeus.cx>
Date:	Tue, 23 Jan 2007 19:56:51 +0100
From:	Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: au1xmmc R6 response support
References: <20070123100814.GA5001@roarinelk.homelinux.net>
In-Reply-To: <20070123100814.GA5001@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <drzeus-mmc@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus-mmc@drzeus.cx
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> Hi,
> 
> here's a trivial patch which adds R6 reponse support to the au1xmmc
> driver. Fixes SD card detection / operation.
> 

NAK. MMC_RSP_R1 and MMC_RSP_R6 have the same value so this will break
the switch.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
