Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 12:45:39 +0000 (GMT)
Received: from pD9562C58.dip.t-dialin.net ([IPv6:::ffff:217.86.44.88]:23154
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225308AbUK2Mpf>; Mon, 29 Nov 2004 12:45:35 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iATCjXp8005075;
	Mon, 29 Nov 2004 13:45:33 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iATCjVLW005071;
	Mon, 29 Nov 2004 13:45:31 +0100
Date: Mon, 29 Nov 2004 13:45:31 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Ralf R?sch <ralf.roesch@rw-gmbh.de>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix for signal.c and Toshiba TX49XX TLB refill handler
Message-ID: <20041129124531.GA4832@linux-mips.org>
References: <NHBBLBCCGMJFJIKAMKLHGEHOCCAA.ralf.roesch@rw-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <NHBBLBCCGMJFJIKAMKLHGEHOCCAA.ralf.roesch@rw-gmbh.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 29, 2004 at 12:26:44PM +0100, Ralf R?sch wrote:

> the signal.c (get_sigframe) handler forces my boot process hanging in init
> process.
> Following patch solves the problem:

Correct; several people found that one.  For some reason my machine is
happy without this one.

> without next patch the TX4927 Toshiba processor definitely does not boot.
> (My CPU was hanging without any message on the serial console), this means
> the panic() message
> 		panic("No TLB refill handler yet (CPU type: %d)",
> 		      current_cpu_data.cputype);
> could not be seen.
> 
> I am not sure, if the place where I inserted the new processor type is
> correct.

You better check this with a CPU manual.  False hazard handling may result
in either slower than necessary TLB refil handlers or in sometimes very
subtle bugs that show their ugly heads only very rarely.  This is why the
code is panicing now - we want to force users to make sure things are right
by reading their manuals.

  Ralf
