Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g48LWOwJ016635
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 14:32:24 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g48LWNB2016634
	for linux-mips-outgoing; Wed, 8 May 2002 14:32:23 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g48LWJwJ016619
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 14:32:19 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA19502;
	Wed, 8 May 2002 14:33:59 -0700
Message-ID: <3CD9996A.1030500@mvista.com>
Date: Wed, 08 May 2002 14:32:26 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: Rick Spanbauer <rick@sirius.cvnet.com>
CC: linux-mips@oss.sgi.com
Subject: Re: copy_mount_options
References: <NFBBJEOAELIHHOOPHOOHOEOACGAA.rick@sirius.cvnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Rick Spanbauer wrote:

> Howdy - I am having a bit of a problem with a kernel port I've been working
> on recently.  Linux is up and running to the initial sh prompt, networking/ethernet
> works, and so on.  When I try a mount(), I am getting a kernel page fault.  Between
> a few hours worth of debugging and some Googling around, I believe I understand
> what is happening, ie when copy_mount_option is copying in from user space, it
> seems to be running off the end of the data segment (code was apparently written with
> the assumption that this is legal).  I can think of several different solutions, but
> the question is this - is there some common, accepted practice solution to
> this particular problem?  From searching the discussion groups, this class of problem
> seems to be a known issue, but the arguments pro/con about what to do about
> it never seem to converge :)  So before tracking off into the wilderness
> on my own, I thought I might ask!  Tnx Rick Spanbauer
> 


Congradulations!  You must have checked out the kernel from OSS CVS tree 
sometime in the past a couple of days.  There is a small time window when Ralf 
checked in the "correct epc for delay slot" fix with a typo and later got 
fixed again.  And coyp_mount_option() kernel fault was the symptom of the typo.

Get the latest code and give it a try.

Jun
