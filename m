Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2003 23:30:43 +0000 (GMT)
Received: from p508B60B3.dip.t-dialin.net ([IPv6:::ffff:80.139.96.179]:8882
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225199AbTKSXab>; Wed, 19 Nov 2003 23:30:31 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAJNUPA0008094;
	Thu, 20 Nov 2003 00:30:25 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAJNUOhC008093;
	Thu, 20 Nov 2003 00:30:24 +0100
Date: Thu, 20 Nov 2003 00:30:23 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: David Daney <ddaney@avtrex.com>
Cc: linux-mips@linux-mips.org
Subject: Re: How reliable is GCC-3.3.1 wrt building mipsel-linux kernel?
Message-ID: <20031119233023.GA30962@linux-mips.org>
References: <3FBACA0F.7070207@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBACA0F.7070207@avtrex.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 18, 2003 at 05:40:31PM -0800, David Daney wrote:

> The subject line kind of says it all.
> 
> We are running linux 2.4.18 on a mips4Kc core (ATI Xilleon 225) and find 
> it to be quite stable when compiled with gcc 2.96/binutils 2.11.92.0.10
> 
> When the kernel is compiled with gcc 3.3.1/binutils 2.14.90.0.5 it also 
> seems to be quite stable, except for when one certian driver is used 
> (basically an mpeg decoder driver).  Under certian conditions the system 
> seems to "freeze" (no messages printed anywhere and only a hard reset 
> will recover).
> 
> Yeah that is a good bug report...
> 
> But my main question is this:  Have other people experienced 
> miscompilation (ie bad code generation) with gcc 3.3.1?

Quite frequently using a new, possibly more agressive compiler triggers
bugs in the kernel code ...

  Ralf
