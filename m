Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 02:39:04 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:41948 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225239AbVBHCit>; Tue, 8 Feb 2005 02:38:49 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j182XnOi028647;
	Tue, 8 Feb 2005 02:33:49 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j182Xnql028646;
	Tue, 8 Feb 2005 02:33:49 GMT
Date:	Tue, 8 Feb 2005 02:33:49 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	TheNop <TheNop@gmx.net>, linux-mips@linux-mips.org
Subject: Re: Kernel crash on yosemite
Message-ID: <20050208023349.GC15336@linux-mips.org>
References: <4207F163.4010605@gmx.net> <20050208013000.GA6131@linux-mips.org> <42081A2C.5060503@mvista.com> <20050208015155.GB15336@linux-mips.org> <42081DA0.6070301@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42081DA0.6070301@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 07, 2005 at 06:02:08PM -0800, Manish Lachwani wrote:

> I completely agree. In any case, I dont think the CVS sources ever 
> supported SMP for Titan < 1.2, correct?

No, that would have either meant taking a heavy performance penalty or
hacking mm in very ugly ways.  And due to the probably low numbers of
the early silicon and the availability of later revisions the reason
for such hacks was low anyway.

  Ralf
