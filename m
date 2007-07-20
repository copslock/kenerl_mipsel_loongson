Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2007 13:21:32 +0100 (BST)
Received: from kuber.nabble.com ([216.139.236.158]:55464 "EHLO
	kuber.nabble.com") by ftp.linux-mips.org with ESMTP
	id S20022900AbXGTMVa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jul 2007 13:21:30 +0100
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1IBrU7-000378-VN
	for linux-mips@linux-mips.org; Fri, 20 Jul 2007 05:21:27 -0700
Message-ID: <11707153.post@talk.nabble.com>
Date:	Fri, 20 Jul 2007 05:21:27 -0700 (PDT)
From:	Misbah khan <misbah_khan@engineer.com>
To:	linux-mips@linux-mips.org
Subject: Re: Wait queue problem
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E8DD@dlfw003a.dus.infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: misbah_khan@engineer.com
References: <86048F07C015D311864100902760F1DD01B5E8DD@dlfw003a.dus.infineon.com>
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: misbah_khan@engineer.com
Precedence: bulk
X-list: linux-mips


I guess that you are missing one more condition the flag bit which you need
to set and reset accordingly in the function and in the interrupt handler 

interruptible_sleep_on_timeout(&wq,flag!=0,10*HZ);

Try out this for any query please let me know 

regard 
misbah



Andre.Messerschmidt wrote:
> 
> Hi,
> 
> Does anybody else have problems using wait queues in a 2.4.5 MIPS kernel?
> When I try to wake up a process from an interrupt it won't start to
> execute.
> It always waits for the timeout before resuming work. 
> In principal my code look like this:
> 
> wait_queue_head_t wq;
> 
> foo() {
> init_waitqueue_head(&wq);
> interruptible_sleep_on_timeout(&wq,10*HZ);
> }
> 
> foo_int() {
> wake_up_interuptible(&wq);
> }
> 
> Am I missing something? 
> 
> best regards
> --
> Andre Messerschmidt
> 
> Application Engineer
> Infineon Technologies AG
> 
> 
> 
> 

-- 
View this message in context: http://www.nabble.com/Wait-queue-problem-tf2852319.html#a11707153
Sent from the linux-mips main mailing list archive at Nabble.com.
