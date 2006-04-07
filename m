Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 17:52:42 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:17099 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133569AbWDGQwe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 17:52:34 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k37H41jD018636;
	Fri, 7 Apr 2006 18:04:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k37H414k018635;
	Fri, 7 Apr 2006 18:04:01 +0100
Date:	Fri, 7 Apr 2006 18:04:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] use CONFIG_HZ
Message-ID: <20060407170401.GA17163@linux-mips.org>
References: <20060407.011000.77652835.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0604071156350.25570@blysk.ds.pg.gda.pl> <20060407115323.GB5909@linux-mips.org> <20060408.010348.41197502.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0604071742220.12718@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0604071742220.12718@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11064
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 07, 2006 at 05:46:06PM +0100, Maciej W. Rozycki wrote:

> > Make HZ configurable (DECSTATION can select 128/256/1024 HZ, JAZZ can
> > only select 100 HZ, others can select 48/100/128/250/256/1000/1024
> > HZ).  Also remove all mach-xxx/param.h files and update all defconfigs
> > according to current HZ value.
> 
>  Thanks.  I've got a suggestion SEAD (sead_defconfig) should use 100Hz by 
> default too and given its usual setup I can't agree more.

I think I'll apply Atsushi's patch with two changes:

 o SYS_SUPPORT_* -> SYS_SUPPORTS_*
 o 48Hz is a very extreme setting and I don't think it's useful for
   anything but very slow simulators, so I think I'm going to restrict
   this setting by a dependency on something like CONFIG_EXPERIMENTAL.

  Ralf
