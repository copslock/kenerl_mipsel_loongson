Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2007 16:32:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:27130 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022008AbXHMPct (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2007 16:32:49 +0100
Received: from localhost (p1166-ipad311funabasi.chiba.ocn.ne.jp [123.217.211.166])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 9155AA68A
	for <linux-mips@linux-mips.org>; Tue, 14 Aug 2007 00:31:28 +0900 (JST)
Date:	Tue, 14 Aug 2007 00:32:42 +0900 (JST)
Message-Id: <20070814.003242.59465104.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Use generic NTP code for all MIPS platforms
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S20023068AbXHMO0W/20070813142622Z+9352@ftp.linux-mips.org>
References: <S20023068AbXHMO0W/20070813142622Z+9352@ftp.linux-mips.org>
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
X-archive-position: 16161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 13 Aug 2007 15:26:17 +0100, linux-mips@linux-mips.org wrote:
> Author: Ralf Baechle <ralf@linux-mips.org> Mon Aug 13 15:26:12 2007 +0100
> Commit: 4c1ebc8bc02fa6f30ccddacca7552dc2c8686792
> Gitweb: http://www.linux-mips.org/g/linux/4c1ebc8b
> Branch: master
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

With this, we now have this in Kconfig:

config GENERIC_CMOS_UPDATE
	bool
	default y

I think there are no point using GENERIC_CMOS_UPDATE for users of the
new-style RTC_CLASS drivers or platforms with no RTC.

There are some possible ways:

A) Make default of GENERIC_CMOS_UPDATE to "n" and select it explicitly
   on platforms which need it.

B) Make default of GENERIC_CMOS_UPDATE depends on CONFIG_RTC_CLASS.

C) set no_sync_cmos_clock to 0 on time_init() if rtc_mips_set_mmss was
   NULL and rtc_mips_set_time and was null_rtc_set_time.

And combinations ot variations of those...

Which are preferred?  Any comments?

---
Atsushi Nemoto
