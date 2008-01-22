Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2008 15:50:02 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:60645 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28588926AbYAVPuA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 22 Jan 2008 15:50:00 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m0MFnxI8030923;
	Tue, 22 Jan 2008 15:49:59 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m0MFnwnm030922;
	Tue, 22 Jan 2008 15:49:58 GMT
Date:	Tue, 22 Jan 2008 15:49:58 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Tester with IP27/IP30 needed
Message-ID: <20080122154958.GA29108@linux-mips.org>
References: <20080115112420.GA7347@alpha.franken.de> <20080115112719.GB7920@paradigm.rfc822.org> <20080117004054.GA12051@alpha.franken.de> <479609A6.2020204@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <479609A6.2020204@gentoo.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18110
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 22, 2008 at 10:20:06AM -0500, Kumba wrote:

> No effect on Octane R14000A, as far as lockups.  Spikes the CPU usage in 'ps
> aux', but that's about it.

So far it seems R12000 and R14000 are unaffected.

> If I can get my plucky IP32 R10K to boot again soon, I may try it there for
> kicks and giggles.  Maybe we're also seeing a side effect of the R10K's spec
> exec knocking the non-cache-coherent machines out?
>
> Also, tried building the code with the R10K cache barrier on to see if anything
> else changes?  Generally reserved for kernel stuff, but Peter once speculated
> userland might have a use for it.

It's a cache instruction so priviledged which means userspace can't execute
it.  It's also entirely unclear if a cache barrier instruction would make a
difference at all.

  Ralf
