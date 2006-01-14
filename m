Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 18:57:54 +0000 (GMT)
Received: from p549F60EF.dip.t-dialin.net ([84.159.96.239]:5516 "EHLO
	p549F60EF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133455AbWAOS5c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jan 2006 18:57:32 +0000
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:9962 "EHLO
	nevyn.them.org") by linux-mips.net with ESMTP id <S876298AbWANViF>;
	Sat, 14 Jan 2006 22:38:05 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1Ext2x-0005Xo-MM; Sat, 14 Jan 2006 16:34:51 -0500
Date:	Sat, 14 Jan 2006 16:34:51 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Alex Gonzalez <langabe@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Compiling a non-pic glibc
Message-ID: <20060114213451.GA21268@nevyn.them.org>
References: <c58a7a270601120218r77ec0d8drf2d14663138a13c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c58a7a270601120218r77ec0d8drf2d14663138a13c2@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Jan 12, 2006 at 10:18:03AM +0000, Alex Gonzalez wrote:
> Hi,
> 
> What is the correct way of cross-compiling a non-pic static glibc?

You can't.  MIPS/Linux userspace toolchains only support PIC out of the
box; if you want to mess around with non-PIC toolchains expect to have
to hack glibc (and possibly other places).  In this case it looks like
GCC's CRT files are PIC.

-- 
Daniel Jacobowitz
CodeSourcery
