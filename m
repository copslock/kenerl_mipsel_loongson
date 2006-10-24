Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Oct 2006 16:18:14 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:41416 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S20039404AbWJXPSH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Oct 2006 16:18:07 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1GcO2J-0002h9-Rh; Tue, 24 Oct 2006 11:17:51 -0400
Date:	Tue, 24 Oct 2006 11:17:51 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: qemu initrd and ide support
Message-ID: <20061024151751.GA10274@nevyn.them.org>
References: <20061012211228.GA17383@nevyn.them.org> <452F9744.9010109@aurel32.net> <20061024130832.GA3768@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061024130832.GA3768@bode.aurel32.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 24, 2006 at 03:08:32PM +0200, Aurelien Jarno wrote:
> After a week of test, I can say that the IDE part is working correctly 
> (at least for me, and I suppose for you), I am using it on an emulated
> system with ext3 as the root partition, and with swap. There are some
> problems related to the userland tools (mke2fs) though.
> 
> Therefore I propose to submit the IDE part to QEMU. I have extracted it
> from your patch, which also contains initrd support.
> 
> Care to send it?

Could you do it?  Since you've tested them more, and separated them,
you might as well :-)  I think that both this and the rd_size patch
are good to submit.

I hope that I can find the time at some point to fix the problems
blocking a Debian installer, but right at the moment I don't know when
I'll have time.

-- 
Daniel Jacobowitz
CodeSourcery
