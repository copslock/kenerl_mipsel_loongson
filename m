Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2007 19:52:24 +0000 (GMT)
Received: from NaN.false.org ([208.75.86.248]:26336 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S20022958AbXJ1TwP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 Oct 2007 19:52:15 +0000
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 0BDCB98347;
	Sun, 28 Oct 2007 19:52:13 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id E506798100;
	Sun, 28 Oct 2007 19:52:12 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.68)
	(envelope-from <drow@caradoc.them.org>)
	id 1ImEB9-0007bI-SM; Sun, 28 Oct 2007 15:52:11 -0400
Date:	Sun, 28 Oct 2007 15:52:11 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] store sign-extend register values for PTRACE_GETREGS
Message-ID: <20071028195211.GA29200@caradoc.them.org>
References: <20070304.024152.96687132.anemo@mba.ocn.ne.jp> <20071026.005302.25909293.anemo@mba.ocn.ne.jp> <20071028193421.GC7661@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071028193421.GC7661@linux-mips.org>
User-Agent: Mutt/1.5.15 (2007-04-09)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sun, Oct 28, 2007 at 07:34:21PM +0000, Ralf Baechle wrote:
> On Fri, Oct 26, 2007 at 12:53:02AM +0900, Atsushi Nemoto wrote:
> 
> Daniel, do you see any debugger compatibility issues with this patch?

I don't think so; I'm pretty sure I wrote the code at fault here,
and I can't remember any reason I would have deliberately made the
registers unsigned.  Looking at the fix I think I just guessed
wrong about the type used by __put_user.

-- 
Daniel Jacobowitz
CodeSourcery
