Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2007 16:28:52 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:7403 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20024225AbXJAP2n (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2007 16:28:43 +0100
Received: from localhost (p1055-ipad306funabasi.chiba.ocn.ne.jp [123.217.171.55])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A5AB9CC9D; Tue,  2 Oct 2007 00:28:38 +0900 (JST)
Date:	Tue, 02 Oct 2007 00:30:20 +0900 (JST)
Message-Id: <20071002.003020.21363605.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	rongkai.zhan@windriver.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, rtc-linux@googlegroups.com,
	ralf@linux-mips.org, a.zummo@towertech.it
Subject: Re: [PATCH 4/4] MIPS: Remove the legacy RTC codes of MIPS sibyte
 boards
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0710011608130.27280@blysk.ds.pg.gda.pl>
References: <46FF7283.7050702@windriver.com>
	<Pine.LNX.4.64N.0710011608130.27280@blysk.ds.pg.gda.pl>
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
X-archive-position: 16776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 1 Oct 2007 16:10:38 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > This patch removes the legacy RTC codes of MIPS sibyte boards,
> > which are replaced by new RTC class drivers. And a board init
> > routine is added to register sibyte platform devices.
> 
>  Is the system time still set correctly from the RTC chip upon bootstrap 
> with your changes?  I cannot immediately infer it from the patches and my 
> suspicion is it may not anymore.

CONFIG_RTC_HCTOSYS=y can do it, isn't it?

Mark, please update defconfig files appropriately with your patch.

---
Atsushi Nemoto
