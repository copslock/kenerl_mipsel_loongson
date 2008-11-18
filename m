Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:47:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:21740 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23754756AbYKRWrf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 22:47:35 +0000
Date:	Tue, 18 Nov 2008 22:47:35 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Kaz Kylheku <KKylheku@zeugmasystems.com>, linux-mips@linux-mips.org
Subject: Re: Interrupt routing issue on BCM1480.
In-Reply-To: <20081118222820.GA14689@linux-mips.org>
Message-ID: <alpine.LFD.1.10.0811182238050.20779@ftp.linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C50144C3F0@exchange.ZeugmaSystems.local> <20081118222820.GA14689@linux-mips.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 18 Nov 2008, Ralf Baechle wrote:

> will be wired in a system specific way to the host.  For the BCM91480
> that wiring seems to be to simply wire (or "or") all INTA pins together
> and connect that signal to the SOC, same for the remaining INTB..INTD.

 Interesting -- swizzling is the usual approach to spread the load.  
Though this platform's software-driven IRQ dispatcher we have is probably 
not smart enough to take advantage of such an arrangement anyway, so 
perhaps they didn't bother to optimise hardware.  The 91250A did use 
swizzling.

  Maciej
