Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6PC29Rw001746
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 25 Jul 2002 05:02:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6PC29VQ001745
	for linux-mips-outgoing; Thu, 25 Jul 2002 05:02:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6PC24Rw001736
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 05:02:04 -0700
Received: from hell (buserror-extern.convergence.de [212.84.236.66]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA09717
	for <linux-mips@oss.sgi.com>; Thu, 25 Jul 2002 05:03:17 -0700 (PDT)
	mail_from (js@convergence.de)
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17Xh5K-0001xK-00; Thu, 25 Jul 2002 13:47:10 +0200
Date: Thu, 25 Jul 2002 13:47:10 +0200
From: Johannes Stezenbach <js@convergence.de>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: linux-mips@oss.sgi.com
Subject: Re: _stext is ill-defined / SysRq-T broken
Message-ID: <20020725114710.GA7482@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
References: <20020724181708.GA5399@convergence.de> <Pine.GSO.3.96.1020725114648.27463B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.3.96.1020725114648.27463B-100000@delta.ds2.pg.gda.pl>
User-Agent: Mutt/1.4i
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 25, 2002 at 12:08:15PM +0200, Maciej W. Rozycki wrote:
> On Wed, 24 Jul 2002, Johannes Stezenbach wrote:
> 
> > I suggest the patch below to fix the bad formatting, but I'm
> > not shure about _stext. Should kernel_entry be placed into the .text
> > section, or should _stext = _ftext in ld.script?
> 
>  I'll check your patch at run-time later -- I've noticed that the current
> output is less than satisfying.

I just noticed that my patch garbles Oops output,
because I removed the initial "\n" from the printk("Call Trace").

It can be solved by adding a printk("\n") at the very end of show_stack().
I grepped the whole kernel for other uses of show_trace()
and show_stack(), and found nothing that would conflict with it.


Johannes
