Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6VJ35Rw010165
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 31 Jul 2002 12:03:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6VJ35oC010164
	for linux-mips-outgoing; Wed, 31 Jul 2002 12:03:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f75.dialo.tiscali.de [62.246.17.75])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6VJ2xRw010151
	for <linux-mips@oss.sgi.com>; Wed, 31 Jul 2002 12:03:01 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6VJ4NO05552;
	Wed, 31 Jul 2002 21:04:23 +0200
Date: Wed, 31 Jul 2002 21:04:23 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Ryan Martindale <ryan@qsicorp.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Problem with gp
Message-ID: <20020731210423.E4892@dea.linux-mips.net>
References: <3D482FF3.11F8CA0B@qsicorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D482FF3.11F8CA0B@qsicorp.com>; from ryan@qsicorp.com on Wed, Jul 31, 2002 at 11:44:03AM -0700
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 31, 2002 at 11:44:03AM -0700, Ryan Martindale wrote:

> I seem to be having troubles getting the CVS snapshot up and running.
> I've debugged it, and it seems that the problem stems from the fact that
> $28 (gp) is modified in the SAVE_SOME macro to point to somewhere on the
> stack (not sure why this occurs). Anyways, when I get my first system
> timetick interrupt, the update_process_times function fails to get the a
> valid task structure pointer and wipes out. Why are we adjusting gp
> here, since it is explicitly expected to hold only current_thread_info?

Are you using 2.5 by chance?  2.5.x is currently pretty unstable as I'm
porting all the major changes in the upstream sources to MIPS.  I recommend
to stick with 2.4 for now.

  Ralf
