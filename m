Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2008 15:16:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:39877 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023930AbYEIOQS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2008 15:16:18 +0100
Received: from localhost (p6090-ipad302funabasi.chiba.ocn.ne.jp [123.217.144.90])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4BEE3B9CC; Fri,  9 May 2008 23:16:09 +0900 (JST)
Date:	Fri, 09 May 2008 23:17:19 +0900 (JST)
Message-Id: <20080509.231719.93019066.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	david-b@pacbell.net, ab@mycable.de, mgreer@mvista.com,
	i2c@lm-sensors.org, rtc-linux@googlegroups.com,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80,
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0805080306080.32613@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805072226180.25644@cliff.in.clinika.pl>
	<200805071625.20430.david-b@pacbell.net>
	<Pine.LNX.4.55.0805080306080.32613@cliff.in.clinika.pl>
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
X-archive-position: 19179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 9 May 2008 01:43:32 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  Here is a new version of the patch.  I hope I have addressed all your
> concerns, but I am officially dead at the moment, so please do not disturb
> me until this is no longer the case.

This version works fine for me (with i2c-gpio).  And as Jean said,
using i2c_smbus_(write|read)_i2c_block_data instead of
m41t80_i2c_(write|read) works fine too.

---
Atsushi Nemoto
