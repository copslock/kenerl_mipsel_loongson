Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 22:27:30 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:49844 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225425AbTIRV12>;
	Thu, 18 Sep 2003 22:27:28 +0100
Received: from drow by nevyn.them.org with local (Exim 4.22 #1 (Debian))
	id 1A06JD-0006Qv-1U; Thu, 18 Sep 2003 17:27:27 -0400
Date: Thu, 18 Sep 2003 17:27:27 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-mips@linux-mips.org
Cc: binutils@sources.redhat.com
Subject: recent binutils and mips64-linux
Message-ID: <20030918212727.GA24686@nevyn.them.org>
Mail-Followup-To: linux-mips@linux-mips.org, binutils@sources.redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

I'm sure this has been discussed already...

The Linux kernel currently uses among other things, -Wa,-32,-mgp64.  The
point is to use 32-bit ELF and 64-bit instructions.  But nowadays binutils
requires that the ABI explicitly match the width of GP registers.

Can gas still do ELF32 in with 64-bit registers?  If so, what the heck is
the command-line magic?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
