Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5UC8InC019881
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 30 Jun 2002 05:08:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5UC8Ik9019880
	for linux-mips-outgoing; Sun, 30 Jun 2002 05:08:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-65.ka.dial.de.ignite.net [62.180.196.65])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5UC8DnC019871
	for <linux-mips@oss.sgi.com>; Sun, 30 Jun 2002 05:08:14 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5UCBtm32536
	for linux-mips@oss.sgi.com; Sun, 30 Jun 2002 14:11:55 +0200
Date: Sun, 30 Jun 2002 14:11:55 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com
Subject: Re: [PATCH] Kill warning in indydog.c
Message-ID: <20020630141155.A32533@dea.linux-mips.net>
References: <20020629183223.GV17216@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020629183223.GV17216@lug-owl.de>; from jbglaw@lug-owl.de on Sat, Jun 29, 2002 at 08:32:23PM +0200
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Jun 29, 2002 at 08:32:23PM +0200, Jan-Benedict Glaw wrote:

> Please apply this patch. It fixes a warning that function declaration
> isn't a valid prototype. This applies to linux_2_4 and to HEAD.

> -static void indydog_ping()
> +static void indydog_ping(void)
>  {
>  	mcmisc_regs->watchdogt = 0;
>  }

And this tiny function better be an inline function as well ...

  Ralf
