Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Mar 2004 02:26:15 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:61433 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225471AbUC3B0P>;
	Tue, 30 Mar 2004 02:26:15 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i2U1QCx6008245;
	Mon, 29 Mar 2004 17:26:12 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i2U1QCqQ008243;
	Mon, 29 Mar 2004 17:26:12 -0800
Date: Mon, 29 Mar 2004 17:26:12 -0800
From: Jun Sun <jsun@mvista.com>
To: Lijun Chen <chenli@nortelnetworks.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: NMI handling in MIPS64
Message-ID: <20040329172612.K1639@mvista.com>
References: <4068B3A4.4000204@americasm01.nt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4068B3A4.4000204@americasm01.nt.com>; from chenli@nortelnetworks.com on Mon, Mar 29, 2004 at 06:39:16PM -0500
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Mar 29, 2004 at 06:39:16PM -0500, Lijun Chen wrote:
> Hi,
> 
> I noticed there is a NMI handler in mips32 kernel tree (arch/mips/kernel/head.S and traps.c).
> But there is not a counterpart in mips64. Do we need one?

Personally I don't see much need of this.  Even if firmware redirect
NMI to the linux handler, you would die anyway.

> >From Ralf's earlier emails, the execution of NMI will pass through the firmware. Does that
> mean just the firmware handles the NMI? 

Yes.

> And if the NMI can be enabled/disabled?

The NMI on CPU can't be disabled.  Of course you can always have extra
PIC in front of the NMI signal and you are free to enable/disable 
there.

Jun
