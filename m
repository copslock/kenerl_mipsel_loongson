Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2003 01:08:12 +0000 (GMT)
Received: from p508B6365.dip.t-dialin.net ([IPv6:::ffff:80.139.99.101]:9630
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225373AbTKQBIA>; Mon, 17 Nov 2003 01:08:00 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAH176A0021130;
	Mon, 17 Nov 2003 02:07:06 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAH16WQV021123;
	Mon, 17 Nov 2003 02:06:32 +0100
Date: Mon, 17 Nov 2003 02:06:32 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Brad Parker <brad@parker.boston.ma.us>
Cc: durai <durai@isofttech.com>, linux-mips@linux-mips.org
Subject: Re: file handling in kernel mode
Message-ID: <20031117010631.GA20737@linux-mips.org>
References: <20031116225133.GA7808@linux-mips.org> <200311170046.hAH0kZX16327@p2.parker.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311170046.hAH0kZX16327@p2.parker.boston.ma.us>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 16, 2003 at 07:46:35PM -0500, Brad Parker wrote:

> Shouldn't someone point out that having a driver read a file is 
> very, very wrong and a classic FAQ question?

It is.

> Perhaps I'm mistaken but this seems to come up once a year on every port
> list I'm on.

I think it's the first time on this list.  In my previous posting I suggested
request_firmware for 2.4.23 / 2.6.  For kernels older than this I suggest
arch/i386/kernel/microcode.c as an example for how to easily implement
a character special file.

> Resist the temptation to put code in the driver to access the file
> system.

Amen.

> ps: isn't hotplug already setup to notice when a device comes up and to
> have a shell script run?  it's bad enough that the hotplug code runs a
> shell script from the kernel.  I can't believe that got through...
> 
> (and if you have time, go read the plan 9 design docs.  then ask yourself
> what those guys would do :-)

2.6 certainly is quite a bit more plan 9-ish.  What would you expect from
Al Viro :-)

  Ralf
