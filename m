Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 23:27:57 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:9412 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8133724AbWC1W12 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Mar 2006 23:27:28 +0100
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1FOMp3-0003I6-3R; Tue, 28 Mar 2006 17:37:57 -0500
Date:	Tue, 28 Mar 2006 17:37:57 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Kumaraswamy Mudide <kumara_mudide@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: gdb info threads with core files
Message-ID: <20060328223757.GB12609@nevyn.them.org>
References: <20060328222835.93334.qmail@web31904.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060328222835.93334.qmail@web31904.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 28, 2006 at 02:28:35PM -0800, Kumaraswamy Mudide wrote:
> Hi Everyone,
>    
>     We are using linux 2.4.25 and gdb 6.4, info threads with the core files always shows only single thread. This threads is same as to which we have sent segv or abort signal. 
>    
>   bt and info reg seems to be working fine. but not info threads.
>    
>   Any idea??

Then your kernel probably does not support multithreaded core dumping.

-- 
Daniel Jacobowitz
CodeSourcery
