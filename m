Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Apr 2006 16:10:00 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:61661 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133394AbWDSPJw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Apr 2006 16:09:52 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FWEVg-0003fc-8r; Wed, 19 Apr 2006 11:22:28 -0400
Date:	Wed, 19 Apr 2006 11:22:28 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	ashley jones <ashley_jones_2000@yahoo.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: single step on sibyte board
Message-ID: <20060419152228.GA14058@nevyn.them.org>
References: <20060418200034.GA8200@linux-mips.org> <20060419052506.9664.qmail@web38415.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419052506.9664.qmail@web38415.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 18, 2006 at 10:25:06PM -0700, ashley jones wrote:
>   But i am able to setup initial connection, and also first
>   breakpoint gets hit. Is it like gdbserver (for mips) doesnt support
>   single step command? or is it like i have not configured gdb
>   properly ? I have downloaded fresh gdb-6.4 src, and ran "configure"
>   scripts on my target (sibyte). Am i missing anything ?

How did you configure your host gdb?

Use mips-linux or mips64-linux and it will not attempt to single step.

-- 
Daniel Jacobowitz
CodeSourcery
