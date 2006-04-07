Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Apr 2006 00:08:50 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:4750 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133617AbWDGXIm (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 8 Apr 2006 00:08:42 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k37NKAsO026851;
	Sat, 8 Apr 2006 00:20:10 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k37NK8LD026850;
	Sat, 8 Apr 2006 00:20:08 +0100
Date:	Sat, 8 Apr 2006 00:20:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Shanthi Kiran Pendyala (skiranp)" <skiranp@cisco.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Oprofile on sibyte 2.4.18 kernel
Message-ID: <20060407232008.GB26104@linux-mips.org>
References: <5547014632ED654F971D7E1E0C2E0C3E018DAFBB@xmb-sjc-215.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5547014632ED654F971D7E1E0C2E0C3E018DAFBB@xmb-sjc-215.amer.cisco.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 07, 2006 at 01:38:54PM -0700, Shanthi Kiran Pendyala (skiranp) wrote:

> Did anyone port oprofile to 2.4.x kernel on sibyte ?.
> 
> Looking over the mailing list threads it looks like it has been given up
> as a lost cause.

Correct.  So if at all you would have to rip oprofile from the 2.6 kernel
and bolt that code back into the old kernel which would seem doable.  The
MIPS bits certainly don't rely on much 2.6 infrastructure.

> But business reasons require us to work with 2.4.18 kernel for the next
> 9-12 months and We really would like explore a port.

You at least want a newer 2.4 variant; 2.4.18 is now over 4 years old, is
from before the point where 2.4 really became stable and contains a number
of security revelant holes.

> Or are there other tools that I can use ?

Gprof, perfex 2 - not sure if the MIPS port of it was ever published though.
But nothing really that provides the same kind of information as oprofile.

  Ralf
