Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 21:13:04 +0100 (CET)
Received: from p508B6D85.dip.t-dialin.net ([80.139.109.133]:52384 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122118AbSKNUND>; Thu, 14 Nov 2002 21:13:03 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAEKCpW09631;
	Thu, 14 Nov 2002 21:12:51 +0100
Date: Thu, 14 Nov 2002 21:12:51 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: explain to me how this works...
Message-ID: <20021114211251.C5610@linux-mips.org>
References: <20021005095335.B4079@lucon.org> <20021113174200.A2874@wumpus.internal.keyresearch.com> <20021114193924.A5610@linux-mips.org> <20021114113045.D1494@wumpus.internal.keyresearch.com> <20021114120746.E28717@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021114120746.E28717@mvista.com>; from jsun@mvista.com on Thu, Nov 14, 2002 at 12:07:46PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 14, 2002 at 12:07:46PM -0800, Jun Sun wrote:

> Look like a good case for using kgdb....

Unlikely to help him.  The return value 4183 of socket that he's observing
is the syscall number of socket(2).  That's making scall_o32.S the first
suspect to look at.

Greg, could this be a case of syscall restarting that you're observing?

  Ralf
