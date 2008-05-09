Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2008 01:18:08 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:60412 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20023576AbYEIASG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2008 01:18:06 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m490HbsK006475;
	Fri, 9 May 2008 02:17:37 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m490HMcN006468;
	Fri, 9 May 2008 01:17:23 +0100
Date:	Fri, 9 May 2008 01:17:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	a.zummo@towertech.it, khali@linux-fr.org, ralf@linux-mips.org,
	tglx@linutronix.de, akpm@linux-foundation.org,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	ab@mycable.de, mgreer@mvista.com
Subject: Re: [RFC][PATCH 4/4] RTC: SMBus support for the M41T80, etc. driver
In-Reply-To: <20080508.133847.74565891.nemoto@toshiba-tops.co.jp>
Message-ID: <Pine.LNX.4.55.0805090054300.5944@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805070102460.16173@cliff.in.clinika.pl>
 <20080508.133847.74565891.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 8 May 2008, Atsushi Nemoto wrote:

> For write transfer, you must use only one i2c_msg.  If two i2c_msg
> were used, the slave address is inserted between register number and
> first data.  This chip cannot accept such sequence.

 Correct, thank you for pointing it out -- verified with the datasheet.  I 
will send an updated patch separately taking other suggestions into 
account as well.

> On success, m41t80_i2c_transfer() returns positive value, but
> m41t80_transfer() should return 0.

 I think the check should be for values below zero as originally instead.  
Thanks for the point again.

  Maciej
