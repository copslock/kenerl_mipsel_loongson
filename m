Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3J1Fp8d016895
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 18 Apr 2002 18:15:51 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3J1Fpgg016894
	for linux-mips-outgoing; Thu, 18 Apr 2002 18:15:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3J1Fm8d016891
	for <linux-mips@oss.sgi.com>; Thu, 18 Apr 2002 18:15:48 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g3J1Grt05965;
	Thu, 18 Apr 2002 18:16:53 -0700
Date: Thu, 18 Apr 2002 18:16:53 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Andre.Messerschmidt@infineon.com
Cc: linux-mips@oss.sgi.com
Subject: Re: Wait queue problem
Message-ID: <20020418181652.A25562@dea.linux-mips.net>
References: <86048F07C015D311864100902760F1DD01B5E8DD@dlfw003a.dus.infineon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <86048F07C015D311864100902760F1DD01B5E8DD@dlfw003a.dus.infineon.com>; from Andre.Messerschmidt@infineon.com on Wed, Apr 17, 2002 at 12:03:19PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Apr 17, 2002 at 12:03:19PM +0200, Andre.Messerschmidt@infineon.com wrote:

> Does anybody else have problems using wait queues in a 2.4.5 MIPS kernel?
> When I try to wake up a process from an interrupt it won't start to execute.
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

A bad race condition in that code.  If foo_int is called before your process
had a chance to get to sleep it'll never be woken before the timeout.

  Ralf
