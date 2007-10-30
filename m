Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2007 12:48:53 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:10881 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024233AbXJ3Msv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Oct 2007 12:48:51 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9UCmij5025260;
	Tue, 30 Oct 2007 12:48:44 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9UCmhXt025259;
	Tue, 30 Oct 2007 12:48:43 GMT
Date:	Tue, 30 Oct 2007 12:48:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>,
	linux-mips@linux-mips.org
Subject: Re: 2.4.24-rc1 does not boot on SGI
Message-ID: <20071030124843.GB7582@linux-mips.org>
References: <1193468825.7474.6.camel@scarafaggio> <20071030083106.GA16763@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071030083106.GA16763@deprecation.cyrius.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 30, 2007 at 09:31:07AM +0100, Martin Michlmayr wrote:

> * Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org> [2007-10-27 09:07]:
> > The new kernel once again does not boot on SGI O2. What happens is that
> > arcboot write its messages and nothing more is displayed on the screen.
> > The last message is "Starting ELF64 kernel". The previous running kernel
> > were 2.6.23 from linux-mips.org and 2.6.23.1 from kernel.org.
> 
> I can confirm that currnt git doesn't boot (no message on the serial
> console at all).  However, I'm curious to know whether 2.6.23 is
> working properly for you (and, if so, can you send me your .config).
> For me, it stops after printing
> 
> Freeing unused kernel memory: 268k freed
> 
> but then I can still hear it doing something and after a minute or so
> I see:
> 
> Adding 131064k swap on /dev/sda2.  Priority:-1 extents:1 across:131064k
> EXT3 FS on sda1, internal journal
> 
> and later:
> 
> gbefb: wait for vpixen_off timed out
> 
> and then I gave up and went to bed. ;-)

There was bug in the timer code resuling in a hang on master.  Commit
5a8e84c525ee1ad17e0ccfbc0a81c19b6773837c fixes this issue.

Irritatingly there was also a bug in Qemu which when running a Malta
kernel will cancel the affect of the first bug and result in a working
Malta kernel.  But only on Qemu, not on actual hardware.  Ths is working
on a fix for this one.

With the help of ricmm I found a few more issues in the IP32 interrupt
code.  I have a preliminary fix but it either isn't all it takes to fix
IP32 or it is still broken itself.

  Ralf
