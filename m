Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 18:49:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:32443 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039761AbWJXRto (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Oct 2006 18:49:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9OHo6oW025312;
	Tue, 24 Oct 2006 18:50:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9OHo4EH025291;
	Tue, 24 Oct 2006 18:50:04 +0100
Date:	Tue, 24 Oct 2006 18:50:04 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	creideiki+linux-mips@ferretporn.se, linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
Message-ID: <20061024175004.GA24211@linux-mips.org>
References: <20061024140614.GB27800@linux-mips.org> <6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se> <20061024155045.GA28355@linux-mips.org> <20061025.023428.45176894.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061025.023428.45176894.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 25, 2006 at 02:34:28AM +0900, Atsushi Nemoto wrote:
> Date:	Wed, 25 Oct 2006 02:34:28 +0900 (JST)
> To:	ralf@linux-mips.org
> Cc:	creideiki+linux-mips@ferretporn.se, linux-mips@linux-mips.org
> Subject: Re: Extreme system overhead on large IP27
> From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Content-Type: Text/Plain; charset=us-ascii
> 
> On Tue, 24 Oct 2006 16:50:45 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > > 2. Timekeeping is broken. The clock in /proc/driver/rtc seems correct, but
> > > the system clock advances at about 1/16 of real time.
> > 
> > This one was caused by changeset ebca9aafa9bd5086d9f310205a8e30e225c5a5a6
> > which apparently wasn't quite ripe.  You can work around it by
> > revoking this changeset for now.  The time damage affects other systems
> > as well ...
> 
> Now I'm looking my patch again but still can not find any problem...
> 
> One question:
> 
> >    # zcat /proc/config.gz | grep HZ | grep -v ^#
> >    CONFIG_HZ_250=y
> >    CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
> >    CONFIG_HZ=250
> 
> IP27 really supports HZ=250 ?

Arbitrary frequency actually.  The timer used is the HUB timer which is
running at 800ns afair.  It's like 53 bits or so.  There is also a compare
register so it's somewhat similar to the cop0 counter / compare timer.

  Ralf
