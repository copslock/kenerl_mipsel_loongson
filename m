Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2003 15:21:48 +0100 (BST)
Received: from dsl093-172-017.pit1.dsl.speakeasy.net ([IPv6:::ffff:66.93.172.17]:1488
	"EHLO nevyn.them.org") by linux-mips.org with ESMTP
	id <S8225209AbTHOOVq>; Fri, 15 Aug 2003 15:21:46 +0100
Received: from drow by nevyn.them.org with local (Exim 4.20 #1 (Debian))
	id 19nfSE-0006ST-RE; Fri, 15 Aug 2003 10:21:22 -0400
Date: Fri, 15 Aug 2003 10:21:22 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Wolfgang Denk <wd@denx.de>
Cc: ?????? <zhufeng@koretide.com.cn>,
	Wilson Chan <wilsonc@cellvision1.com.tw>,
	linux-mips@linux-mips.org
Subject: Re: gdbserver and gdb debugging stub for mips
Message-ID: <20030815142122.GA24803@nevyn.them.org>
References: <MGEELAPMEFMLFBMDBLKLGEKGCEAA.zhufeng@koretide.com.cn> <20030815135018.B55C0C59E4@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815135018.B55C0C59E4@atlas.denx.de>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 15, 2003 at 03:50:13PM +0200, Wolfgang Denk wrote:
> In message <MGEELAPMEFMLFBMDBLKLGEKGCEAA.zhufeng@koretide.com.cn> you wrote:
> > I'm also looking for them . If anybody who has , please tell me , thank you.
> 
> MIPS isn't MIPS. What exactly are you looking for?
> 
> We have gdb (cross and native) / gdbserver included with our ELDK for
> MIPS - this is for 4Kc CPUs.
> 
> See section "3. Embedded Linux Development Kit" at
> http://www.denx.de/twiki/bin/view/DULG/BoardSelect (select incaip).

They're also, uh, distributed with the source of GDB.  Builds like any
other target application.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
