Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OJDVRw005824
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 12:13:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OJDVER005823
	for linux-mips-outgoing; Wed, 24 Jul 2002 12:13:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft19-f151.dialo.tiscali.de [62.246.19.151])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OJDPRw005814
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 12:13:27 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6OJEER22888;
	Wed, 24 Jul 2002 21:14:14 +0200
Date: Wed, 24 Jul 2002 21:14:14 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Krishna Kondaka <krishna@Sanera.net>
Cc: jsun@mvista.com, linux-mips@oss.sgi.com
Subject: Re: kernel BUG at slab.c:1073!
Message-ID: <20020724211414.A22828@dea.linux-mips.net>
References: <200207241908.g6OJ8Yi29618@icarus.sanera.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207241908.g6OJ8Yi29618@icarus.sanera.net>; from krishna@Sanera.net on Wed, Jul 24, 2002 at 12:08:34PM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-3.9 required=5.0 tests=IN_REP_TO,PLING version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 24, 2002 at 12:08:34PM -0700, Krishna Kondaka wrote:

> I don't think I am running preemptible kernel. Is there /proc file that shows
> if I am running preemptible kernel or not?

If the kernel you're running is from Broadcom it doesn't contain the
preemption patches.  Just check your kernel .config file for
CONFIG_PREEMPT.

  Ralf
