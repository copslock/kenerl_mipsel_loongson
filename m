Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 20:13:38 +0100 (BST)
Received: from mx0.towertech.it ([213.215.222.73]:60594 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S20022204AbXJBTN2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 20:13:28 +0100
Received: (qmail 6658 invoked from network); 2 Oct 2007 21:13:17 +0200
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 2 Oct 2007 21:13:17 +0200
Date:	Tue, 2 Oct 2007 15:14:15 +0200
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	rtc-linux@googlegroups.com
Cc:	macro@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	rongkai.zhan@windriver.com, i2c@lm-sensors.org,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	a.zummo@towertech.it
Subject: Re: [rtc-linux] Re: [PATCH 4/4] MIPS: Remove the legacy RTC codes
 of MIPS sibyte boards
Message-ID: <20071002151415.672d0a1e@i1501.lan.towertech.it>
In-Reply-To: <Pine.LNX.4.64N.0710012001300.27280@blysk.ds.pg.gda.pl>
References: <46FF7283.7050702@windriver.com>
	<Pine.LNX.4.64N.0710011608130.27280@blysk.ds.pg.gda.pl>
	<20071002.003020.21363605.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0710012001300.27280@blysk.ds.pg.gda.pl>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alessandro.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Mon, 1 Oct 2007 20:08:55 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:


> > >  Is the system time still set correctly from the RTC chip upon bootstrap 
> > > with your changes?  I cannot immediately infer it from the patches and my 
> > > suspicion is it may not anymore.
> > 
> > CONFIG_RTC_HCTOSYS=y can do it, isn't it?
> 
>  Hmm, I wonder whether this shouldn't be enabled via a reverse dependency.  
> Or even unconditionally perhaps -- if the initial system time gets set 
> from incorrect RTC time (e.g. because it is not battery-backed) it does 
> not get less correct than it would be otherwise, does it?
> 
>  Any reason for not doing either of these?

 CONFIG_RTC_HCTOSYS defaults to YES, it should be enough...?


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
