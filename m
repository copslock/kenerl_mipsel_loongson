Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2003 12:54:20 +0000 (GMT)
Received: from buserror-extern.convergence.de ([IPv6:::ffff:212.84.236.66]:18183
	"EHLO hell") by linux-mips.org with ESMTP id <S8225235AbTCCMyT>;
	Mon, 3 Mar 2003 12:54:19 +0000
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 18ppST-0006BH-00; Mon, 03 Mar 2003 13:54:17 +0100
Date: Mon, 3 Mar 2003 13:54:17 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Gilad Benjamini <yaelgilad@myrealbox.com>,
	linux-mips@linux-mips.org
Subject: Re: Static variables and "gp"
Message-ID: <20030303125417.GB23612@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Gilad Benjamini <yaelgilad@myrealbox.com>,
	linux-mips@linux-mips.org
References: <1046596048.d43b0c00yaelgilad@myrealbox.com> <20030302121820.A30790@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030302121820.A30790@linux-mips.org>
User-Agent: Mutt/1.5.3i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips

On Sun, Mar 02, 2003 at 12:18:20PM +0100, Ralf Baechle wrote:
> On Sun, Mar 02, 2003 at 09:07:28AM +0000, Gilad Benjamini wrote:
> 
> > How can I force a specific static variable to be used by the "gp" register
> > rather than by a two-step load ?
> > Compiling a mips-linux using gcc.
> 
> That feature doesn't work in gcc for userspace code ...

It works with diet libc (http://dietlibc.org/).
You need a static, non-PIC libgcc.a which supports it, though,
which means a bit of gcc config hackery...

Regards,
Johannes
