Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jan 2004 09:07:29 +0000 (GMT)
Received: from p508B6890.dip.t-dialin.net ([IPv6:::ffff:80.139.104.144]:11408
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225266AbUAIJH2>; Fri, 9 Jan 2004 09:07:28 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0997OfY017369;
	Fri, 9 Jan 2004 10:07:24 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0997Lon017368;
	Fri, 9 Jan 2004 10:07:21 +0100
Date: Fri, 9 Jan 2004 10:07:21 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Charlie Brady <charlieb-linux-mips@e-smith.com>
Cc: Dimitri Torfs <dimitri@sonycom.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH][2.6] Fix Makefiles for CONFIG_EMBEDDED_RAMDISK
Message-ID: <20040109090721.GC16940@linux-mips.org>
References: <20040106205758.GA19525@sonycom.com> <Pine.LNX.4.44.0401071543430.1954-100000@allspice.nssg.mitel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401071543430.1954-100000@allspice.nssg.mitel.com>
User-Agent: Mutt/1.4i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 07, 2004 at 03:44:32PM -0500, Charlie Brady wrote:

> >   here are patches that fix the arch/mips/Makefile and
> >   arch/mips/ramdisk/Makefile when an embedded ramdisk image needs to
> >   be included through the CONFIG_EMBEDDED_RAMDISK option.
> 
> I'm curious as to why this is a mips specific feature. Does anyone know?

There's little machine dependence as you noticed; just the linker script
would need to be fixed as it's hardwired to mips.

  Ralf
