Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Mar 2009 15:44:24 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:2003 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21366526AbZCXPoR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Mar 2009 15:44:17 +0000
Received: from localhost (p8221-ipad206funabasi.chiba.ocn.ne.jp [222.145.82.221])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C631DA142; Wed, 25 Mar 2009 00:44:10 +0900 (JST)
Date:	Wed, 25 Mar 2009 00:44:19 +0900 (JST)
Message-Id: <20090325.004419.39153027.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	khickey@rmicorp.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v2 5/6] Alchemy: DB1300 blink leds on timer tick
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090324131707.GA6509@linux-mips.org>
References: <1237582306-10800-5-git-send-email-khickey@rmicorp.com>
	<1237582306-10800-6-git-send-email-khickey@rmicorp.com>
	<20090324131707.GA6509@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22135
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 24 Mar 2009 14:17:07 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Blinks the dots on the hex display on the DB1300 board every 1000 timer ticks.
> > This can help tell the difference between a soft and hard hung board.
> 
> How about putting this into a software timer.  The Malta does that for its
> ASCII display, see arch/mips/mti-malta/malta-display.c.

Or you can implement a LED driver or GPIO accessors (with leds-gpio)
and enable LEDS_TRIGGER_HEARTBEAT.  As a bonus you can control these
dots from userland and/or use them as HDD access LEDs, etc.

---
Atsushi Nemoto
