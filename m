Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5FK0OT27637
	for linux-mips-outgoing; Fri, 15 Jun 2001 13:00:24 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5FK0Mk27634
	for <linux-mips@oss.sgi.com>; Fri, 15 Jun 2001 13:00:22 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id A77813E90; Fri, 15 Jun 2001 12:56:25 -0700 (PDT)
Date: Fri, 15 Jun 2001 12:56:25 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Mark Nellemann <mark@nellemann.nu>
Cc: nick@snowman.net, linux-mips@oss.sgi.com
Subject: Re: Another newbie question, O2 this time
Message-ID: <20010615125625.A24238@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32076.62.242.140.98.992627293.squirrel@webmail.drscallcenter.dk>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jun 15, 2001 at 07:48:13PM +0200, Mark Nellemann wrote:

> I am willing to help all I can, but i'm no expert. I got an O2 R5000 at a 
> friends place, which I can also use if that will help.
> 
> Please let me know what I can do to help.

O2 r5k should definitely boot uncached and might even work to some
extent.  r12k will work in theory but nobody has ever tried.  Expect
problems.  The most important thing you can do to help is grab the
tree, build it, try it, and tell me what you have, what works, and
what doesn't work.

If you're a hacker, add the most important step, "Fix what doesn't
work."  I've reviewed the code about 5 times and haven't been able to
find what's wrong.  This code desperately needs additional sets of
eyes peering at it.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
