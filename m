Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Nov 2002 19:39:34 +0100 (CET)
Received: from p508B6D85.dip.t-dialin.net ([80.139.109.133]:51615 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1122118AbSKNSje>; Thu, 14 Nov 2002 19:39:34 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAEIdPP07993
	for linux-mips@linux-mips.org; Thu, 14 Nov 2002 19:39:25 +0100
Date: Thu, 14 Nov 2002 19:39:24 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Re: explain to me how this works...
Message-ID: <20021114193924.A5610@linux-mips.org>
References: <20021005095335.B4079@lucon.org> <20021113174200.A2874@wumpus.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021113174200.A2874@wumpus.internal.keyresearch.com>; from lindahl@keyresearch.com on Wed, Nov 13, 2002 at 05:42:00PM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 13, 2002 at 05:42:00PM -0800, Greg Lindahl wrote:

> I have a 64-bit kernel and O32 userland.
> 
> I notice that arping gets confused because the syscall socket() is
> returning 4183 instead of a reasonable value like 3... if strace()
> isn't lying to me.
> 
> How do I debug this? The O32 userland calls through the socketcall()
> syscall. It looks OK.

Eh?  Nothing on MIPS should use socketcall(2); we have all the calls like
socket(2), bind(2), connect(2) etc. directly in our syscall table unlike
x86 which uses this pointless wrapper for historical reasons.  We only
have socketcall(2) in the o32 syscall interface but it's a candidate for
removal as nothing we still do support and that's glibc 2.0 and higher
binaries uses it.

  Ralf
