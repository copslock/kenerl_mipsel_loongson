Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Nov 2004 09:56:25 +0000 (GMT)
Received: from p508B6B58.dip.t-dialin.net ([IPv6:::ffff:80.139.107.88]:50546
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225267AbUKTJ4U>; Sat, 20 Nov 2004 09:56:20 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAK9tB0E025878;
	Sat, 20 Nov 2004 10:55:11 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAK9skr4025850;
	Sat, 20 Nov 2004 10:54:46 +0100
Date: Sat, 20 Nov 2004 10:54:46 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: TheNop <TheNop@gmx.net>
Cc: linux-mips@linux-mips.org
Subject: Re: Titan ethernet driver broken
Message-ID: <20041120095445.GA12870@linux-mips.org>
References: <419D03DE.8090403@gmx.net> <419D04AA.50508@mvista.com> <419D171E.5040507@gmx.net> <419D173E.6050602@mvista.com> <419D1A2D.5000009@gmx.net> <419D1F76.6010603@gmx.net> <419D20C9.10909@mvista.com> <419D25A7.2090506@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419D25A7.2090506@gmx.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 18, 2004 at 11:43:51PM +0100, TheNop wrote:

> I use the chip version 1.1.
> Now I have the problem, that I can not use the newest code,  until 1.2 
> version of the chip is available.
> Is it possible to make the code usable for all chip version by choosing 
> the version at the kernel configuration?

Titan 1.2 is available since quite a while - the dust on my board is
proof ;-)  Since Titan 1.0 and 1.0 were shipped in very low numbers to
early customers only and will never be available in volume production the
support for them was removed.  As I recall there were at least these
problems with Titan 1.0 and 1.1 in Linux:

  - Linux uses the prefetch prepare for store operation.
  - Coherency mode 5 which is mandatory for good performance and any kind
    of sanity on SMP is now being used.
  - The problem with the third ethernet port which Manish just had
    described.

You can dig through XCVS, WebCVS or the linux-cvs archive to find where
I broke backward compatibility.

  Ralf
