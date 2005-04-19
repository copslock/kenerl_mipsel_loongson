Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 16:06:18 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:6597 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8226144AbVDSPFx>;
	Tue, 19 Apr 2005 16:05:53 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DNuIP-0007lP-Px; Tue, 19 Apr 2005 11:05:49 -0400
Date:	Tue, 19 Apr 2005 11:05:49 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Greg Weeks <greg.weeks@timesys.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: sysv ipc msg functions
Message-ID: <20050419150549.GA29564@nevyn.them.org>
References: <426518D0.5080506@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426518D0.5080506@timesys.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 19, 2005 at 10:42:24AM -0400, Greg Weeks wrote:
> I needed this glibc patch to get the sysv ipc msgctl functions to work 
> correctly. This looks a bit hackish to me, so I wanted to run it past 
> everybody here before filing it with glibc.

What's your configuration?  Big or little endian, userland ABI, kernel
ABI.  Glibc version.  Kernel version.  What specific things don't work. 
Not even enough information here to make a guess.

You're updating the userspace msqid_ds to match the kernel's
msqid64_ds.  They're not normally the same type.  Rather, see
<linux/msg.h> for the type o32 generally uses.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
