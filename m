Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Apr 2006 19:22:56 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:61860 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133480AbWDRSWs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Apr 2006 19:22:48 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FVv2j-00056K-DF; Tue, 18 Apr 2006 14:35:17 -0400
Date:	Tue, 18 Apr 2006 14:35:17 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	V Mehul <vmehul@razamicroelectronics.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Can you please help me out  -- Issue with GDB on mips board ????
Message-ID: <20060418183517.GA19593@nevyn.them.org>
References: <2E96546B3C2C8B4CA739323C6058204A726D89@hq-ex-mb01.razamicroelectronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E96546B3C2C8B4CA739323C6058204A726D89@hq-ex-mb01.razamicroelectronics.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 18, 2006 at 12:13:03AM -0700, V Mehul wrote:
> 
> hi,
>        i am working on i386 based board and want some information. i
>           am using mips-linux 2.6.6 kernel on target board and linux
>           2.6.9 on intel board. I am running an application under
>           "gdbserver" on the target mips board, but am not able to do
>           a single step inside the function. Foll. error is displayed
>           "ptrace : Input/Output error",
> 
>    the  "ptrace.c" file under arch/mips/kernel/ does not have support
>    for PTRACE_SINGLESTEP because of which the above error is
>    occuring. Though i386,alpha,arm etc. architecture has this
>    support, but why mips doesnt have this ?

Because the hardware doesn't.  GDB doesn't need it, either.  It sounds
like your GDB is not correctly configured for mips-linux.

-- 
Daniel Jacobowitz
CodeSourcery
