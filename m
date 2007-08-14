Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2007 11:38:31 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:55695 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022232AbXHNKi3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Aug 2007 11:38:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7EATEoH020744;
	Tue, 14 Aug 2007 11:29:14 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7EATD9i020743;
	Tue, 14 Aug 2007 11:29:13 +0100
Date:	Tue, 14 Aug 2007 11:29:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Use generic NTP code for all MIPS platforms
Message-ID: <20070814102913.GD16958@linux-mips.org>
References: <S20023068AbXHMO0W/20070813142622Z+9352@ftp.linux-mips.org> <20070814.003242.59465104.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070814.003242.59465104.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 14, 2007 at 12:32:42AM +0900, Atsushi Nemoto wrote:

> config GENERIC_CMOS_UPDATE
> 	bool
> 	default y
> 
> I think there are no point using GENERIC_CMOS_UPDATE for users of the
> new-style RTC_CLASS drivers or platforms with no RTC.

Platforms with no RTC are easy to handle, just throw in a dummy
implementation of all the RTC functions.  Or if you just don't want
RTC updates, set no_sync_cmos_clock = 1.

Several platforms had their own timer interrupt handlers overriding the
generic interrupt handler and breaking the NTP.  In most cases I doubt
this was a design decission so I had to go for a solution that makes
NTP work by default.

> There are some possible ways:
> 
> A) Make default of GENERIC_CMOS_UPDATE to "n" and select it explicitly
>    on platforms which need it.
> 
> B) Make default of GENERIC_CMOS_UPDATE depends on CONFIG_RTC_CLASS.
> 
> C) set no_sync_cmos_clock to 0 on time_init() if rtc_mips_set_mmss was
>    NULL and rtc_mips_set_time and was null_rtc_set_time.
> 
> And combinations ot variations of those...

You may want to look at my time changes.  One of the patches turns all
the excessive function pointer business we have in the MIPS time code
upside down in preparation for the dyntick code.

  Ralf
