Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 May 2004 22:43:05 +0100 (BST)
Received: from p508B7D01.dip.t-dialin.net ([IPv6:::ffff:80.139.125.1]:32362
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8226014AbUECVkX>; Mon, 3 May 2004 22:40:23 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i43LeJxT030864;
	Mon, 3 May 2004 23:40:19 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i43LeIAD030863;
	Mon, 3 May 2004 23:40:18 +0200
Date: Mon, 3 May 2004 23:40:18 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: admin@nectarine.info
Cc: linux-mips@linux-mips.org
Subject: Re: Info on nec vr4181a
Message-ID: <20040503214018.GA24781@linux-mips.org>
References: <1083338187.40926dcb610a4@www.nectarine.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083338187.40926dcb610a4@www.nectarine.it>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4934
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 30, 2004 at 05:16:27PM +0200, admin@nectarine.info wrote:

> i'am thinking to start development on this Nec starter kit,
> which seems to be based on Acer pica cpu which is supported by linux-mips,
> one of the most important things that i need on this system is the X server 
> or some type of gui apart from ncurses which are probably nice but not enough 
> for what i need to do. According to linux-mips website X for pica is not 
> supported, there is any news about it ? I've seen that NetBSD and OpenBSD have 
> support for X11 on acer pica so its port to linux wouldnt be too hard, starting 
> a port is an option...but first i've to understand whats the situation around X 
> and Acer pica...

There is no relation between the PICA chipset which was built by Acer around
94/95 based on the original MIPS R4030 chipset which was also being fabbed
by Toshiba and the NEC VR4xxx stuff.  The Video used with the typical PICA
system was an S3 968 in a proprietary 64-bit slot btw.

  Ralf
