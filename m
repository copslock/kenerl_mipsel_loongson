Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2008 21:05:00 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:62966 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20034048AbYEGUE5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2008 21:04:57 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m47K425v029903;
	Wed, 7 May 2008 22:04:02 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m47K3Wmk029899;
	Wed, 7 May 2008 21:03:41 +0100
Date:	Wed, 7 May 2008 21:03:31 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Alessandro Zummo <alessandro.zummo@towertech.it>
cc:	rtc-linux@googlegroups.com, Jean Delvare <khali@linux-fr.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [rtc-linux] [RFC][PATCH 0/4] RTC: Use class devices as a persistent
 clock
In-Reply-To: <20080507085739.4f538d2e@i1501.lan.towertech.it>
Message-ID: <Pine.LNX.4.55.0805072055010.25644@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0805062333390.16173@cliff.in.clinika.pl>
 <20080507085739.4f538d2e@i1501.lan.towertech.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Alessandro,

>    you did a great work. you have my Acked-by on the rtc/ntp code, but
>  I think we'd need some reports from current users of the m41t81 driver
>  before pushing that one in.

 Thanks for appreciation.  You are right about the driver -- I have
explicitly asked for help to test it with the patch submission.  Actually
the only other user right now is a D-Link DNS-323 ARM-based system.  I
meant to cc the maintainer of the platform, but in the end I forgot.  
I'll do it now -- thanks for the point.

  Maciej
