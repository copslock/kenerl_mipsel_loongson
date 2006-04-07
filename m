Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 14:14:39 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:36052 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133572AbWDGNO3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 14:14:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k37BrO80006993;
	Fri, 7 Apr 2006 12:53:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k37BrO0B006992;
	Fri, 7 Apr 2006 12:53:24 +0100
Date:	Fri, 7 Apr 2006 12:53:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] use CONFIG_HZ
Message-ID: <20060407115323.GB5909@linux-mips.org>
References: <20060407.011000.77652835.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0604071156350.25570@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0604071156350.25570@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 07, 2006 at 12:18:03PM +0100, Maciej W. Rozycki wrote:

> > Make HZ configurable (except for DECSTATION which is using special HZ
> > value which is out of choice).  Also remove some param.h files and
> 
>  The DECstation could actually use a choice of 128Hz, 256Hz and 1024Hz if 
> anybody cared.

Well, instead of the stock Kconfig.hz we maybe should use our own like
this:

config MACH_DECSTATION
	bool
	select SYS_SUPPORT_128HZ
	select SYS_SUPPORT_256HZ
	select SYS_SUPPORT_1024HZ

config MACH_JAZZ
	bool "Support for the Jazz family of machines"
	select SYS_SUPPORT_100HZ
	...

config MACH_CUCUBER
	...
...

choice
config HZ_48
	bool "48Hz" if SYS_SUPPORT_48HZ
	help
	  Useful for debugging of Linux on extremly slow hardware simulators.
	...
config HZ_100
	bool "100Hz" if SYS_SUPPORT_100HZ
	help
	  blah
	...
config HZ_128
	bool "128Hz" if SYS_SUPPORT_128HZ
	...
config HZ_250
	bool "250Hz" if SYS_SUPPORT_250HZ
	...
config HZ_256
	bool "256Hz" if SYS_SUPPORT_256HZ
	...
config HZ_1000
	bool "1000Hz" if SYS_SUPPORT_1000HZ
	...
config HZ_1024
	bool "1024Hz" if SYS_SUPPORT_1024HZ
	...
endchoice

config HZ
	int
	default 48 if HZ_48
	default 100 if HZ_100
	default 128 if HZ_128
	default 250 if HZ_250
	default 256 if HZ_256
	default 1000 if HZ_1000
	default 1024 if HZ_1024

What do you think?

  Ralf
