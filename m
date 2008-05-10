Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2008 03:22:00 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:1520 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20025238AbYEJCV5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 10 May 2008 03:21:57 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m4A2LlqB014095;
	Sat, 10 May 2008 04:21:47 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m4A2LaQv014091;
	Sat, 10 May 2008 03:21:37 +0100
Date:	Sat, 10 May 2008 03:21:35 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Jean Delvare <khali@linux-fr.org>
cc:	David Brownell <david-b@pacbell.net>, linux-mips@linux-mips.org,
	mgreer@mvista.com, rtc-linux@googlegroups.com,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-kernel@vger.kernel.org, i2c@lm-sensors.org, ab@mycable.de,
	Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [i2c] [RFC][PATCH 4/4] RTC: SMBus support for the M41T80,
In-Reply-To: <20080509232146.18638986@hyperion.delvare>
Message-ID: <Pine.LNX.4.55.0805100301100.10552@cliff.in.clinika.pl>
References: <200805070120.03821.david-b@pacbell.net>
 <Pine.LNX.4.55.0805072226180.25644@cliff.in.clinika.pl>
 <200805071625.20430.david-b@pacbell.net> <Pine.LNX.4.55.0805080306080.32613@cliff.in.clinika.pl>
 <20080509100841.151eabcd@hyperion.delvare> <Pine.LNX.4.55.0805092127410.10552@cliff.in.clinika.pl>
 <20080509232146.18638986@hyperion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Jean,

> This was an option when the functions where introduced 9 years ago.
> But now that it was done, renaming them would cause even more
> confusion, I think. I would be fine with adding comments in i2c-core.c
> or improving Documentation/i2c/smbus-protocol to make it more obious,
> though.
> 
> On a related note, you will notice that the other i2c_smbus_* functions
> do not follow the naming of SMBus transactions. Again that's something
> I regret but I feel that changing the names now would cause a lot of
> confusion amongst developers, so I'm not doing it.

 It may not be worth the effort, but if done in bulk for all the users in
the tree, there should be no problem with that.  I am fairly sure there
were changes of this kind from time to time, with occasional screams heard
in response from some dark corners, but no big pain.  We obviously
explicitly disregard out-of-tree users and for occasional contributors
asking: "Where the * has this function gone?" there is the Documentation/
tree to provide a greppable reference, so generally not a big deal.

> Just one patch should be enough, if I agree with all the changes. You
> might make a separate patch with the things I may not agree with, so
> that you don't have to cherry-revert them if I indeed don't agree, and
> we just merge them if I do agree.

 Hmm, technically you do not seem to be responsible to accept changes
under drivers/rtc/, so I will split them anyway for others to decide.  In
particular I do plan to submit a separate change for header ordering for
the driver, just out of curiosity to see how long it will stay unspoilt.  
Somehow most if not all changes of this kind that I ever made to files in
our tree have survived to the present day. :-)

> My bad, for some reason I thought that dev_printk() included the device
> name but it in fact includes the driver name. I was wrong, just ignore
> me.

 It will go separately though as not directly related to this
modification, now that I have started splitting it.

  Maciej
