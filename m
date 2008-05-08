Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2008 05:51:25 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:19421 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022210AbYEHEvX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 May 2008 05:51:23 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m484p8cn001412;
	Thu, 8 May 2008 05:51:08 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m484p6Ob001399;
	Thu, 8 May 2008 05:51:06 +0100
Date:	Thu, 8 May 2008 05:51:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Jean Delvare <khali@linux-fr.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 2/4] RTC: SWARM I2C board initialization
Message-ID: <20080508045106.GB25531@linux-mips.org>
References: <Pine.LNX.4.55.0805070031410.16173@cliff.in.clinika.pl> <20080507085953.2c08b854@hyperion.delvare> <Pine.LNX.4.55.0805072145040.25644@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0805072145040.25644@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 07, 2008 at 10:13:23PM +0100, Maciej W. Rozycki wrote:

>  Ralf -- what do you think about the Makefile changes?  I can send you a 
> separate patch which will reduce the span of this one.

I like it; we maybe should consider getting rid of most of the libs-* stuff
in arch/mips/Makefile.  Some of it might be causing subtle bugs such as
routines exported to modules not getting linked into the kernel proper.

  Ralf
