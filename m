Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2008 22:29:10 +0100 (BST)
Received: from ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk ([217.169.26.28]:54715
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S28574977AbYGVV3I (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2008 22:29:08 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m6MLT3tg027443;
	Tue, 22 Jul 2008 22:29:03 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m6MLT2Qo027441;
	Tue, 22 Jul 2008 22:29:02 +0100
Date:	Tue, 22 Jul 2008 22:29:02 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mandeep Ahuja <ahuja@aksysnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Load Average >=1, mips kernel 2.6.10
Message-ID: <20080722212900.GD22094@linux-mips.org>
References: <48863A41.2020303@aksysnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48863A41.2020303@aksysnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 22, 2008 at 01:51:29PM -0600, Mandeep Ahuja wrote:

> I have an embedded system thats has mips processor. I recently updated  
> to Kernel 2.6.10 from 2.4.17.
> I was able to run the kernel and mount the jffs2 file system.
>
> When the system starts the load average is low like 0.02 but, after  
> about 2 minutes it becomes 1.00 and as long as the system is idle it  
> stays at 1.00. If the system is not idle it would go up to like 1.21 but  
> eventually come down  to 1.00 but NEVER goes below 1.
>
> There is no application running on the system. Only the busybox. Top  
> shows all processes sleeping.
>
> this is the version of kernel
> Linux version 2.6.10_dev-malta-mips2_fp_len (gcc version 3.4.6)
>
> Is there something holding the processor continuously? does anyone have  
> any idea whats going on?.
>
> I need to figure this one out before I start my application on it!.

Usually the reason would be something like a process stuck in
noninterruptible sleep state.  That's status "D" in the ps output.  Such
a process can't be killed and generally if a process is in this state for
extended time this would be considered a bug.

  Ralf
