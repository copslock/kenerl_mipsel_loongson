Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Sep 2005 16:26:50 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:16283 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225304AbVIHP0d>;
	Thu, 8 Sep 2005 16:26:33 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1EDOPB-0005PQ-OF; Thu, 08 Sep 2005 11:33:37 -0400
Date:	Thu, 8 Sep 2005 11:33:37 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	vasanth <vasanth@aelixsystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: unresolved symbol
Message-ID: <20050908153337.GA20775@nevyn.them.org>
References: <005201c5b47d$20a0d4d0$3c00a8c0@vasanth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005201c5b47d$20a0d4d0$3c00a8c0@vasanth>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8904
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 08, 2005 at 07:26:17PM +0530, vasanth wrote:
> Hi,
> 
> I am getting the folowing error message when i do insmod .
> insmod: unresolved symbol __udelay
> insmod: unresolved symbol atomic_add
> insmod: unresolved symbol atomic_sub
> 
> I complied the driver code for mips processor using the folowing command
> mips-linux-gcc -G O -mno-abicalls -fno-pic -pipe -mtune=4kc -mips32 -c lcddriver.c -I/mykernel/include
> It is compiling without any error . 
> Can anybody know how to solve this problem.?

Turn on optimization.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
