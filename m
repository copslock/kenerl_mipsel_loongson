Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Feb 2005 10:59:21 +0000 (GMT)
Received: from alg138.algor.co.uk ([IPv6:::ffff:62.254.210.138]:39137 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224991AbVBHK7G>; Tue, 8 Feb 2005 10:59:06 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j18As13W008438;
	Tue, 8 Feb 2005 10:54:01 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j18As1mN008437;
	Tue, 8 Feb 2005 10:54:01 GMT
Date:	Tue, 8 Feb 2005 10:54:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	TheNop <TheNop@gmx.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Kernel crash on yosemite
Message-ID: <20050208105401.GB6131@linux-mips.org>
References: <4207F163.4010605@gmx.net> <20050208013000.GA6131@linux-mips.org> <42081A2C.5060503@mvista.com> <20050208015155.GB15336@linux-mips.org> <42081DA0.6070301@mvista.com> <20050208023349.GC15336@linux-mips.org> <42082C2C.5020703@mvista.com> <42086846.9060709@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42086846.9060709@gmx.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 08, 2005 at 08:20:38AM +0100, TheNop wrote:

> I'm sorry, but all the discussion on this thread did'n help me to solve 
> my problem. Since more than a month I'm waitig to get a yosemite board 
> with 1.2 version. This still stops my development, when I can't use the 
> yosemite with 1.1 version.
> 
> In another therad we discuss to create a patch (slowpath) for the titan 
> version 1.1. the patch I apply to the the newer kernel sources 
> (2.6.11.rc1) but, I have the same problems. So I think the problem could 
> be the slowpath thing.
> 
> Have anybody an idee how to figure out what could be the problem when I 
> make "cp foo foo1" (foo is a lage file ~3,5 Mb)?

A network driver bug in the 2.6 Titan driver which I recently fixes was
that the allocated receive and transmit rings were allocated overlapping
which was causing havoc.

Yosemite w/ Titan 1.1 was suffering from unexplained system freezes for me;
a more recent board with Titan 1.2 is very stable.

  Ralf
