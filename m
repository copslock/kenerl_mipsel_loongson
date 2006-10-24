Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 16:50:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:15751 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039693AbWJXPuT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Oct 2006 16:50:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k9OFojOd003307;
	Tue, 24 Oct 2006 16:50:47 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k9OFojIa003306;
	Tue, 24 Oct 2006 16:50:45 +0100
Date:	Tue, 24 Oct 2006 16:50:45 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Karl-Johan Karlsson <creideiki+linux-mips@ferretporn.se>
Cc:	linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
Message-ID: <20061024155045.GA28355@linux-mips.org>
References: <200610212159.04965.creideiki+linux-mips@ferretporn.se> <20061022232316.GA19127@linux-mips.org> <20061023001947.GA10853@linux-mips.org> <200610232330.23498.creideiki+linux-mips@ferretporn.se> <20061023224318.GA1732@linux-mips.org> <53979.136.163.203.3.1161698036.squirrel@www.ferretporn.se> <20061024140614.GB27800@linux-mips.org> <6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6285.136.163.203.3.1161704681.squirrel@www.ferretporn.se>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 24, 2006 at 05:44:41PM +0200, Karl-Johan Karlsson wrote:

> 2. Timekeeping is broken. The clock in /proc/driver/rtc seems correct, but
> the system clock advances at about 1/16 of real time.

This one was caused by changeset ebca9aafa9bd5086d9f310205a8e30e225c5a5a6
which apparently wasn't quite ripe.  You can work around it by
revoking this changeset for now.  The time damage affects other systems
as well ...

  Ralf
