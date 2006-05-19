Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 May 2006 15:02:33 +0200 (CEST)
Received: from nevyn.them.org ([66.93.172.17]:18617 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133948AbWESNC0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 May 2006 15:02:26 +0200
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1Fh4cX-0000Jh-HD; Fri, 19 May 2006 09:02:21 -0400
Date:	Fri, 19 May 2006 09:02:21 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Tony Lin <lin.tony@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Can't debug core files with GDB
Message-ID: <20060519130221.GA1183@nevyn.them.org>
References: <404548f40605161702y199c34a5wa89ec5f84cdeee09@mail.gmail.com> <20060517133402.GA2480@nevyn.them.org> <404548f40605171139i67084776pd9ae7c34ec19ec95@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404548f40605171139i67084776pd9ae7c34ec19ec95@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, May 17, 2006 at 11:39:47AM -0700, Tony Lin wrote:
> The 0x4008c0 address doesn't look half bad, pointing within main(). So
> it looks like the mips kernel had all the right registers values but
> just didn't format it correctly in the core dump? It wrote the pc into
> cause, cause into sr, and cp0_status into lo.

Then either the kernel or GDB is confused about the layout.  You'll
have to work out which one has gotten wrong.

-- 
Daniel Jacobowitz
CodeSourcery
