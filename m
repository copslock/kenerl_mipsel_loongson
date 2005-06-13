Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 20:56:22 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:54718 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225849AbVFMT4H>;
	Mon, 13 Jun 2005 20:56:07 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50)
	id 1Dhv2Q-0000z9-7Y; Mon, 13 Jun 2005 15:56:02 -0400
Date:	Mon, 13 Jun 2005 15:56:02 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building o32 glibc on mips64
Message-ID: <20050613195602.GA3739@nevyn.them.org>
References: <42AB3366.8030206@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AB3366.8030206@jg555.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 11, 2005 at 11:54:30AM -0700, Jim Gifford wrote:
> Anyone got any ideas on how to fix this. I'm using binutils 2.16, gcc 
> 3.4.4, and glibc-2.3.5 with the syscall patch. Looks like socket.S is 
> not being generated.

I have not tried the 2.3.x series glibcs on MIPS64.  I recommend you
use glibc HEAD for now instead, unless you're interested in tracking
down this sort of problem.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
