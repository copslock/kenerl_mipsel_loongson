Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 May 2008 16:01:48 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:33992 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20035649AbYEQPBp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 May 2008 16:01:45 +0100
Received: from localhost (p3241-ipad207funabasi.chiba.ocn.ne.jp [222.145.85.241])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id E2B20AA9A; Sun, 18 May 2008 00:01:27 +0900 (JST)
Date:	Sun, 18 May 2008 00:02:42 +0900 (JST)
Message-Id: <20080518.000242.41199304.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	a.zummo@towertech.it, hvr@gnu.org, akpm@linux-foundation.org,
	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: M41T80: Century Bit support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.55.0805170057370.4049@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805170057370.4049@cliff.in.clinika.pl>
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
X-archive-position: 19290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 17 May 2008 01:25:18 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  Make use of the Century Bit to support years in the range from 1970 to 
> 2169.  Enable toggling of the bit at the end of a century on a clock 
> update.
> ---
>  The clock is used with the Broadcom SWARM and the D-Link DNS-323 
> platform.
> 
>  I have verified correct operation with the SWARM -- the firmware assumes
> 19YY when CB is clear and 20YY otherwise.  Which means years 1900-1969
> will be shown as 2100-2169 in Linux.  I think this is a feature rather
> than a problem.  The firmware does not set the CEB bit itself and does not 
> care of what its state is.
> 
>  I will be happy to hear from a DNS-323 user to confirm or deny whether
> such an interpretation is compatible.

This patch enforces that all (including future) users of this device
must use same interpretation of CB bit.  I think this is too
intrusive.

And I have one (out-of-tree, and only one in the world) board with
this device and its firmware uses different interpretation.
Fortunately I can change this firmware, so this is not a serious
problem for me. ;)

How about doing like this?

1. If CEB was 0, keep current behavior. (does not touch CB bit)

2. If CEB was 1, detect polarity of CB bit on get_datetime, and set or
   clear CB bit on set_datetime based on the polarity.

Please look at "c_polarity" variable in rtc-pcf8563.c driver.

---
Atsushi Nemoto
