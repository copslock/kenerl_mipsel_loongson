Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2003 12:22:04 +0100 (BST)
Received: from p508B5B34.dip.t-dialin.net ([IPv6:::ffff:80.139.91.52]:64970
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224821AbTGVLWC>; Tue, 22 Jul 2003 12:22:02 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6MBLvDB013335;
	Tue, 22 Jul 2003 13:21:57 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6MBLutl013334;
	Tue, 22 Jul 2003 13:21:56 +0200
Date: Tue, 22 Jul 2003 13:21:56 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Wolfgang Denk <wd@denx.de>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: [patch] Generic time fixes
Message-ID: <20030722112156.GA12449@linux-mips.org>
References: <20030722100444.GA4148@linux-mips.org> <20030722102109.ADB10C6D82@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030722102109.ADB10C6D82@atlas.denx.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 22, 2003 at 12:21:04PM +0200, Wolfgang Denk wrote:

> Another common situation especially with embedded systems is that the
> RTC holds the "correct"  time,  and  probably  runs  at  much  higher
> precision  than  the systm clock. In such systems, NTP can be used to
> keep the system time in sync with the RTC, but the system  time  must
> never  be  written  back to the RTC. [Except when explicitely setting
> the date&time.]

True; supposedly the TXOs in RTC have higher long term frequency accuracy
than those commonly used to clock system though some RTC are really
badly off.

> > I share your dislike of updating the RTC for performance reasons; these
> 
> There are more problems with the 11 minute mode.  We  ran  into  this
> issue  for hard on some PowerPC systems. Assume a situation where the
> RTC is connected through a I2C  bus.  Problem  1:  normally  the  i2c
> drivers  will  be  loaded prety late, which means the system will run
> initially with an undefined time. Problem 2: on some  actions  a  i2c
> transfer  involves  programming an on-chip i2c controller, which will
> perform the task and then signal it's done by an interrupt. On such a
> system the 11 minute mode will crash the system because rtc_set  will
> be called from interrupt contect itself.
> 
> There was a  somewhat  controverse  discussion  on  the  linuxppc_dev
> mailing list, without a real solution.

[...]

> And never, ever update the RTC from interrupt context, please.

It's the right thing for > 99% of systems and doing it triggered by an
interrupt seems the right thing.  If you happen to have hardware that
has trouble with updates in interrupts you still could implement the
RTC update procedure to just trigger the update in softirq or process
context, as appropriate.

  Ralf
