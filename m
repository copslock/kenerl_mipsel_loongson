Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4KFuhnC017371
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 20 May 2002 08:56:43 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4KFuhN8017366
	for linux-mips-outgoing; Mon, 20 May 2002 08:56:43 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nixon.xkey.com (nixon.xkey.com [209.245.148.124])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4KFuenC017355
	for <linux-mips@oss.sgi.com>; Mon, 20 May 2002 08:56:40 -0700
Received: (qmail 3095 invoked from network); 20 May 2002 15:57:28 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 20 May 2002 15:57:28 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id g4KFvis01763
	for linux-mips@oss.sgi.com; Mon, 20 May 2002 08:57:44 -0700
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Mon, 20 May 2002 08:57:44 -0700
From: Greg Lindahl <lindahl@keyresearch.com>
To: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020520085743.A1748@wumpus.keyresearch.com>
Mail-Followup-To: Linux-MIPS <linux-mips@oss.sgi.com>
References: <20020519123059.E20670@dea.linux-mips.net> <Pine.GSO.3.96.1020520120546.19733B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1020520120546.19733B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, May 20, 2002 at 12:06:45PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, May 20, 2002 at 12:06:45PM +0200, Maciej W. Rozycki wrote:

>  Well, the surprise is going to happen in drivers, I'm afraid...

Linux drivers as a whole are 64-bit clean; alpha's been around for a
long time. MIPS-only devices might be dirtier.

greg
