Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jan 2007 08:32:34 +0000 (GMT)
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:26016 "EHLO
	smtp.drzeus.cx") by ftp.linux-mips.org with ESMTP id S20049583AbXAYIc3
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Jan 2007 08:32:29 +0000
Received: from [192.168.128.82] (alcatraz.cendio.se [::ffff:193.12.253.67])
  (AUTH: PLAIN drzeus, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by smtp.drzeus.cx with esmtp; Thu, 25 Jan 2007 09:31:23 +0100
  id 0005B536.45B86ADB.000021B8
Message-ID: <45B86AD8.8050802@drzeus.cx>
Date:	Thu, 25 Jan 2007 09:31:20 +0100
From:	Pierre Ossman <drzeus-mmc@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
CC:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: au1xmmc R6 response support
References: <20070123100814.GA5001@roarinelk.homelinux.net> <45B65A73.90308@drzeus.cx> <20070124055202.GA6446@roarinelk.homelinux.net> <45B72F13.4040707@drzeus.cx> <20070125072000.GA8257@roarinelk.homelinux.net> <20070125081944.GA8358@roarinelk.homelinux.net>
In-Reply-To: <20070125081944.GA8358@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <drzeus-mmc@drzeus.cx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: drzeus-mmc@drzeus.cx
Precedence: bulk
X-list: linux-mips

Manuel Lauss wrote:
> 
> Actually, the bug is that because of MMC_RSP_R6 not being handled in
> the switch in au1xmmc_send_command(), the controller gets told that
> no response is expected. I changed the R6 to R1 in mmc.h, thats why
> it worked in the demoboard, and it also works now on the previously
> thought-to-be-broken HW.
> 

So in order to detect any similar problems in the future, I'd like a
patch that adds a "default:" to that switch statement.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
